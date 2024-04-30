import { LineChart, Line, CartesianGrid, XAxis, YAxis } from 'recharts';

export default function LineChartDemo() {
  const data = [
    { name: 'Page A', uv: 400 },
    { name: 'Page B', uv: 100 },
    { name: 'Page C', uv: 300 },
    { name: 'Page D', uv: 200 },
  ];

  return (
    <div className="bg-white p-4 rounded-lg">
      <h2 className='text-l text-black'>Line Chart Demo</h2>

      <LineChart width={600} height={300} data={data}>
        <Line type="monotone" dataKey="uv" stroke="#8884d8" />
        <CartesianGrid stroke="#ccc" />
        <XAxis dataKey="name" />
        <YAxis />
      </LineChart>
    </div>
  )

}