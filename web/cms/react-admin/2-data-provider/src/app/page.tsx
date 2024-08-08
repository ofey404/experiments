import { HydrateClient } from "@/trpc/server";
import { AdminApp } from "./AdminApp";

export default function Home() {
  return (
    <HydrateClient>
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c] text-white">
        <AdminApp />
      </main>
    </HydrateClient>
  );
}
