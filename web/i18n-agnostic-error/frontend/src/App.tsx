import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import logo from './logo.svg';
import './App.css';

interface Response {
  code: number;
  message: string;
  values?: { [key: string]: any };
}

function App() {
  const { t, i18n } = useTranslation();
  const [index, setIndex] = useState(0);
  const l = ["en", "zh"]

  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const fetchData = async () => {
    const url = "http://localhost:8888/api/get";

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({}),
      });

      const data: Response = await response.json();
      console.log(data);

      if (!response.ok) {
        setErrorMessage(t("Invalid request", data.values))
      }
    } catch (error) {
      console.error(error);
    }
  };



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
        <p>{t("Key Value Example", { value1: "v1", value2: "v2" })}</p>
        <button onClick={() => {
          i18n.changeLanguage(l[index])
          setIndex((index + 1) % l.length)
        }}>Switch Language</button>

        <button onClick={() => { fetchData() }}>Call backend API</button>
        {errorMessage && <>
          <h2>Error Message:</h2>
          <p>{errorMessage}</p>
        </>}
      </header>
    </div>
  );
}

export default App;
