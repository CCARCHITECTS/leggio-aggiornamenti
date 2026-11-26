-- Quadro 1.7: commenti e cronologia delle versioni delle cartelle condivise.
-- Da applicare nel progetto Supabase dello studio (lo stesso di Leggio: tlrkrigowgoqbdwgbqav).
-- I dati arrivano già cifrati dal programma (AES-GCM con chiave nata dal codice di condivisione):
-- il server conserva solo testo illeggibile. Accesso solo tramite le funzioni qui sotto.
create table if not exists public.quadro_condivisi (
  id bigint generated always as identity primary key,
  canale text not null check (canale ~ '^quadro-[0-9a-f]{32}$'),
  tipo text not null check (tipo in ('commento', 'versione')),
  creato timestamptz not null default now(),
  info text not null check (length(info) <= 20000),
  dati text check (dati is null or length(dati) <= 12000000)
);
create index if not exists quadro_condivisi_canale on public.quadro_condivisi (canale, tipo, id);
alter table public.quadro_condivisi enable row level security;
revoke all on public.quadro_condivisi from anon, authenticated;

create or replace function public.quadro_scrivi(p_canale text, p_tipo text, p_info text, p_dati text default null)
returns bigint language plpgsql security definer set search_path = '' as $$
declare nid bigint; n int;
begin
  select count(*) into n from public.quadro_condivisi where canale = p_canale and tipo = p_tipo;
  if p_tipo = 'commento' and n >= 5000 then raise exception 'troppi commenti'; end if;
  insert into public.quadro_condivisi (canale, tipo, info, dati) values (p_canale, p_tipo, p_info, p_dati) returning id into nid;
  if p_tipo = 'versione' then
    delete from public.quadro_condivisi q where q.canale = p_canale and q.tipo = 'versione'
      and q.id not in (select v.id from public.quadro_condivisi v where v.canale = p_canale and v.tipo = 'versione' order by v.id desc limit 30);
  end if;
  return nid;
end $$;

create or replace function public.quadro_elenco(p_canale text, p_tipo text, p_dopo bigint default 0)
returns table (id bigint, creato timestamptz, info text, dimensione int)
language sql stable security definer set search_path = '' as $$
  select q.id, q.creato, q.info, coalesce(length(q.dati), 0) from public.quadro_condivisi q
  where q.canale = p_canale and q.tipo = p_tipo and q.id > p_dopo order by q.id limit 2000;
$$;

create or replace function public.quadro_versione(p_canale text, p_id bigint)
returns text language sql stable security definer set search_path = '' as $$
  select q.dati from public.quadro_condivisi q where q.canale = p_canale and q.id = p_id and q.tipo = 'versione';
$$;

revoke all on function public.quadro_scrivi(text, text, text, text) from public;
revoke all on function public.quadro_elenco(text, text, bigint) from public;
revoke all on function public.quadro_versione(text, bigint) from public;
grant execute on function public.quadro_scrivi(text, text, text, text) to anon, authenticated;
grant execute on function public.quadro_elenco(text, text, bigint) to anon, authenticated;
grant execute on function public.quadro_versione(text, bigint) to anon, authenticated;
