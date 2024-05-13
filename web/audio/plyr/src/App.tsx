import React from 'react';
import logo from './logo.svg';
import Plyr from "plyr-react"
import "plyr-react/plyr.css"

function App() {
  return (
    <div className="text-center">
      <header className="bg-gray-800 min-h-screen flex flex-col items-center justify-center text-white text-[calc(10px + 2vmin)]">
        <img src={logo} className="h-[40vmin] pointer-events-none" alt="logo" />
        <p>
          Edit <code className='font-mono'>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="text-blue-300"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <div className='w-full fixed inset-x-0 bottom-0 '>
          <Plyr
            source={
              {
                type: "audio",
                sources: [
                  {
                    src: "/speech.mp3",
                    type: "audio/mp3"
                  }
                ]
              }
            }

          />
        </div>
      </header>
    </div>
  );
}

export default App;
