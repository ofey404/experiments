-----------------------------------------------
-- Don't run. This file is a note for commands.
-----------------------------------------------

-- list database
\l

-- switch database
\c database_name
\connect database_name

-- list schemas
\dn

-- list relations
\dt public.*

-- check the schema
SELECT * FROM table_name LIMIT 1;
-- select only the schema
SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns
WHERE 
    table_name = 'table_name';

-- drop records
DELETE FROM table_name;
-- optional: reset the id
TRUNCATE notebooks RESTART IDENTITY;
