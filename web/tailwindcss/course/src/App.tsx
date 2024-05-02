import React from 'react';
import logo from './logo.svg';

function App() {
  return (
    <div className="bg-gray-100 h-screen w-screen">
      <div className="flex">
        <div className='px-8 py-4 max-w-md lg:max-w-full mx-auto lg:w-1/2 lg:py-24 lg:px-12'>
          <div className="xl:max-w-lg xl:ml-auto">
            <div className='flex items-center'>
              <img src={logo} className="h-[10vmin] pointer-events-none" alt="logo" />
              <label className='text-2xl font-bold text-cyan-500'>Tailwind Example</label>
            </div>
            <img
              src="https://via.placeholder.com/1920x1080"
              className="rounded-lg shadow-xl pointer-events-none mt-2 lg:hidden"
              alt="my first image"
            />
            <h1 className='mt-6 text-xl lg:text-3xl font-semibold lg:font-bold text-gray-900 leading-tight'>
              Showcase tailwind css basic usage.{" "}
              <br className='hidden lg:inline' />
              <span className='text-cyan-500' >Check the source code for more.</span>
            </h1>
            <p className='mt-2 text-gray-600'>
              The Utility-First Workflow:
              Learn how to use Tailwind's utility classes to build a custom marketing page.
            </p>
            <div className='mt-4 flex space-x-1'>
              <div>
                <a href="#" className='btn-cyan shadow-lg h-full'>
                  The original tutorial
                </a>
              </div>
              <div>
                <a href="#" className='btn-grey shadow-lg h-full'>
                  More
                </a>
              </div>
            </div>
          </div>
        </div>
        <div className='hidden lg:block lg:w-1/2 lg:relative'>
          <img
            src="https://via.placeholder.com/1920x1080"
            className="absolute inset-0 h-full object-cover"
            alt="my first image"
          />
        </div>
      </div>
    </div>
  );
}

export default App;
