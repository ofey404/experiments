CREATE TABLE email (
                       email_id          SERIAL PRIMARY KEY,
                       email_address     VARCHAR(100),
                       email_type        CHAR(1) NOT NULL,
                       person_id         INT NOT NULL
);

CREATE TABLE email_type (
                            email_type        CHAR(1) NOT NULL PRIMARY KEY,
                            description       VARCHAR(20)
);

INSERT INTO email_type (email_type, description)
SELECT 'P', 'Primary'
UNION ALL
SELECT 'W', 'Work';

ALTER TABLE email
    ADD CONSTRAINT fk_person_email
        FOREIGN KEY (person_id) REFERENCES people(person_id);

ALTER TABLE email
    ADD CONSTRAINT fk_email_type
        FOREIGN KEY (email_type) REFERENCES email_type(email_type);
