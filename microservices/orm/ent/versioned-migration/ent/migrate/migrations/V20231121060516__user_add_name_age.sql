-- modify "users" table
ALTER TABLE "users" ADD COLUMN "age" bigint NOT NULL, ADD COLUMN "name" character varying NOT NULL DEFAULT 'unknown';
