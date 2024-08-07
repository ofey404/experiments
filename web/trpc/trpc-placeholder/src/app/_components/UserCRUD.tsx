"use client";

import { api } from "@/trpc/react";
import { useState } from "react";

export default function UserCRUD() {
    const [userId, setUserId] = useState(1);
    const [name, setName] = useState("");
    const [username, setUsername] = useState("");
    const [email, setEmail] = useState("");

    const utils = api.useUtils();
    const createUser = api.user.create.useMutation({
        onSuccess: async () => {
            await utils.user.invalidate();
        },
    });
    const [user] = api.user.get.useSuspenseQuery({ id: userId });

    const updateUser = api.user.update.useMutation({
        onSuccess: async () => {
            await utils.user.invalidate();
        },
    });
    const deleteUser = api.user.delete.useMutation({
        onSuccess: async () => {
            await utils.user.invalidate();
        },
    });

    const handleUpdate = async () => {
        if (user) {
            const updatedUser = {
                ...user,
                name: name || user.name,
                username: username || user.username,
                email: email || user.email
            };
            await updateUser.mutateAsync(updatedUser);
        }
    };

    return (
        <div className="flex flex-col gap-4">
            <input
                type="number"
                value={userId}
                onChange={(e) => setUserId(Number(e.target.value))}
                placeholder="User ID"
                className="text-black p-2 rounded"
            />
            <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Name"
                className="text-black p-2 rounded"
            />
            <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                placeholder="Username"
                className="text-black p-2 rounded"
            />
            <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Email"
                className="text-black p-2 rounded"
            />
            <div className="flex gap-2">
                <button
                    onClick={() => createUser.mutate({
                        name,
                        username,
                        email,
                        address: {
                            street: "Example St",
                            suite: "Apt 123",
                            city: "Exampleville",
                            zipcode: "12345",
                            geo: { lat: "0", lng: "0" }
                        },
                        phone: "123-456-7890",
                        website: "example.com",
                        company: {
                            name: "Example Co",
                            catchPhrase: "Just an example",
                            bs: "Making examples"
                        }
                    })}
                    className="bg-green-500 p-2 rounded"
                    disabled={createUser.isPending}
                >
                    {createUser.isPending ? "Creating..." : "Create"}
                </button>
                <button
                    onClick={handleUpdate}
                    className="bg-yellow-500 p-2 rounded"
                    disabled={updateUser.isPending || !user}
                >
                    {updateUser.isPending ? "Updating..." : "Update"}
                </button>
                <button
                    onClick={() => deleteUser.mutate({ id: userId })}
                    className="bg-red-500 p-2 rounded"
                    disabled={deleteUser.isPending}
                >
                    {deleteUser.isPending ? "Deleting..." : "Delete"}
                </button>
            </div>
            {
                user ? (
                    <div className="bg-white text-black p-4 rounded">
                        <pre>{JSON.stringify(user, null, 2)}</pre>
                    </div>
                ) : (
                    <p>Loading user...</p>
                )
            }
        </div>
    );
}