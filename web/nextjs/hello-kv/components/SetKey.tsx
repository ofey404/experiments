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
    <form onSubmit={handleSubmit} className="space-y-4">
      <label className="flex flex-col">
        Key:
        <input type="text" value={key} onChange={(e) => setKey(e.target.value)} className="border p-2 rounded text-black" />
      </label>
      <label className="flex flex-col">
        Value:
        <input type="text" value={value} onChange={(e) => setValue(e.target.value)} className="border p-2 rounded text-black" />
      </label>
      <button type="submit" className="w-full p-2 text-white bg-blue-500 rounded">Set Key</button>
    </form>
  );
};

export default SetKey;
