'use client'
import React, {useState} from 'react'

export default function Otp() {
  const handleSendOTP = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();
    alert('OTP Sent!');
  }
  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <div className="p-6 bg-white rounded shadow-md w-full max-w-md mx-auto">
        <form onSubmit={handleSubmit} className="px-4">
          <div className="flex flex-row text-black items-center justify-center">
            <label className="text-xl m-2">OTP:</label>
            <input type="text" className="text-xl border border-black m-2 rounded flex-grow" />
          </div>
          <div className="flex flex-row text-black items-center justify-center">
            <button onClick={handleSendOTP} type="button" className="flex-grow px-4 text-xl m-2 text-white font-semibold bg-green-500 rounded">Send OTP</button>
            <button type="submit" className="flex-grow px-4 text-xl m-2 text-white font-semibold bg-blue-500 rounded">Submit</button>
          </div>
        </form>
      </div>
    </div>
  )
}