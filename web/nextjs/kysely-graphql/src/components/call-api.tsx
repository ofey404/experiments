'use client'
import { useState } from 'react';
import { ApolloClient, InMemoryCache, gql } from '@apollo/client';

export default function CallApi() {
    const [apiResponse, setApiResponse] = useState<string>('');

    const callApi = async () => {
        try {
            const client = new ApolloClient({
                uri: '/api/graphql',
                cache: new InMemoryCache()
            });

            const { data } = await client.query({
                query: gql`
                    query GetKeyValue {
                        getKeyValue {
                            key
                            value
                        }
                    }
                `
            });

            setApiResponse(JSON.stringify(data, null, 2));
        } catch (error) {
            if (error instanceof Error) {
                setApiResponse(`Error: ${error.message}`);
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

