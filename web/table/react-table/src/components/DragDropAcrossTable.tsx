import React, { CSSProperties } from 'react'
import ReactDOM from 'react-dom/client'

import {
    ColumnDef,
    Row,
    flexRender,
    getCoreRowModel,
    useReactTable,
} from '@tanstack/react-table'
import { makeData, Person } from './makeData'

// needed for table body level scope DnD setup
import {
    DndContext,
    KeyboardSensor,
    MouseSensor,
    TouchSensor,
    closestCenter,
    type DragEndEvent,
    type UniqueIdentifier,
    useSensor,
    useSensors,
} from '@dnd-kit/core'
import { restrictToVerticalAxis } from '@dnd-kit/modifiers'
import {
    arrayMove,
    SortableContext,
    verticalListSortingStrategy,
} from '@dnd-kit/sortable'

// needed for row & cell level scope DnD setup
import { useSortable } from '@dnd-kit/sortable'
import { CSS } from '@dnd-kit/utilities'

// Cell Component
const RowDragHandleCell = ({ rowId }: { rowId: string }) => {
    const { attributes, listeners } = useSortable({
        id: rowId,
    })
    return (
        // Alternatively, you could set these attributes on the rows themselves
        <button {...attributes} {...listeners}>
            🟰
        </button>
    )
}

// Row Component
const DraggableRow = ({ row }: { row: Row<Person> }) => {
    const { transform, transition, setNodeRef, isDragging } = useSortable({
        id: row.original.userId,
    })

    const style: CSSProperties = {
        transform: CSS.Transform.toString(transform), //let dnd-kit do its thing
        transition: transition,
        opacity: isDragging ? 0.8 : 1,
        zIndex: isDragging ? 1 : 0,
        position: 'relative',
    }
    return (
        // connect row ref to dnd-kit, apply important styles
        <tr ref={setNodeRef} style={style}>
            {row.getVisibleCells().map(cell => (
                <td key={cell.id} style={{ width: cell.column.getSize() }}>
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </td>
            ))}
        </tr>
    )
}

export default function DragDropAcrossTable() {
    const columns = React.useMemo<ColumnDef<Person>[]>(
        () => [
            // Create a dedicated drag handle column. Alternatively, you could just set up dnd events on the rows themselves.
            {
                id: 'drag-handle',
                header: 'Move',
                cell: ({ row }) => <RowDragHandleCell rowId={row.id} />,
                size: 60,
            },
            {
                accessorKey: 'firstName',
                cell: info => info.getValue(),
            },
            {
                accessorFn: row => row.lastName,
                id: 'lastName',
                cell: info => info.getValue(),
                header: () => <span>Last Name</span>,
            },
            {
                accessorKey: 'age',
                header: () => 'Age',
            },
            {
                accessorKey: 'visits',
                header: () => <span>Visits</span>,
            },
            {
                accessorKey: 'status',
                header: 'Status',
            },
            {
                accessorKey: 'progress',
                header: 'Profile Progress',
            },
        ],
        []
    )
    // 将原始数据分为两组，每组一个表格
    const [data1, setData1] = React.useState(() => makeData(10))
    const [data2, setData2] = React.useState(() => makeData(10))

    const data1Ids = React.useMemo<UniqueIdentifier[]>(
        () => data1?.map(({ userId }) => userId),
        [data1]
    )
    const data2Ids = React.useMemo<UniqueIdentifier[]>(
        () => data2?.map(({ userId }) => userId),
        [data2]
    )

    const rerender = () => {
        setData1(() => makeData(10))
        setData2(() => makeData(10))
    }

    const table1 = useReactTable({
        data: data1,
        columns,
        getCoreRowModel: getCoreRowModel(),
        getRowId: row => row.userId, //required because row indexes will change
        debugTable: true,
        debugHeaders: true,
        debugColumns: true,
    })

    const table2 = useReactTable({
        data: data2,
        columns,
        getCoreRowModel: getCoreRowModel(),
        getRowId: row => row.userId, //required because row indexes will change
        debugTable: true,
        debugHeaders: true,
        debugColumns: true,
    })

    // reorder rows after drag & drop
    function handleDragEnd(event: DragEndEvent) {
        const { active, over } = event
        if (active && over && active.id !== over.id) {
        const oldIndex = data1Ids.indexOf(active.id)
        const newIndex = data1Ids.indexOf(over.id)
        const oldIndex2 = data2Ids.indexOf(active.id)
        const newIndex2 = data2Ids.indexOf(over.id)
        if (oldIndex !== -1 && newIndex !== -1) {
            setData1(data => arrayMove(data, oldIndex, newIndex))
        }
        if (oldIndex2 !== -1 && newIndex2 !== -1) {
            setData2(data => arrayMove(data, oldIndex2, newIndex2))
        }
        if (oldIndex !== -1 && newIndex2 !== -1) {
            setData1(data => data.filter((_, idx) => idx !== oldIndex))
            setData2(data => [...data, data[oldIndex]])
        }
        if (oldIndex2 !== -1 && newIndex !== -1) {
            setData2(data => data.filter((_, idx) => idx !== oldIndex2))
            setData1(data => [...data, data2[oldIndex2]])
        }
        }
    }

    const sensors = useSensors(
        useSensor(MouseSensor, {}),
        useSensor(TouchSensor, {}),
        useSensor(KeyboardSensor, {})
    )

    return (
        <div className="overflow-x-auto bg-white p-4 rounded-lg">
            <h2 className='text-l text-black'>Drag And Drop Across Table Demo</h2>
            <DndContext
                collisionDetection={closestCenter}
                modifiers={[restrictToVerticalAxis]}
                onDragEnd={handleDragEnd}
                sensors={sensors}
            >
                <div className="p-2">
                    <div className="h-4" />
                    <div className="flex flex-wrap gap-2">
                        <button onClick={() => rerender()} className="border p-1">
                            Regenerate
                        </button>
                    </div>
                    <div className="h-4" />
                    <table>
                        <thead>
                            {table1.getHeaderGroups().map(headerGroup => (
                                <tr key={headerGroup.id}>
                                    {headerGroup.headers.map(header => (
                                        <th key={header.id} colSpan={header.colSpan}>
                                            {header.isPlaceholder
                                                ? null
                                                : flexRender(
                                                    header.column.columnDef.header,
                                                    header.getContext()
                                                )}
                                        </th>
                                    ))}
                                </tr>
                            ))}
                        </thead>
                        <tbody>
                            <SortableContext
                                items={data1Ids}
                                strategy={verticalListSortingStrategy}
                            >
                                {table1.getRowModel().rows.map(row => (
                                    <DraggableRow key={row.id} row={row} />
                                ))}
                            </SortableContext>
                        </tbody>
                    </table>

                    <table>
                        <thead>
                            {table2.getHeaderGroups().map(headerGroup => (
                                <tr key={headerGroup.id}>
                                    {headerGroup.headers.map(header => (
                                        <th key={header.id} colSpan={header.colSpan}>
                                            {header.isPlaceholder
                                                ? null
                                                : flexRender(
                                                    header.column.columnDef.header,
                                                    header.getContext()
                                                )}
                                        </th>
                                    ))}
                                </tr>
                            ))}
                        </thead>
                        <tbody>
                            <SortableContext
                                items={data2Ids}
                                strategy={verticalListSortingStrategy}
                            >
                                {table2.getRowModel().rows.map(row => (
                                    <DraggableRow key={row.id} row={row} />
                                ))}
                            </SortableContext>
                        </tbody>
                    </table>
                    {/* <pre>{JSON.stringify(data, null, 2)}</pre> */}
                </div>
            </DndContext>
        </div >
    )

}