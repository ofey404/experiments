import React from 'react';
import logo from './logo.svg';

function App() {
  return (
    <div className="bg-gray-100 h-screen w-screen">
      <div className='px-8 py-4 max-w-md mx-auto'>
        <div className='flex items-center'>
          <img src={logo} className="h-[10vmin] pointer-events-none" alt="logo" />
          <label className='text-2xl font-bold text-cyan-500'>Tailwind Example</label>
        </div>
        <img
          src="https://via.placeholder.com/1920x1080"
          className="rounded-lg shadow-xl pointer-events-none mt-2"
          alt="my first image"
        />
        <h1 className='mt-6 text-xl font-semibold text-gray-900 leading-tight'>
          This example showcases tailwind css basic usage.{" "}
          <span className='text-cyan-500' >Check the source code for more.</span>
        </h1>
        <p className='mt-2 text-gray-600'>
          The Utility-First Workflow:
          Learn how to use Tailwind's utility classes to build a custom marketing page.
        </p>
        <div className='mt-4'>
          <a href="#" className='inline-block bg-cyan-600 text-white px-5 py-3 rounded-lg shadow-lg uppercase tracking-wide'>
            Check the original tutorial
          </a>
        </div>
      </div>
    </div>
  );
}

export default App;
