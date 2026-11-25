-- Calculateur BB3 : base de données
-- À coller une seule fois dans Supabase > SQL Editor > New query, puis "Run".

-- 1. Une ligne par utilisateur, qui contient toutes ses notes (format JSON)
create table if not exists public.notes (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2. Sécurité : chacun ne peut lire et modifier QUE ses propres notes
alter table public.notes enable row level security;

drop policy if exists "lire ses notes" on public.notes;
create policy "lire ses notes" on public.notes
  for select using (auth.uid() = user_id);

drop policy if exists "créer ses notes" on public.notes;
create policy "créer ses notes" on public.notes
  for insert with check (auth.uid() = user_id);

drop policy if exists "modifier ses notes" on public.notes;
create policy "modifier ses notes" on public.notes
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "supprimer ses notes" on public.notes;
create policy "supprimer ses notes" on public.notes
  for delete using (auth.uid() = user_id);

-- 3. Bouton "Supprimer mon compte" (RGPD) : supprime le compte connecté
--    et, grâce au "on delete cascade", toutes ses notes.
create or replace function public.supprimer_mon_compte()
returns void
language sql
security definer
set search_path = ''
as $$
  delete from auth.users where id = auth.uid();
$$;

revoke all on function public.supprimer_mon_compte() from public, anon;
grant execute on function public.supprimer_mon_compte() to authenticated;

-- 4. Droits d'accès à la table : seulement les utilisateurs connectés
--    (les règles RLS ci-dessus limitent ensuite chacun à ses propres notes)
grant usage on schema public to authenticated;
grant select, insert, update, delete on table public.notes to authenticated;
revoke all on table public.notes from anon;
