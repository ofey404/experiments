'use client'
import { useState, useEffect, useRef } from 'react';

export default function Otp() {
  const [requested, setRequested] = useState(false);
  const [expiryTime, setExpiryTime] = useState<Date | null>(null);
  const [timeLeft, setTimeLeft] = useState(60); // Store the countdown in state
  const timer = useRef<NodeJS.Timeout | null>(null);

  const handleSendOTP = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();
    setRequested(true);
    setExpiryTime(new Date(new Date().getTime() + 60 * 1000)); // Set expiry time to 1 minute from now
    alert("OTP sent successfully")
  }

  useEffect(() => {
    if (requested && expiryTime) {
      timer.current = setInterval(() => {
        const now = new Date();
        const distance = expiryTime.getTime() - now.getTime();
        if (distance <= 0) {
          clearInterval(timer.current!);
          setRequested(false);
          setExpiryTime(null);
          setTimeLeft(60);
        } else {
          setTimeLeft(Math.ceil(distance / 1000)); // Update the countdown
        }
      }, 1000);
    }
    return () => {
      if (timer.current) {
        clearInterval(timer.current!);
      }
    };
  }, [requested, expiryTime]);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <div className="p-6 bg-white rounded shadow-md w-full max-w-md mx-auto">
        <form onSubmit={handleSubmit} className="px-4">
          <div className="flex flex-row text-black items-center justify-center">
            <label className="text-xl m-2">OTP:</label>
          </div>
          <div className="flex flex-row text-black items-center justify-center">
            <button
              disabled={requested}
              onClick={handleSendOTP}
              type="button"
              className={`flex-grow px-4 text-xl m-2 text-white font-semibold rounded ${requested ? 'bg-red-500' : 'bg-green-500'}`}
            >
              {requested ? `Resend OTP (${timeLeft})` : 'Send OTP'}
            </button>
            <button type="submit"
              className="w-32 px-4 text-xl m-2 text-white font-semibold bg-blue-500 rounded">Submit
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
