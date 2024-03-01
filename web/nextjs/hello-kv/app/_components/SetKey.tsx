'use client'
import { useState } from 'react';
import { SetRequest, SetResponse } from '../api/set/types';

const SetKey = () => {
  const [key, setKey] = useState('');
  const [value, setValue] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    const requestBody: SetRequest = { key, value };

    const response = await fetch('/api/set', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(requestBody)
    });

    const data: SetResponse = await response.json();
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
      <button type="submit" className="w-full p-2 button-blue-rounded">Set Key</button>
    </form>
  );
};

export default SetKey;
