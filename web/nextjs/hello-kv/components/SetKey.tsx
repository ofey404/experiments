'use client'
import { set } from '@/libs/api';
import { AppError } from '@/libs/errors';
import { useState } from 'react';

const SetKey = () => {
  const [key, setKey] = useState('');
  const [value, setValue] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    try {
      await set({ key, value })
    } catch (e) {
      if (e instanceof AppError) {
        alert(e.message)
      } else {
        throw e
      }
    }
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
