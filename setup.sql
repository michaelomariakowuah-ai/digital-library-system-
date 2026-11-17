-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run
create table if not exists public.docs (
  path text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);
alter table public.docs enable row level security;

create policy "staff can read" on public.docs for select to authenticated
  using ((auth.jwt()->'app_metadata'->>'role') in ('admin','monitor'));
create policy "admin can insert" on public.docs for insert to authenticated
  with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "admin can update" on public.docs for update to authenticated
  using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
  with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "admin can delete" on public.docs for delete to authenticated
  using ((auth.jwt()->'app_metadata'->>'role') = 'admin');

alter publication supabase_realtime add table public.docs;

-- Give each person a role AFTER you create their user (Authentication -> Users -> Add user).
-- Change the email addresses, then run these lines:
update auth.users set raw_app_meta_data = coalesce(raw_app_meta_data,'{}'::jsonb) || '{"role":"admin"}'   where email = 'librarian@yourschool.edu.gh';
update auth.users set raw_app_meta_data = coalesce(raw_app_meta_data,'{}'::jsonb) || '{"role":"monitor"}' where email = 'headteacher@yourschool.edu.gh';
