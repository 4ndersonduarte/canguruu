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
};

type CategoryRow = {
  id: string;
  name: string;
  slug: string;
};

type WorkRow = {
  id: string;
  title: string;
  description: string | null;
  client_id: string;
  category_id: string;
  cover_asset_id: string | null;
  sort_order: number;
  created_at: string;
};

export default function AdminWorksPage() {
  const [clients, setClients] = useState<ClientRow[]>([]);
  const [categories, setCategories] = useState<CategoryRow[]>([]);
  const [works, setWorks] = useState<WorkRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [newTitle, setNewTitle] = useState("");
  const [newDescription, setNewDescription] = useState("");
  const [newClientId, setNewClientId] = useState("");
  const [newCategoryId, setNewCategoryId] = useState("");

  const canCreate = useMemo(() => {
    return (
      newTitle.trim().length > 0 &&
      newClientId.trim().length > 0 &&
      newCategoryId.trim().length > 0
    );
  }, [newTitle, newClientId, newCategoryId]);

  const load = async () => {
    setError(null);
    setLoading(true);

    const [{ data: cData, error: cErr }, { data: catData, error: catErr }] =
      await Promise.all([
        supabase.from("clients").select("id,name,slug").order("name"),
        supabase
          .from("categories")
          .select("id,name,slug")
          .order("name"),
      ]);

    if (cErr) {
      setError(cErr.message);
      setLoading(false);
      return;
    }

    if (catErr) {
      setError(catErr.message);
      setLoading(false);
      return;
    }

    setClients((cData ?? []) as ClientRow[]);
    setCategories((catData ?? []) as CategoryRow[]);

    const { data: wData, error: wErr } = await supabase
      .from("works")
      .select("id,title,description,client_id,category_id,cover_asset_id,sort_order,created_at")
      .order("created_at", { ascending: false });

    if (wErr) {
      setError(wErr.message);
      setLoading(false);
      return;
    }

    setWorks((wData ?? []) as WorkRow[]);
    setLoading(false);
  };

  useEffect(() => {
    load();
  }, []);

  useEffect(() => {
    if (!newClientId && clients.length > 0) setNewClientId(clients[0].id);
  }, [clients, newClientId]);

  useEffect(() => {
    if (!newCategoryId && categories.length > 0) {
      setNewCategoryId(categories[0].id);
    }
  }, [categories, newCategoryId]);

  const onCreate = async () => {
    if (!canCreate) return;
    setError(null);

    const { data, error: e } = await supabase
      .from("works")
      .insert({
        title: newTitle.trim(),
        description: newDescription.trim() ? newDescription.trim() : null,
        client_id: newClientId,
        category_id: newCategoryId,
      })
      .select("id")
      .single();

    if (e) {
      setError(e.message);
      return;
    }

    setNewTitle("");
    setNewDescription("");

    if (data?.id) {
      await load();
    } else {
      await load();
    }
  };

  const onDelete = async (id: string) => {
    const ok = confirm("Remover este trabalho? (as imagens serão removidas do banco, mas não do Storage)");
    if (!ok) return;

    setError(null);
    const { error: e } = await supabase.from("works").delete().eq("id", id);

    if (e) {
      setError(e.message);
      return;
    }

    await load();
  };

  const clientName = (id: string) => clients.find((c) => c.id === id)?.name ?? "-";
  const categoryName = (id: string) =>
    categories.find((c) => c.id === id)?.name ?? "-";

  const onSetWorkOrder = async (workId: string, order: number) => {
    if (!Number.isFinite(order)) return;
    setError(null);

    const { error: e } = await supabase
      .from("works")
      .update({ sort_order: order })
      .eq("id", workId);

    if (e) {
      setError(e.message);
      return;
    }

    await load();
  };

  return (
    <AdminGuard>
      <AdminShell title="Trabalhos">
        <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6 mb-6">
          <h2 className="font-display text-lg font-bold mb-4">Novo trabalho</h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <input
              value={newTitle}
              onChange={(e) => setNewTitle(e.target.value)}
              placeholder="Título"
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            />
            <select
              value={newClientId}
              onChange={(e) => setNewClientId(e.target.value)}
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            >
              {clients.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
            <select
              value={newCategoryId}
              onChange={(e) => setNewCategoryId(e.target.value)}
              className="px-4 py-2 rounded-lg border border-border bg-bg"
            >
              {categories.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
            <input
              value={newDescription}
              onChange={(e) => setNewDescription(e.target.value)}
              placeholder="Descrição"
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
          ) : works.length === 0 ? (
            <div className="text-text-secondary text-sm">Nenhum trabalho ainda.</div>
          ) : (
            <div className="space-y-3">
              {works.map((w) => (
                <div
                  key={w.id}
                  className="rounded-card border border-border bg-bg/80 overflow-hidden p-4"
                >
                  <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-4">
                    <div className="min-w-0">
                      <div className="font-medium truncate">{w.title}</div>
                      <div className="text-xs text-text-secondary mt-1">
                        {clientName(w.client_id)} / {categoryName(w.category_id)}
                      </div>
                      <div className="mt-2 flex items-center gap-2">
                        <span className="text-xs text-text-secondary font-mono">ordem</span>
                        <input
                          type="number"
                          min={0}
                          defaultValue={w.sort_order}
                          onKeyDown={(e) => {
                            if (e.key === "Enter") {
                              (e.currentTarget as HTMLInputElement).blur();
                            }
                          }}
                          onBlur={(e) => {
                            const next = Number(e.currentTarget.value);
                            if (Number.isFinite(next) && next !== w.sort_order) {
                              void onSetWorkOrder(w.id, next);
                            }
                          }}
                          className="w-24 px-3 py-2 rounded-lg border border-border bg-bg text-sm"
                        />
                      </div>
                      {w.description ? (
                        <div className="text-sm text-text-secondary mt-2">
                          {w.description}
                        </div>
                      ) : null}
                    </div>

                    <div className="flex flex-wrap gap-2">
                      <Link
                        href={`/admin/works/${w.id}`}
                        className="px-4 py-2 rounded-btn bg-primary text-secondary border border-border text-sm font-mono font-medium hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-auto"
                      >
                        Abrir
                      </Link>
                      <button
                        onClick={() => onDelete(w.id)}
                        className="px-4 py-2 rounded-btn border border-border text-sm hover:bg-secondary hover:text-bg hover:shadow-glow hover:-translate-y-0.5 transition-all font-mono font-medium w-full sm:w-auto"
                      >
                        Remover
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </AdminShell>
    </AdminGuard>
  );
}
