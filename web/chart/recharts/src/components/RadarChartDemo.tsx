import { Legend, PolarAngleAxis, PolarGrid, PolarRadiusAxis, Radar, RadarChart } from "recharts";

export default function RadarChartDemo() {
    const data = [
        {
            "subject": "Math",
            "A": 120,
            "B": 110,
            "fullMark": 150
        },
        {
            "subject": "Chinese",
            "A": 98,
            "B": 130,
            "fullMark": 150
        },
        {
            "subject": "English",
            "A": 86,
            "B": 130,
            "fullMark": 150
        },
        {
            "subject": "Geography",
            "A": 99,
            "B": 100,
            "fullMark": 150
        },
        {
            "subject": "Physics",
            "A": 85,
            "B": 90,
            "fullMark": 150
        },
        {
            "subject": "History",
            "A": 65,
            "B": 85,
            "fullMark": 150
        }
    ]

    return (
        <div className="bg-white p-4 rounded-lg">
            <h2 className='text-l text-black'>Radar Chart Demo</h2>

            <RadarChart outerRadius={90} width={730} height={250} data={data}>
                <PolarGrid />
                <PolarAngleAxis dataKey="subject" />
                <PolarRadiusAxis angle={30} domain={[0, 150]} />
                <Radar name="Mike" dataKey="A" stroke="#8884d8" fill="#8884d8" fillOpacity={0.6} />
                <Radar name="Lily" dataKey="B" stroke="#82ca9d" fill="#82ca9d" fillOpacity={0.6} />
                <Legend />
            </RadarChart>
        </div>
    )
}
