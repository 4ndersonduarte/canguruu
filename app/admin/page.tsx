"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabaseClient";

export default function AdminLoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;

    const run = async () => {
      const { data } = await supabase.auth.getUser();
      if (!mounted) return;

      const role = data.user?.app_metadata?.role;
      if (data.user && role === "admin") {
        router.replace("/admin/dashboard");
      }
    };

    run();

    return () => {
      mounted = false;
    };
  }, [router]);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) {
        setError(signInError.message);
        return;
      }

      const { data } = await supabase.auth.getUser();
      const role = data.user?.app_metadata?.role;

      if (role !== "admin") {
        await supabase.auth.signOut();
        setError("Sem permissão de admin.");
        return;
      }

      router.replace("/admin/dashboard");
    } finally {
      setLoading(false);
    }
  };

  return (
    <main className="min-h-screen flex items-center justify-center p-6 bg-bg">
      <div className="w-full max-w-md rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 p-8">
        <div className="flex flex-col items-center mb-8">
          <div className="mb-6">
            <img src="/canguruu.svg" alt="Canguruu" className="w-24 h-24 object-contain" />
          </div>
          <h1 className="font-display text-2xl md:text-3xl font-bold text-center">
            <span className="scribble-underline">Admin</span>
          </h1>
          <p className="text-text-secondary text-sm text-center mt-2">
            Faça login para gerenciar clientes e trabalhos.
          </p>
        </div>

        <form onSubmit={onSubmit} className="space-y-5">
          <div className="space-y-2">
            <label className="text-sm font-medium">Email</label>
            <input
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              type="email"
              className="w-full px-4 py-2 rounded-lg border border-border bg-bg focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all"
              autoComplete="email"
              placeholder="seu@email.com"
              required
            />
          </div>

          <div className="space-y-2">
            <label className="text-sm font-medium">Senha</label>
            <input
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              type="password"
              className="w-full px-4 py-2 rounded-lg border border-border bg-bg focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all"
              autoComplete="current-password"
              placeholder="••••••••"
              required
            />
          </div>

          {error ? (
            <div className="text-sm text-red-500 bg-red-50 border border-red-200 rounded-lg p-3">{error}</div>
          ) : null}

          <button
            type="submit"
            disabled={loading}
            className="w-full px-4 py-2 rounded-btn bg-secondary text-bg font-medium border border-border shadow-glow -translate-y-0.5 transition-all disabled:opacity-60 disabled:shadow-none disabled:translate-y-0"
          >
            {loading ? "Entrando..." : "Entrar"}
          </button>
        </form>
      </div>
    </main>
  );
}
