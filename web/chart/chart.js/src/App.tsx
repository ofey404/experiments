import React from 'react';
import { Radar } from 'react-chartjs-2';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";

function App() {
  const data = {
    labels: ['Running', 'Swimming', 'Cycling', 'Weightlifting', 'Yoga'],
    datasets: [
      {
        label: 'My First Dataset',
        data: [33, 53, 85, 41, 44, 65],
        fill: true,
        backgroundColor: 'rgba(75,192,192,0.2)',
        borderColor: 'rgba(75,192,192,1)',
        pointBackgroundColor: 'rgba(75,192,192,1)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgba(75,192,192,1)'
      }
    ]
  };

  const options = {
    scale: {
      ticks: { beginAtZero: true },
    },
  };

  ChartJS.register(ArcElement, Tooltip, Legend);


  return (
    <main>
      <div className="text-center bg-gray-800 min-h-screen flex flex-col items-center justify-center text-white text-[calc(10px + 2vmin)]">
        <h1 className="text-xl font-bold mb-4">Chart.js</h1>
        <div className="bg-white p-4 rounded-lg">
          <Radar data={data} />
        </div>
      </div>
    </main>
  );
}

export default App;
