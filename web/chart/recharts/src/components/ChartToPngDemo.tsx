import FileSaver from 'file-saver';
import { useCallback } from 'react';
import { LineChart, Line, CartesianGrid, XAxis, YAxis, ResponsiveContainer } from 'recharts';
import { useGenerateImage } from 'recharts-to-png';

export default function ChartToPngDemo() {
    const [getDivJpeg, { ref }] = useGenerateImage<HTMLDivElement>({
        quality: 0.8,
        type: 'image/jpeg',
    });
    const data = [
        { name: 'Page A', uv: 400 },
        { name: 'Page B', uv: 100 },
        { name: 'Page C', uv: 300 },
        { name: 'Page D', uv: 200 },
    ];

    const handleDivDownload = useCallback(async () => {
        const jpeg = await getDivJpeg();
        if (jpeg) {
            FileSaver.saveAs(jpeg, 'line-chart.jpeg');
        }
    }, []);

    return (
        <div className="bg-white p-4 rounded-lg">
            <div ref={ref} className='w-full h-full'>
                <h2 className='text-l text-black'>Chart to Png Demo</h2>

                <LineChart width={600} height={300} data={data}>
                    <Line type="monotone" dataKey="uv" stroke="#8884d8" />
                    <CartesianGrid stroke="#ccc" />
                    <XAxis dataKey="name" />
                    <YAxis />
                </LineChart>

                <div className="flex">
                    <p className='ml-auto p-4 text-black'>Created by ofey404</p>
                </div>
            </div>
            <button className='text-l text-black bg-blue-300 px-5 py-3 rounded' onClick={handleDivDownload}>Download Png</button>
        </div>
    )
}