import React from 'react';
import logo from './logo.svg';
import { Howl, Howler } from 'howler';

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
        <button
          className='bg-blue-500 inline-block px-5 py-3 rounded-lg uppercase tracking-wide'
          onClick={() => {
            var sound = new Howl({
              src: ['/speech.mp3']
            });
            sound.play();
          }}
        >Play MP3</button>
      </header>
    </div>

  );
}

export default App;
