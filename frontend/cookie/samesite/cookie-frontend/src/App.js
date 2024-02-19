import logo from "./logo.svg";
import "./App.css";
import { useEffect, useState } from "react";

function App() {
  const [getCookieUrl, setGetCookieUrl] = useState(
    "http://localhost:8080/api/getcookie"
  );
  const [printCookieUrl, setPrintCookieUrl] = useState(
    "http://localhost:8080/api/printcookie"
  );

  const onGetCookieSubmit = (event) => {
    event.preventDefault();

    console.log("getCookieUrl: ", getCookieUrl);
    fetch(getCookieUrl).catch((error) => console.log("error: ", error));
  };

  const onPrintCookieSubmit = (event) => {
    event.preventDefault();

    console.log("printCookieUrl: ", printCookieUrl);
    fetch(printCookieUrl).catch((error) => console.log("error: ", error));
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <form onSubmit={onGetCookieSubmit}>
          <input
            name="getCookieUrl"
            onChange={(event) => setGetCookieUrl(event.target.value)}
            value={getCookieUrl}
          />
          <button type="submit">GetCookie</button>
        </form>

        <form onSubmit={onPrintCookieSubmit}>
          <input
            name="printCookieUrl"
            onChange={(event) => setPrintCookieUrl(event.target.value)}
            value={printCookieUrl}
          />
          <button type="submit">PrintCookieAtBackend</button>
        </form>
      </header>
    </div>
  );
}

export default App;
