import ColumnFilter from "./components/ColumnFilter";
import ColumnVisibility from "./components/ColumnVisibility";
import DragDropAcrossTable from "./components/DragDropAcrossTable";
import DragDropColumn from "./components/DragDropColumn";
import DragDropRow from "./components/DragDropRow";
import ResponsiveTable from "./components/ResponsiveTable";

function App() {
  return (
    <div className="text-center bg-gray-800 min-h-screen flex flex-col items-center justify-center">
      <h1 className="text-xl text-white font-bold mb-4">React-Table Example</h1>
      <div className='flex-col w-full px-10 space-y-4'>
        <ResponsiveTable />
        <DragDropColumn />
        <DragDropRow />
        <ColumnVisibility/>
        <DragDropAcrossTable/>
        <ColumnFilter/>
      </div>
    </div>
  );
}

export default App;
