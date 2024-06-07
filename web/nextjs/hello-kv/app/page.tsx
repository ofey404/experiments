import GetKey from "@/components/GetKey";
import SetKey from "@/components/SetKey";

export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <div className="p-6 bg-white rounded shadow-md w-full max-w-md mx-auto">
        <SetKey />
      </div>
      <div className="p-6 mt-6 bg-white rounded shadow-md w-full max-w-md mx-auto">
        <GetKey />
      </div>
    </div>
  )
}
