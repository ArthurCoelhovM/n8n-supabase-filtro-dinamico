create table if not exists clientes (
  id bigint generated always as identity primary key,
  nome text not null,
  cidade text not null,
  estado char(2) not null,
  plano text not null check (plano in ('basico', 'pro', 'empresa')),
  status text not null check (status in ('ativo', 'inativo', 'pendente')),
  valor_mensal numeric(10, 2) not null,
  criado_em timestamptz not null default now()
);

create table if not exists config_filtro (
  id bigint generated always as identity primary key,
  nome text not null unique,
  campo text not null,
  operador text not null check (operador in ('igual', 'diferente', 'contem', 'maior', 'menor')),
  valor text not null,
  ativo boolean not null default false
);

create unique index if not exists config_filtro_um_ativo
  on config_filtro (ativo) where ativo;

create table if not exists historico_filtros (
  id bigint generated always as identity primary key,
  filtro jsonb not null,
  total int not null,
  executado_em timestamptz not null default now()
);

alter table clientes enable row level security;
alter table config_filtro enable row level security;
alter table historico_filtros enable row level security;
