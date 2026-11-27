-- AURA MANAGER V2 — skema Supabase (sudah diterapkan ke project aura-manager-v2)
-- Tabel tunggal state (JSON) + snapshot cadangan otomatis + bucket foto pemain.
-- Tanpa login: siapa pun yang punya link bisa baca & ubah data.
create table if not exists public.sport_manager_state (
    id smallint primary key default 1,
    players jsonb not null default '[]'::jsonb,
    matches_history jsonb not null default '[]'::jsonb,
    active_matches jsonb not null default '[]'::jsonb,
    finance_transactions jsonb not null default '[]'::jsonb,
    finance_settings jsonb not null default '{"payPerPlay": 0}'::jsonb,
    updated_at timestamptz not null default now(),
    rr_teams jsonb default '[]'::jsonb,
    rr_matches jsonb default '[]'::jsonb,
    rr_settings jsonb default '{"totalCourts": 2, "qualifyCount": 4}'::jsonb,
    rr_phase text default 'setup',
    rr_bracket jsonb default '[]'::jsonb,
    constraint single_row check (id = 1)
);
insert into public.sport_manager_state (id) values (1) on conflict (id) do nothing;
alter table public.sport_manager_state enable row level security;
create policy "v2 baca state" on public.sport_manager_state for select to anon, authenticated using (true);
create policy "v2 update state" on public.sport_manager_state for update to anon, authenticated using (true) with check (true);
alter publication supabase_realtime add table public.sport_manager_state;
-- (snapshot history, trigger, dan bucket player-photos: lihat migration aura_manager_v2_initial)
