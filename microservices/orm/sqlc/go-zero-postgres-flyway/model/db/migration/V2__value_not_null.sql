UPDATE hellokv SET value = '' WHERE value IS NULL;

ALTER TABLE hellokv ALTER COLUMN value SET NOT NULL;
