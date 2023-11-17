--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email (
    email_id integer NOT NULL,
    email_address character varying(100),
    email_type character(1) NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.email OWNER TO postgres;

--
-- Name: email_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_email_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_email_id_seq OWNER TO postgres;

--
-- Name: email_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_email_id_seq OWNED BY public.email.email_id;


--
-- Name: email_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_type (
    email_type character(1) NOT NULL,
    description character varying(20)
);


ALTER TABLE public.email_type OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    person_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(20),
    address_line_1 character varying(20),
    address_line_2 character varying(100),
    city character varying(20),
    state character varying(2),
    zip_code character varying(5)
);


ALTER TABLE public.people OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.people_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_person_id_seq OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.people_person_id_seq OWNED BY public.people.person_id;


--
-- Name: phone_numbers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone_numbers (
    phone_number_id integer NOT NULL,
    phone_number character varying(20),
    phone_type character(1),
    person_id integer NOT NULL
);


ALTER TABLE public.phone_numbers OWNER TO postgres;

--
-- Name: people_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.people_view AS
 SELECT a.person_id,
    a.first_name,
    a.last_name,
    b.phone_number,
    a.address_line_1,
    a.address_line_2,
    a.city,
    a.state,
    a.zip_code
   FROM (public.people a
     JOIN public.phone_numbers b ON ((b.person_id = a.person_id)))
  WHERE (b.phone_type = 'H'::bpchar);


ALTER VIEW public.people_view OWNER TO postgres;

--
-- Name: phone_numbers_phone_number_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phone_numbers_phone_number_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.phone_numbers_phone_number_id_seq OWNER TO postgres;

--
-- Name: phone_numbers_phone_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phone_numbers_phone_number_id_seq OWNED BY public.phone_numbers.phone_number_id;


--
-- Name: phone_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone_type (
    phone_type character(1),
    description character varying(20)
);


ALTER TABLE public.phone_type OWNER TO postgres;

--
-- Name: states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.states (
    state character varying(2) NOT NULL,
    description character varying(20)
);


ALTER TABLE public.states OWNER TO postgres;

--
-- Name: email email_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email ALTER COLUMN email_id SET DEFAULT nextval('public.email_email_id_seq'::regclass);


--
-- Name: people person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN person_id SET DEFAULT nextval('public.people_person_id_seq'::regclass);


--
-- Name: phone_numbers phone_number_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_numbers ALTER COLUMN phone_number_id SET DEFAULT nextval('public.phone_numbers_phone_number_id_seq'::regclass);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (email_id);


--
-- Name: email_type email_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_type
    ADD CONSTRAINT email_type_pkey PRIMARY KEY (email_type);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- Name: phone_numbers phone_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_pkey PRIMARY KEY (phone_number_id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: email fk_email_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT fk_email_type FOREIGN KEY (email_type) REFERENCES public.email_type(email_type);


--
-- Name: email fk_person_email; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT fk_person_email FOREIGN KEY (person_id) REFERENCES public.people(person_id);


--
-- Name: phone_numbers fk_phone_numbers_people; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT fk_phone_numbers_people FOREIGN KEY (person_id) REFERENCES public.people(person_id);


--
-- Name: people people_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_state_fkey FOREIGN KEY (state) REFERENCES public.states(state);


--
-- PostgreSQL database dump complete
--

