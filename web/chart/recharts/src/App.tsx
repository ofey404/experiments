import React from 'react';
import LineChartDemo from './components/LineChartDemo';
import RadarChartDemo from './components/RadarChartDemo';
import ScatterChartDemo from './components/ScatterChartDemo';


function App() {
  return (
    <main>
      <div className="text-center bg-gray-800 min-h-screen flex flex-col items-center justify-center text-white text-[calc(10px + 2vmin)]">
        <h1 className="text-xl font-bold mb-4">ReCharts Example</h1>
        <div className='flex-col'>
          <LineChartDemo />
          <RadarChartDemo />
          <ScatterChartDemo />
        </div>
      </div>
    </main>
  );
}

export default App;
