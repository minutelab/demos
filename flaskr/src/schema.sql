create table if not exists entries (
  id SERIAL primary key,
  title text not null,
  text text not null
);
