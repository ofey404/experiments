'use client'
import axios from 'axios';
import { useState } from 'react';
import { AxiosError } from 'axios';

export default function Home() {
  const [apiResponse, setApiResponse] = useState<string>('');

  const callApi = async () => {
    try {
      const response = await axios.post<{ message: string }>('/api/example');
      setApiResponse(JSON.stringify(response.data, null, 2));
    } catch (error) {
      if (axios.isAxiosError(error)) {
        const err = error as AxiosError;
        setApiResponse(`Error: ${err.message}`);
      } else {
        setApiResponse("An unexpected error occurred");
      }
    }
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="z-10 w-full max-w-5xl flex flex-col items-center justify-center font-mono text-sm">
        <button onClick={callApi} className="btn btn-primary mb-4">
          Call API
        </button>
        <textarea readOnly className="textarea textarea-bordered w-full h-48" value={apiResponse}></textarea>
      </div>
    </main>
  );
}