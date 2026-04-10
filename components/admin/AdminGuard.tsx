"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabaseClient";

export default function AdminGuard({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  const router = useRouter();
  const [ready, setReady] = useState(false);

  useEffect(() => {
    let mounted = true;

    const run = async () => {
      const { data } = await supabase.auth.getUser();
      const role = data.user?.app_metadata?.role;

      if (!mounted) return;

      if (!data.user || role !== "admin") {
        if (data.user) {
          await supabase.auth.signOut();
        }
        router.replace("/admin");
        return;
      }

      setReady(true);
    };

    run();

    return () => {
      mounted = false;
    };
  }, [router]);

  if (!ready) {
    return (
      <main className="min-h-screen flex items-center justify-center p-6">
        <div className="text-text-secondary text-sm">Carregando...</div>
      </main>
    );
  }

  return <>{children}</>;
}
