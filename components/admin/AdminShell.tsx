"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabaseClient";

function NavLink({ href, label }: { href: string; label: string }) {
  const pathname = usePathname();
  const active = pathname === href;

  return (
    <Link
      href={href}
      className={`px-3 py-2 rounded-btn font-mono font-medium text-sm transition-colors ${
        active
          ? "bg-secondary text-bg border border-border"
          : "border border-border/60 hover:bg-secondary hover:text-bg"
      }`}
    >
      {label}
    </Link>
  );
}

export default function AdminShell({
  title,
  children,
}: Readonly<{ title: string; children: React.ReactNode }>) {
  const router = useRouter();

  const onLogout = async () => {
    await supabase.auth.signOut();
    router.replace("/admin");
  };

  return (
    <main className="min-h-screen bg-bg">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-10">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
          <div>
            <h1 className="font-display text-2xl md:text-3xl font-bold">
              <span className="scribble-underline">{title}</span>
            </h1>
          </div>
          <button
            onClick={onLogout}
            className="px-4 py-2 rounded-btn bg-secondary text-bg font-mono font-medium border border-border transition-colors hover:opacity-95"
          >
            Sair
          </button>
        </div>

        <nav className="flex flex-wrap gap-2 mb-8 pb-4 border-b border-border/30">
          <NavLink href="/admin/dashboard" label="Dashboard" />
          <NavLink href="/admin/clients" label="Clientes" />
          <NavLink href="/admin/categories" label="Categorias" />
          <NavLink href="/admin/works" label="Trabalhos" />
        </nav>

        {children}
      </div>
    </main>
  );
}
