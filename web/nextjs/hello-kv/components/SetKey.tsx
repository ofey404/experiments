'use client'
import { useState } from 'react';

const SetKey = () => {
  const [key, setKey] = useState('');
  const [value, setValue] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    const response = await fetch('/api/set', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ key, value })
    });

    const data = await response.json();
    console.log(data);
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Key:
        <input type="text" value={key} onChange={(e) => setKey(e.target.value)} />
      </label>
      <label>
        Value:
        <input type="text" value={value} onChange={(e) => setValue(e.target.value)} />
      </label>
      <button type="submit">Set Key</button>
    </form>
  );
};

export default SetKey;
