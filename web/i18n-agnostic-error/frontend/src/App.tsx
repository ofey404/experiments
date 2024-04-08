import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import logo from './logo.svg';
import './App.css';

function App() {
  const { t, i18n } = useTranslation();
  const [index, setIndex] = useState(0);
  const l = ["en", "zh"]

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          {t('Welcome to React')}
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <button onClick={() => {
          i18n.changeLanguage(l[index])
          setIndex((index + 1) % l.length)
        }}>Switch Language</button>
      </header>
    </div>
  );
}

export default App;
