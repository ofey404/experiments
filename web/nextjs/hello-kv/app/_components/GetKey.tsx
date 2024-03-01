'use client'
import { useState } from 'react';

const GetKey = () => {
  const [key, setKey] = useState('');
  const [value, setValue] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    const response = await fetch(`/api/get?key=${key}`);
    const data = await response.json();
    setValue(data.reply);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <label className="flex flex-col">
        Key:
        <input type="text" value={key} onChange={(e) => setKey(e.target.value)} className="border p-2 rounded text-black" />
      </label>
      <button type="submit" className="w-full p-2 button-blue-rounded">Get Key</button>
      <p className='text-black'>Value: {value}</p>
    </form>
  );
};

export default GetKey;
