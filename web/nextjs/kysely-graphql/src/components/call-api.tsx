'use client'
import axios from 'axios';
import { useState } from 'react';
import { AxiosError } from 'axios';

export default function CallApi() {
    const [apiResponse, setApiResponse] = useState<string>('');

    const callApi = async () => {
        try {
            const response = await axios.post<{ message: string }>('/api/example');
            setApiResponse(JSON.stringify(response.data, null, 2));
        } catch (error) {
            if (axios.isAxiosError(error)) {
                const err = error as AxiosError<{ message: string }>;
                if (err.response && err.response.data) {
                    const errorMessage = `Error ${err.response.status}: ${JSON.stringify(err.response.data, null, 2)}`;
                    setApiResponse(errorMessage);
                } else {
                    const errorMessage = `Error: ${err.message} (Code: ${err.code})`;
                    setApiResponse(errorMessage);
                }
            } else {
                setApiResponse("An unexpected error occurred");
            }
        }
    };

    return (
        <div className="z-10 w-full max-w-5xl flex flex-col items-center justify-center font-mono text-sm">
            <button onClick={callApi} className="btn btn-primary mb-4">
                Call API
            </button>
            <textarea readOnly className="textarea textarea-bordered w-full h-48" value={apiResponse}></textarea>
        </div>
    );
}

