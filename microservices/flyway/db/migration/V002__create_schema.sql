CREATE TABLE states (
                        state             varchar(2) not null PRIMARY KEY,
                        description       varchar(20)
);

CREATE TABLE people (
                        person_id         serial PRIMARY KEY,
                        first_name        varchar(20),
                        last_name         varchar(20),
                        phone_number      varchar(20),
                        address_line_1    varchar(20),
                        address_line_2    varchar(100),
                        city              varchar(20),
                        state             varchar(2),
                        zip_code          varchar(5),
                        FOREIGN KEY (state) REFERENCES states(state)
);

CREATE VIEW people_view AS (
                           SELECT
                               person_id,
                               first_name,
                               last_name,
                               phone_number,
                               address_line_1,
                               address_line_2,
                               city,
                               state,
                               zip_code
                           FROM people
                               );
