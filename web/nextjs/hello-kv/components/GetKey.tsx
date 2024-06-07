'use client'
import { get } from '@/libs/api';
import { AppError, ErrKeyNotFound, ErrMissingKey } from '@/libs/errors';
import { useState } from 'react';

const GetKey = () => {
  const [key, setKey] = useState('');
  const [value, setValue] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    try {
      const response = await get({ key })
      setValue(response.reply);
    } catch (e) {
      if (e instanceof AppError) {
        if (ErrMissingKey.is(e)) {
          alert(ErrMissingKey.message)
        } else if (ErrKeyNotFound.is(e)) {
          alert(ErrKeyNotFound.message)
        } else {
          alert(e.message) // common
        }
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
      <button type="submit" className="w-full p-2 button-blue-rounded">Get Key</button>
      <p className='text-black'>Value: {value}</p>
    </form>
  );
};

export default GetKey;
