import React, {useState} from 'react';
import './App.css';

interface GetRequest {
    key: string;
}

interface GetResponse {
    value: string;
}

interface SetRequest {
    key: string;
    value: string;
}

function App() {
    const [key, setKey] = useState("");
    const [value, setValue] = useState("");
    const [result, setResult] = useState("");

    const handleSet = async (e: React.FormEvent) => {
        e.preventDefault();

        const data: SetRequest = {
            key,
            value,
        };

        try {
            const response = await fetch("http://localhost:8888/api/set", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(data),
            });

            if (response.ok) {
                setResult("Set successful!");
            } else {
                setResult("Set failed!");
            }
        } catch (error) {
            console.error(error);
            setResult("Set failed!");
        }
    };

    const handleGet = async (e: React.FormEvent) => {
        e.preventDefault();

        const data: GetRequest = {
            key,
        };

        try {
            const response = await fetch("http://localhost:8888/api/get", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(data),
            });

            if (response.ok) {
                const responseData: GetResponse = await response.json();
                setResult(`Value: ${responseData.value}`);
            } else {
                setResult(`Get failed!, return code ${response.status}`);
            }
        } catch (error) {
            console.error(error);
            setResult("Get failed!");
        }
    };

    return (
        <div className="App">
            <h1>Key-Value Store</h1>
            <form onSubmit={handleSet}>
                <label htmlFor="setKey">Key:</label>
                <input
                    type="text"
                    id="setKey"
                    value={key}
                    onChange={(e) => setKey(e.target.value)}
                    required
                />
                <label htmlFor="setValue">Value:</label>
                <input
                    type="text"
                    id="setValue"
                    value={value}
                    onChange={(e) => setValue(e.target.value)}
                    required
                />
                <button type="submit">Set</button>
            </form>
            <br/>
            <form onSubmit={handleGet}>
                <label htmlFor="getKey">Key:</label>
                <input
                    type="text"
                    id="getKey"
                    value={key}
                    onChange={(e) => setKey(e.target.value)}
                    required
                />
                <button type="submit">Get</button>
            </form>
            <br/>
            <div>{result}</div>
        </div>
    );
}

export default App;
