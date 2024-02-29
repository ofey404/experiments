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
    <form onSubmit={handleSubmit}>
      <label>
        Key:
        <input type="text" value={key} onChange={(e) => setKey(e.target.value)} />
      </label>
      <button type="submit">Get Key</button>
      <p>Value: {value}</p>
    </form>
  );
};

export default GetKey;
