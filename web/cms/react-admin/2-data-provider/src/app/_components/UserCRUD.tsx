"use client";

import { api } from "@/trpc/react";
import { useState } from "react";

export default function UserCRUD() {
    const [userId, setUserId] = useState<number | null>(null);
    const [name, setName] = useState("");
    const [username, setUsername] = useState("");
    const [email, setEmail] = useState("");

    const utils = api.useUtils();
    const createUser = api.user.create.useMutation({
        onSuccess: async () => {
            await utils.user.invalidate();
        },
    });
    const [userList] = api.user.list.useSuspenseQuery({});

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
        if (userId === null) return;
        const user = userList.find(u => u.id === userId);
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

    const newUserId = userList.length > 0 ? Math.max(...userList.map(u => u.id)) + 1 : 1;

    return (
        <div className="flex flex-col gap-4">
            <div className="flex flex-col gap-2">
                <label htmlFor="userId" className="text-white">User ID:</label>
                <select
                    id="userId"
                    value={userId ?? ""}
                    onChange={(e) => setUserId(Number(e.target.value))}
                    className="text-black p-2 rounded"
                >
                    <option value="">Select a user</option>
                    {userList.map(user => (
                        <option key={user.id} value={user.id}>{user.id} - {user.name}</option>
                    ))}
                    <option value={newUserId}>New User (ID: {newUserId})</option>
                </select>
            </div>
            <div className="flex flex-col gap-2">
                <label htmlFor="name" className="text-white">Name:</label>
                <input
                    id="name"
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    className="text-black p-2 rounded"
                />
            </div>
            <div className="flex flex-col gap-2">
                <label htmlFor="username" className="text-white">Username:</label>
                <input
                    id="username"
                    type="text"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    className="text-black p-2 rounded"
                />
            </div>
            <div className="flex flex-col gap-2">
                <label htmlFor="email" className="text-white">Email:</label>
                <input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="text-black p-2 rounded"
                />
            </div>
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
                    disabled={updateUser.isPending || userId === null}
                >
                    {updateUser.isPending ? "Updating..." : "Update"}
                </button>
                <button
                    onClick={() => userId !== null && deleteUser.mutate({ id: userId })}
                    className="bg-red-500 p-2 rounded"
                    disabled={deleteUser.isPending || userId === null}
                >
                    {deleteUser.isPending ? "Deleting..." : "Delete"}
                </button>
            </div>
            {
                userId !== null && userList.some(u => u.id === userId) ? (
                    <div className="bg-white text-black p-4 rounded">
                        <pre>{JSON.stringify(userList.find(u => u.id === userId), null, 2)}</pre>
                    </div>
                ) : (
                    <p>No user selected</p>
                )
            }
        </div>
    );
}