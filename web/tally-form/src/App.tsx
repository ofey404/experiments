import React, { useEffect } from 'react';
import logo from './logo.svg';

function App() {
  useEffect(() => {
    const script = document.createElement('script');
    script.src = "https://tally.so/widgets/embed.js";
    script.async = true;
    document.body.appendChild(script);

    // cleanup on component unmount
    return () => {
      document.body.removeChild(script);
    }
  }, []);

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
        <button data-tally-open="nrlr4R" data-tally-emoji-text="👋" data-tally-emoji-animation="wave">Click me</button>
      </header>
    </div>

  );
}

export default App;
