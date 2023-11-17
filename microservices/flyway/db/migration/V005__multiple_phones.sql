CREATE TABLE phone_numbers (
                               phone_number_id   SERIAL PRIMARY KEY,
                               phone_number      VARCHAR(20),
                               phone_type        CHAR(1),
                               person_id         INT NOT NULL
);

CREATE TABLE phone_type (
                            phone_type        CHAR(1),
                            description       VARCHAR(20)
);

INSERT INTO phone_type (phone_type, description) VALUES ('H', 'Home');

ALTER TABLE phone_numbers ADD CONSTRAINT fk_phone_numbers_people
    FOREIGN KEY (person_id) REFERENCES people(person_id);

INSERT INTO phone_numbers (phone_number, phone_type, person_id)
SELECT phone_number, 'H', person_id FROM people;

ALTER TABLE people DROP COLUMN phone_number CASCADE;

DROP VIEW IF EXISTS people_view;

CREATE VIEW people_view AS (
                           SELECT
                               a.person_id,
                               a.first_name,
                               a.last_name,
                               b.phone_number,
                               a.address_line_1,
                               a.address_line_2,
                               a.city,
                               a.state,
                               a.zip_code
                           FROM people a JOIN phone_numbers b ON b.person_id = a.person_id
                           WHERE b.phone_type = 'H'
                               );
