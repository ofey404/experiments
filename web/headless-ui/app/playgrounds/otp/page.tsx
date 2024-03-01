'use client'
import { useState, useEffect } from 'react';

export default function Otp() {
  const [isDisabled, setIsDisabled] = useState(false);
  const [countdown, setCountdown] = useState(60);

  const handleSendOTP = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();
    alert('OTP Sent!');
    setIsDisabled(true);
  }

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isDisabled && countdown > 0) {
      interval = setInterval(() => {
        setCountdown(countdown - 1);
      }, 1000);
    } else if (countdown === 0) {
      setIsDisabled(false);
      setCountdown(60);
    }
    return () => {
      clearInterval(interval);
    };
  }, [isDisabled, countdown]);

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
            <button disabled={isDisabled} onClick={handleSendOTP} type="button" className={isDisabled ? "flex-grow px-4 text-xl m-2 text-white font-semibold bg-red-500 rounded" : "flex-grow px-4 text-xl m-2 text-white font-semibold bg-green-500 rounded"}>
              {isDisabled ? `Resend OTP (${countdown})` : 'Send OTP'}
            </button>
            <button type="submit" className="w-32 px-4 text-xl m-2 text-white font-semibold bg-blue-500 rounded">Submit</button>
          </div>
        </form>
      </div>
    </div>
  )
}
