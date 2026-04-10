"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import AdminGuard from "@/components/admin/AdminGuard";
import AdminShell from "@/components/admin/AdminShell";
import { supabase } from "@/lib/supabaseClient";

type ClientRow = {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  created_at: string;
};

export default function AdminClientsPage() {
  const [rows, setRows] = useState<ClientRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [newName, setNewName] = useState("");
  const [newSlug, setNewSlug] = useState("");
  const [newLogoUrl, setNewLogoUrl] = useState("");

  const [editingId, setEditingId] = useState<string | null>(null);
  const [editName, setEditName] = useState("");
  const [editSlug, setEditSlug] = useState("");
  const [editLogoUrl, setEditLogoUrl] = useState("");

  const canCreate = useMemo(() => {
    return newName.trim().length > 0 && newSlug.trim().length > 0;
  }, [newName, newSlug]);

  const load = async () => {
    setError(null);
    setLoading(true);

    const { data, error: e } = await supabase
      .from("clients")
      .select("id,name,slug,logo_url,created_at")
      .order("created_at", { ascending: false });

    if (e) {
      setError(e.message);
      setLoading(false);
      return;
    }

    setRows((data ?? []) as ClientRow[]);
    setLoading(false);
  };

  useEffect(() => {
    load();
  }, []);

  const startEdit = (r: ClientRow) => {
    setEditingId(r.id);
    setEditName(r.name);
    setEditSlug(r.slug);
    setEditLogoUrl(r.logo_url ?? "");
  };

  const cancelEdit = () => {
    setEditingId(null);
    setEditName("");
    setEditSlug("");
    setEditLogoUrl("");
  };

  const onCreate = async () => {
    setError(null);

    const { error: e } = await supabase.from("clients").insert({
      name: newName.trim(),
      slug: newSlug.trim(),
      logo_url: newLogoUrl.trim() ? newLogoUrl.trim() : null,
    });

    if (e) {
      setError(e.message);
      return;
    }

    setNewName("");
    setNewSlug("");
    setNewLogoUrl("");
    await load();
  };

  const onSave = async () => {
    if (!editingId) return;
    setError(null);

    const { error: e } = await supabase
      .from("clients")
      .update({
        name: editName.trim(),
        slug: editSlug.trim(),
        logo_url: editLogoUrl.trim() ? editLogoUrl.trim() : null,
      })
      .eq("id", editingId);

    if (e) {
      setError(e.message);
      return;
    }

    cancelEdit();
    await load();
  };

  const onDelete = async (id: string) => {
    const ok = confirm("Remover este cliente?");
    if (!ok) return;

    setError(null);
    const { error: e } = await supabase.from("clients").delete().eq("id", id);

    if (e) {
      setError(e.message);
      return;
    }

    await load();
  };

  return (
    <AdminGuard>
      <AdminShell title="Clientes">
        <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6 mb-6">
          <h2 className="font-display text-lg font-bold mb-4">Novo cliente</h2>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            <input
              value={newName}
              onChange={(e) => setNewName(e.target.value)}
              placeholder="Nome"
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            />
            <input
              value={newSlug}
              onChange={(e) => setNewSlug(e.target.value)}
              placeholder="Slug"
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            />
            <input
              value={newLogoUrl}
              onChange={(e) => setNewLogoUrl(e.target.value)}
              placeholder="Logo (URL)"
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            />
          </div>
          <div className="mt-4">
            <button
              onClick={onCreate}
              disabled={!canCreate}
              className="px-4 py-2 rounded-btn bg-secondary text-bg font-mono font-medium border border-border shadow-glow -translate-y-0.5 transition-all disabled:opacity-60 disabled:shadow-none disabled:translate-y-0 w-full sm:w-auto"
            >
              Criar
            </button>
          </div>
        </div>

        <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
          <div className="flex items-center justify-between gap-3 mb-4">
            <h2 className="font-display text-lg font-bold">Lista</h2>
            <button
              onClick={load}
              className="px-4 py-2 rounded-btn border border-border hover:bg-secondary hover:text-bg hover:shadow-glow hover:-translate-y-0.5 transition-all text-sm font-mono font-medium"
            >
              Atualizar
            </button>
          </div>

          {error ? <div className="text-sm text-red-500 mb-4">{error}</div> : null}

          {loading ? (
            <div className="text-text-secondary text-sm">Carregando...</div>
          ) : rows.length === 0 ? (
            <div className="text-text-secondary text-sm">Nenhum cliente ainda.</div>
          ) : (
            <div className="space-y-3">
              {rows.map((r) => {
                const editing = editingId === r.id;

                return (
                  <div
                    key={r.id}
                    className="rounded-card border border-border bg-bg/80 overflow-hidden p-4"
                  >
                    {editing ? (
                      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        <input
                          value={editName}
                          onChange={(e) => setEditName(e.target.value)}
                          className="px-4 py-2 rounded-lg border border-border bg-bg"
                        />
                        <input
                          value={editSlug}
                          onChange={(e) => setEditSlug(e.target.value)}
                          className="px-4 py-2 rounded-lg border border-border bg-bg"
                        />
                        <input
                          value={editLogoUrl}
                          onChange={(e) => setEditLogoUrl(e.target.value)}
                          className="px-4 py-2 rounded-lg border border-border bg-bg"
                        />
                      </div>
                    ) : (
                      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        <div>
                          <div className="font-medium">{r.name}</div>
                        </div>
                        <div className="sm:col-span-2">
                          <div className="text-xs text-text-secondary">
                            {r.logo_url ? "com logo" : "sem logo"}
                          </div>
                        </div>
                      </div>
                    )}

                    <div className="flex flex-wrap gap-2 mt-4">
                      {editing ? (
                        <>
                          <button
                            onClick={onSave}
                            className="px-4 py-2 rounded-btn bg-secondary text-bg text-sm font-mono font-medium border border-border shadow-glow -translate-y-0.5 transition-all w-full sm:w-auto"
                          >
                            Salvar
                          </button>
                          <button
                            onClick={cancelEdit}
                            className="px-4 py-2 rounded-btn border border-border text-sm hover:bg-secondary hover:text-bg hover:shadow-glow hover:-translate-y-0.5 transition-all font-mono font-medium w-full sm:w-auto"
                          >
                            Cancelar
                          </button>
                        </>
                      ) : (
                        <>
                          <Link
                            href={`/admin/clients/${r.id}`}
                            className="px-4 py-2 rounded-btn bg-primary text-secondary border border-border text-sm font-mono font-medium hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-auto"
                          >
                            Abrir
                          </Link>
                          <button
                            onClick={() => startEdit(r)}
                            className="px-4 py-2 rounded-btn border border-border text-sm hover:bg-secondary hover:text-bg hover:shadow-glow hover:-translate-y-0.5 transition-all font-mono font-medium w-full sm:w-auto"
                          >
                            Editar
                          </button>
                          <button
                            onClick={() => onDelete(r.id)}
                            className="px-4 py-2 rounded-btn border border-border text-sm hover:bg-secondary hover:text-bg hover:shadow-glow hover:-translate-y-0.5 transition-all font-mono font-medium w-full sm:w-auto"
                          >
                            Remover
                          </button>
                        </>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </AdminShell>
    </AdminGuard>
  );
}
