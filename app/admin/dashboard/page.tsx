"use client";

import { useEffect, useState } from "react";
import AdminGuard from "@/components/admin/AdminGuard";
import AdminShell from "@/components/admin/AdminShell";
import { supabase } from "@/lib/supabaseClient";

export default function AdminDashboardPage() {
  const [email, setEmail] = useState<string | null>(null);

  useEffect(() => {
    const run = async () => {
      const { data } = await supabase.auth.getUser();
      setEmail(data.user?.email ?? null);
    };

    run();
  }, []);

  return (
    <AdminGuard>
      <AdminShell title="Dashboard">
        <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
          <h2 className="font-display text-lg font-bold mb-4">Bem-vindo</h2>
          <p className="text-sm text-text-secondary mb-4">
            Você está logado como administrador.
          </p>
          <div className="text-sm font-medium mb-2">Email do usuário:</div>
          <div className="text-sm text-text-secondary">{email}</div>
        </div>
      </AdminShell>
    </AdminGuard>
  );
}
