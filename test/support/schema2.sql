DROP SCHEMA IF EXISTS public CASCADE;
DROP SCHEMA IF EXISTS other CASCADE;

CREATE SCHEMA public;
CREATE SCHEMA other;
CREATE FUNCTION public.gen_random_uuid()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/pgcrypto', $function$pg_random_uuid$function$;

DROP TABLE IF EXISTS "Users";
DROP TABLE IF EXISTS "posts";
CREATE TABLE "Users" (
  "id" uuid NOT NULL DEFAULT public.gen_random_uuid(),
  email TEXT,
  phone TEXT,
  token TEXT,
  attempts INT,
  created_on DATE,
  updated_at TIMESTAMP,
  ip TEXT,
  name TEXT,
  nonsense TEXT,
  untouchable TEXT,
  "column_with_punctuation?" BOOLEAN
);

CREATE TABLE posts (
  "id" uuid NOT NULL DEFAULT public.gen_random_uuid() PRIMARY KEY,
  title TEXT
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id uuid REFERENCES posts(id) DEFERRABLE
);

CREATE TABLE comments2 (
  id SERIAL PRIMARY KEY,
  post_id uuid REFERENCES posts(id)
);

CREATE TABLE books (
  id SERIAL,
  id2 SERIAL,
  title TEXT,
  PRIMARY KEY (id, id2)
);

CREATE TABLE authors (
  last_name TEXT
);

CREATE TABLE chapters (
  pages BIGINT
);

CREATE TABLE robots (
  id SERIAL PRIMARY KEY,
  name TEXT
);
CREATE OR REPLACE FUNCTION nope()
RETURNS trigger AS
$$
BEGIN
  RAISE EXCEPTION 'Nope!';
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER nope_trigger BEFORE INSERT OR UPDATE ON robots FOR EACH ROW EXECUTE PROCEDURE nope();

CREATE TABLE excluded (
  id SERIAL PRIMARY KEY
);

CREATE TABLE other.pets (
  id SERIAL PRIMARY KEY
);
