import CallApi from '@/components/call-api';
import { SignIn } from '@/components/signin-button';
import { SignOut } from '@/components/signout-button';

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <nav className="w-full flex justify-between px-10 py-4 bg-gray-800 text-white">
        <div className="flex items-center">
          <h1 className="text-lg font-bold">API Caller</h1>
        </div>
        <div className="flex items-center gap-4">
          <SignIn />
          <SignOut />
        </div>
      </nav>
      <CallApi/>
    </main>
  );
}