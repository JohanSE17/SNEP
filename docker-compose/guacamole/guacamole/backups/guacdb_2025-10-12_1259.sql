--
-- PostgreSQL database dump
--

\restrict YysCRm8RUaffvqzIgXuvYWFmo823MwQuAOWrKL7MyxAoCyE5SMqFEgaw6fE7I1s

-- Dumped from database version 13.22 (Debian 13.22-1.pgdg13+1)
-- Dumped by pg_dump version 13.22 (Debian 13.22-1.pgdg13+1)

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

--
-- Name: guacamole_connection_group_type; Type: TYPE; Schema: public; Owner: guacuser
--

CREATE TYPE public.guacamole_connection_group_type AS ENUM (
    'ORGANIZATIONAL',
    'BALANCING'
);


ALTER TYPE public.guacamole_connection_group_type OWNER TO guacuser;

--
-- Name: guacamole_entity_type; Type: TYPE; Schema: public; Owner: guacuser
--

CREATE TYPE public.guacamole_entity_type AS ENUM (
    'USER',
    'USER_GROUP'
);


ALTER TYPE public.guacamole_entity_type OWNER TO guacuser;

--
-- Name: guacamole_object_permission_type; Type: TYPE; Schema: public; Owner: guacuser
--

CREATE TYPE public.guacamole_object_permission_type AS ENUM (
    'READ',
    'UPDATE',
    'DELETE',
    'ADMINISTER'
);


ALTER TYPE public.guacamole_object_permission_type OWNER TO guacuser;

--
-- Name: guacamole_proxy_encryption_method; Type: TYPE; Schema: public; Owner: guacuser
--

CREATE TYPE public.guacamole_proxy_encryption_method AS ENUM (
    'NONE',
    'SSL'
);


ALTER TYPE public.guacamole_proxy_encryption_method OWNER TO guacuser;

--
-- Name: guacamole_system_permission_type; Type: TYPE; Schema: public; Owner: guacuser
--

CREATE TYPE public.guacamole_system_permission_type AS ENUM (
    'CREATE_CONNECTION',
    'CREATE_CONNECTION_GROUP',
    'CREATE_SHARING_PROFILE',
    'CREATE_USER',
    'CREATE_USER_GROUP',
    'AUDIT',
    'ADMINISTER'
);


ALTER TYPE public.guacamole_system_permission_type OWNER TO guacuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: guacamole_connection; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection (
    connection_id integer NOT NULL,
    connection_name character varying(128) NOT NULL,
    parent_id integer,
    protocol character varying(32) NOT NULL,
    max_connections integer,
    max_connections_per_user integer,
    connection_weight integer,
    failover_only boolean DEFAULT false NOT NULL,
    proxy_port integer,
    proxy_hostname character varying(512),
    proxy_encryption_method public.guacamole_proxy_encryption_method
);


ALTER TABLE public.guacamole_connection OWNER TO guacuser;

--
-- Name: guacamole_connection_attribute; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_attribute (
    connection_id integer NOT NULL,
    attribute_name character varying(128) NOT NULL,
    attribute_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_connection_attribute OWNER TO guacuser;

--
-- Name: guacamole_connection_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_connection_connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_connection_connection_id_seq OWNER TO guacuser;

--
-- Name: guacamole_connection_connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_connection_connection_id_seq OWNED BY public.guacamole_connection.connection_id;


--
-- Name: guacamole_connection_group; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_group (
    connection_group_id integer NOT NULL,
    parent_id integer,
    connection_group_name character varying(128) NOT NULL,
    type public.guacamole_connection_group_type DEFAULT 'ORGANIZATIONAL'::public.guacamole_connection_group_type NOT NULL,
    max_connections integer,
    max_connections_per_user integer,
    enable_session_affinity boolean DEFAULT false NOT NULL
);


ALTER TABLE public.guacamole_connection_group OWNER TO guacuser;

--
-- Name: guacamole_connection_group_attribute; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_group_attribute (
    connection_group_id integer NOT NULL,
    attribute_name character varying(128) NOT NULL,
    attribute_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_connection_group_attribute OWNER TO guacuser;

--
-- Name: guacamole_connection_group_connection_group_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_connection_group_connection_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_connection_group_connection_group_id_seq OWNER TO guacuser;

--
-- Name: guacamole_connection_group_connection_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_connection_group_connection_group_id_seq OWNED BY public.guacamole_connection_group.connection_group_id;


--
-- Name: guacamole_connection_group_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_group_permission (
    entity_id integer NOT NULL,
    connection_group_id integer NOT NULL,
    permission public.guacamole_object_permission_type NOT NULL
);


ALTER TABLE public.guacamole_connection_group_permission OWNER TO guacuser;

--
-- Name: guacamole_connection_history; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_history (
    history_id integer NOT NULL,
    user_id integer,
    username character varying(128) NOT NULL,
    remote_host character varying(256) DEFAULT NULL::character varying,
    connection_id integer,
    connection_name character varying(128) NOT NULL,
    sharing_profile_id integer,
    sharing_profile_name character varying(128) DEFAULT NULL::character varying,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone
);


ALTER TABLE public.guacamole_connection_history OWNER TO guacuser;

--
-- Name: guacamole_connection_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_connection_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_connection_history_history_id_seq OWNER TO guacuser;

--
-- Name: guacamole_connection_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_connection_history_history_id_seq OWNED BY public.guacamole_connection_history.history_id;


--
-- Name: guacamole_connection_parameter; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_parameter (
    connection_id integer NOT NULL,
    parameter_name character varying(128) NOT NULL,
    parameter_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_connection_parameter OWNER TO guacuser;

--
-- Name: guacamole_connection_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_connection_permission (
    entity_id integer NOT NULL,
    connection_id integer NOT NULL,
    permission public.guacamole_object_permission_type NOT NULL
);


ALTER TABLE public.guacamole_connection_permission OWNER TO guacuser;

--
-- Name: guacamole_entity; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_entity (
    entity_id integer NOT NULL,
    name character varying(128) NOT NULL,
    type public.guacamole_entity_type NOT NULL
);


ALTER TABLE public.guacamole_entity OWNER TO guacuser;

--
-- Name: guacamole_entity_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_entity_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_entity_entity_id_seq OWNER TO guacuser;

--
-- Name: guacamole_entity_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_entity_entity_id_seq OWNED BY public.guacamole_entity.entity_id;


--
-- Name: guacamole_sharing_profile; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_sharing_profile (
    sharing_profile_id integer NOT NULL,
    sharing_profile_name character varying(128) NOT NULL,
    primary_connection_id integer NOT NULL
);


ALTER TABLE public.guacamole_sharing_profile OWNER TO guacuser;

--
-- Name: guacamole_sharing_profile_attribute; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_sharing_profile_attribute (
    sharing_profile_id integer NOT NULL,
    attribute_name character varying(128) NOT NULL,
    attribute_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_sharing_profile_attribute OWNER TO guacuser;

--
-- Name: guacamole_sharing_profile_parameter; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_sharing_profile_parameter (
    sharing_profile_id integer NOT NULL,
    parameter_name character varying(128) NOT NULL,
    parameter_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_sharing_profile_parameter OWNER TO guacuser;

--
-- Name: guacamole_sharing_profile_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_sharing_profile_permission (
    entity_id integer NOT NULL,
    sharing_profile_id integer NOT NULL,
    permission public.guacamole_object_permission_type NOT NULL
);


ALTER TABLE public.guacamole_sharing_profile_permission OWNER TO guacuser;

--
-- Name: guacamole_sharing_profile_sharing_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_sharing_profile_sharing_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_sharing_profile_sharing_profile_id_seq OWNER TO guacuser;

--
-- Name: guacamole_sharing_profile_sharing_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_sharing_profile_sharing_profile_id_seq OWNED BY public.guacamole_sharing_profile.sharing_profile_id;


--
-- Name: guacamole_system_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_system_permission (
    entity_id integer NOT NULL,
    permission public.guacamole_system_permission_type NOT NULL
);


ALTER TABLE public.guacamole_system_permission OWNER TO guacuser;

--
-- Name: guacamole_user; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user (
    user_id integer NOT NULL,
    entity_id integer NOT NULL,
    password_hash bytea NOT NULL,
    password_salt bytea,
    password_date timestamp with time zone NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    expired boolean DEFAULT false NOT NULL,
    access_window_start time without time zone,
    access_window_end time without time zone,
    valid_from date,
    valid_until date,
    timezone character varying(64),
    full_name character varying(256),
    email_address character varying(256),
    organization character varying(256),
    organizational_role character varying(256)
);


ALTER TABLE public.guacamole_user OWNER TO guacuser;

--
-- Name: guacamole_user_attribute; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_attribute (
    user_id integer NOT NULL,
    attribute_name character varying(128) NOT NULL,
    attribute_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_user_attribute OWNER TO guacuser;

--
-- Name: guacamole_user_group; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_group (
    user_group_id integer NOT NULL,
    entity_id integer NOT NULL,
    disabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.guacamole_user_group OWNER TO guacuser;

--
-- Name: guacamole_user_group_attribute; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_group_attribute (
    user_group_id integer NOT NULL,
    attribute_name character varying(128) NOT NULL,
    attribute_value character varying(4096) NOT NULL
);


ALTER TABLE public.guacamole_user_group_attribute OWNER TO guacuser;

--
-- Name: guacamole_user_group_member; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_group_member (
    user_group_id integer NOT NULL,
    member_entity_id integer NOT NULL
);


ALTER TABLE public.guacamole_user_group_member OWNER TO guacuser;

--
-- Name: guacamole_user_group_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_group_permission (
    entity_id integer NOT NULL,
    affected_user_group_id integer NOT NULL,
    permission public.guacamole_object_permission_type NOT NULL
);


ALTER TABLE public.guacamole_user_group_permission OWNER TO guacuser;

--
-- Name: guacamole_user_group_user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_user_group_user_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_user_group_user_group_id_seq OWNER TO guacuser;

--
-- Name: guacamole_user_group_user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_user_group_user_group_id_seq OWNED BY public.guacamole_user_group.user_group_id;


--
-- Name: guacamole_user_history; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_history (
    history_id integer NOT NULL,
    user_id integer,
    username character varying(128) NOT NULL,
    remote_host character varying(256) DEFAULT NULL::character varying,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone
);


ALTER TABLE public.guacamole_user_history OWNER TO guacuser;

--
-- Name: guacamole_user_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_user_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_user_history_history_id_seq OWNER TO guacuser;

--
-- Name: guacamole_user_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_user_history_history_id_seq OWNED BY public.guacamole_user_history.history_id;


--
-- Name: guacamole_user_password_history; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_password_history (
    password_history_id integer NOT NULL,
    user_id integer NOT NULL,
    password_hash bytea NOT NULL,
    password_salt bytea,
    password_date timestamp with time zone NOT NULL
);


ALTER TABLE public.guacamole_user_password_history OWNER TO guacuser;

--
-- Name: guacamole_user_password_history_password_history_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_user_password_history_password_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_user_password_history_password_history_id_seq OWNER TO guacuser;

--
-- Name: guacamole_user_password_history_password_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_user_password_history_password_history_id_seq OWNED BY public.guacamole_user_password_history.password_history_id;


--
-- Name: guacamole_user_permission; Type: TABLE; Schema: public; Owner: guacuser
--

CREATE TABLE public.guacamole_user_permission (
    entity_id integer NOT NULL,
    affected_user_id integer NOT NULL,
    permission public.guacamole_object_permission_type NOT NULL
);


ALTER TABLE public.guacamole_user_permission OWNER TO guacuser;

--
-- Name: guacamole_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: guacuser
--

CREATE SEQUENCE public.guacamole_user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guacamole_user_user_id_seq OWNER TO guacuser;

--
-- Name: guacamole_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: guacuser
--

ALTER SEQUENCE public.guacamole_user_user_id_seq OWNED BY public.guacamole_user.user_id;


--
-- Name: guacamole_connection connection_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection ALTER COLUMN connection_id SET DEFAULT nextval('public.guacamole_connection_connection_id_seq'::regclass);


--
-- Name: guacamole_connection_group connection_group_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group ALTER COLUMN connection_group_id SET DEFAULT nextval('public.guacamole_connection_group_connection_group_id_seq'::regclass);


--
-- Name: guacamole_connection_history history_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_history ALTER COLUMN history_id SET DEFAULT nextval('public.guacamole_connection_history_history_id_seq'::regclass);


--
-- Name: guacamole_entity entity_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_entity ALTER COLUMN entity_id SET DEFAULT nextval('public.guacamole_entity_entity_id_seq'::regclass);


--
-- Name: guacamole_sharing_profile sharing_profile_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile ALTER COLUMN sharing_profile_id SET DEFAULT nextval('public.guacamole_sharing_profile_sharing_profile_id_seq'::regclass);


--
-- Name: guacamole_user user_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user ALTER COLUMN user_id SET DEFAULT nextval('public.guacamole_user_user_id_seq'::regclass);


--
-- Name: guacamole_user_group user_group_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group ALTER COLUMN user_group_id SET DEFAULT nextval('public.guacamole_user_group_user_group_id_seq'::regclass);


--
-- Name: guacamole_user_history history_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_history ALTER COLUMN history_id SET DEFAULT nextval('public.guacamole_user_history_history_id_seq'::regclass);


--
-- Name: guacamole_user_password_history password_history_id; Type: DEFAULT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_password_history ALTER COLUMN password_history_id SET DEFAULT nextval('public.guacamole_user_password_history_password_history_id_seq'::regclass);


--
-- Data for Name: guacamole_connection; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection (connection_id, connection_name, parent_id, protocol, max_connections, max_connections_per_user, connection_weight, failover_only, proxy_port, proxy_hostname, proxy_encryption_method) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_attribute; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_attribute (connection_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_group; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_group (connection_group_id, parent_id, connection_group_name, type, max_connections, max_connections_per_user, enable_session_affinity) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_group_attribute; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_group_attribute (connection_group_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_group_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_group_permission (entity_id, connection_group_id, permission) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_history; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_history (history_id, user_id, username, remote_host, connection_id, connection_name, sharing_profile_id, sharing_profile_name, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_parameter; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_parameter (connection_id, parameter_name, parameter_value) FROM stdin;
\.


--
-- Data for Name: guacamole_connection_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_connection_permission (entity_id, connection_id, permission) FROM stdin;
\.


--
-- Data for Name: guacamole_entity; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_entity (entity_id, name, type) FROM stdin;
1	guacadmin	USER
2	Profe	USER
3	Estudiantes	USER
4	Viewership	USER
\.


--
-- Data for Name: guacamole_sharing_profile; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_sharing_profile (sharing_profile_id, sharing_profile_name, primary_connection_id) FROM stdin;
\.


--
-- Data for Name: guacamole_sharing_profile_attribute; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_sharing_profile_attribute (sharing_profile_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- Data for Name: guacamole_sharing_profile_parameter; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_sharing_profile_parameter (sharing_profile_id, parameter_name, parameter_value) FROM stdin;
\.


--
-- Data for Name: guacamole_sharing_profile_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_sharing_profile_permission (entity_id, sharing_profile_id, permission) FROM stdin;
\.


--
-- Data for Name: guacamole_system_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_system_permission (entity_id, permission) FROM stdin;
1	CREATE_CONNECTION
1	CREATE_CONNECTION_GROUP
1	CREATE_SHARING_PROFILE
1	CREATE_USER
1	CREATE_USER_GROUP
1	ADMINISTER
\.


--
-- Data for Name: guacamole_user; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user (user_id, entity_id, password_hash, password_salt, password_date, disabled, expired, access_window_start, access_window_end, valid_from, valid_until, timezone, full_name, email_address, organization, organizational_role) FROM stdin;
1	1	\\xca458a7d494e3be824f5e1e175a1556c0f8eef2c2d7df3633bec4a29c4411960	\\xfe24adc5e11e2b25288d1704abe67a79e342ecc26064ce69c5b3177795a82264	2025-10-07 04:38:16.75968+00	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	2	\\x	\N	2025-10-12 15:54:12.986244+00	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	3	\\x	\N	2025-10-12 15:54:12.986244+00	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	4	\\x	\N	2025-10-12 15:54:12.986244+00	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: guacamole_user_attribute; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_attribute (user_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- Data for Name: guacamole_user_group; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_group (user_group_id, entity_id, disabled) FROM stdin;
\.


--
-- Data for Name: guacamole_user_group_attribute; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_group_attribute (user_group_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- Data for Name: guacamole_user_group_member; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_group_member (user_group_id, member_entity_id) FROM stdin;
\.


--
-- Data for Name: guacamole_user_group_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_group_permission (entity_id, affected_user_group_id, permission) FROM stdin;
\.


--
-- Data for Name: guacamole_user_history; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_history (history_id, user_id, username, remote_host, start_date, end_date) FROM stdin;
1	1	guacadmin	192.168.1.33	2025-10-07 04:42:39.31+00	\N
2	1	guacadmin	192.168.1.33	2025-10-07 04:42:39.447+00	\N
3	1	guacadmin	192.168.1.33	2025-10-07 04:43:23.047+00	\N
4	1	guacadmin	192.168.1.33	2025-10-07 04:43:26.052+00	\N
5	1	guacadmin	192.168.1.33	2025-10-07 04:43:27.676+00	\N
6	1	guacadmin	192.168.1.33	2025-10-07 04:43:29.274+00	\N
7	1	guacadmin	192.168.1.33	2025-10-07 04:43:31.328+00	\N
8	1	guacadmin	192.168.1.33	2025-10-07 04:43:34.526+00	\N
9	1	guacadmin	192.168.1.33	2025-10-07 04:44:08.258+00	\N
10	1	guacadmin	192.168.1.33	2025-10-07 04:44:09.488+00	\N
11	1	guacadmin	192.168.1.33	2025-10-07 04:44:10.155+00	\N
12	1	guacadmin	192.168.1.33	2025-10-07 04:44:11.275+00	\N
13	1	guacadmin	192.168.1.33	2025-10-07 04:44:12.762+00	\N
14	1	guacadmin	192.168.1.33	2025-10-07 04:59:26.825+00	\N
15	1	guacadmin	192.168.1.33	2025-10-07 04:59:53.628+00	2025-10-07 06:00:10.581+00
16	1	guacadmin	172.20.0.1	2025-10-07 23:23:07.304+00	\N
17	1	guacadmin	172.20.0.1	2025-10-07 23:23:07.465+00	2025-10-07 23:23:22.732+00
18	1	guacadmin	172.20.0.1	2025-10-08 18:58:02.98+00	\N
19	1	guacadmin	172.20.0.1	2025-10-08 18:58:03.128+00	\N
20	1	guacadmin	172.20.0.1	2025-10-08 18:58:12.323+00	2025-10-08 19:06:08.732+00
21	1	guacadmin	192.168.1.33	2025-10-08 19:37:02.261+00	\N
22	1	guacadmin	192.168.1.33	2025-10-08 19:37:02.32+00	\N
23	1	guacadmin	192.168.1.33	2025-10-08 19:37:07.075+00	\N
24	1	guacadmin	192.168.1.33	2025-10-08 19:37:10.523+00	\N
25	1	guacadmin	192.168.1.33	2025-10-08 19:37:13.246+00	\N
26	1	guacadmin	192.168.1.33	2025-10-08 19:37:15.532+00	\N
27	1	guacadmin	192.168.1.33	2025-10-08 19:37:18.775+00	2025-10-08 20:38:05.614+00
28	1	guacadmin	192.168.1.33	2025-10-12 16:06:12.171+00	\N
29	1	guacadmin	192.168.1.33	2025-10-12 16:06:12.28+00	\N
30	1	guacadmin	192.168.1.33	2025-10-12 16:06:16.519+00	\N
31	1	guacadmin	192.168.1.33	2025-10-12 16:06:18.732+00	\N
32	1	guacadmin	192.168.1.33	2025-10-12 16:06:19.236+00	\N
33	1	guacadmin	192.168.1.33	2025-10-12 16:06:26.722+00	\N
34	1	guacadmin	192.168.1.33	2025-10-12 16:07:00.991+00	\N
35	1	guacadmin	192.168.1.33	2025-10-12 16:07:06.383+00	\N
36	1	guacadmin	192.168.1.33	2025-10-12 16:07:10.264+00	\N
37	1	guacadmin	192.168.1.33	2025-10-12 16:07:12.881+00	\N
38	1	guacadmin	192.168.1.33	2025-10-12 16:07:36.211+00	\N
39	1	guacadmin	192.168.1.33	2025-10-12 16:07:37.633+00	\N
40	1	guacadmin	192.168.1.33	2025-10-12 16:07:38.643+00	\N
41	1	guacadmin	192.168.1.33	2025-10-12 16:07:45.128+00	\N
42	1	guacadmin	192.168.1.33	2025-10-12 16:07:47.17+00	\N
43	1	guacadmin	192.168.1.33	2025-10-12 16:07:55.269+00	\N
44	1	guacadmin	192.168.1.33	2025-10-12 16:07:57.669+00	\N
45	1	guacadmin	192.168.1.33	2025-10-12 16:07:58.791+00	2025-10-12 16:08:23.245+00
46	1	guacadmin	192.168.1.33	2025-10-12 17:36:04.276+00	\N
47	1	guacadmin	192.168.1.33	2025-10-12 17:36:04.327+00	\N
48	1	guacadmin	192.168.1.33	2025-10-12 17:36:08.873+00	2025-10-12 17:36:57.467+00
\.


--
-- Data for Name: guacamole_user_password_history; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_password_history (password_history_id, user_id, password_hash, password_salt, password_date) FROM stdin;
\.


--
-- Data for Name: guacamole_user_permission; Type: TABLE DATA; Schema: public; Owner: guacuser
--

COPY public.guacamole_user_permission (entity_id, affected_user_id, permission) FROM stdin;
1	1	READ
1	1	UPDATE
1	1	ADMINISTER
\.


--
-- Name: guacamole_connection_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_connection_connection_id_seq', 1, false);


--
-- Name: guacamole_connection_group_connection_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_connection_group_connection_group_id_seq', 1, false);


--
-- Name: guacamole_connection_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_connection_history_history_id_seq', 1, false);


--
-- Name: guacamole_entity_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_entity_entity_id_seq', 4, true);


--
-- Name: guacamole_sharing_profile_sharing_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_sharing_profile_sharing_profile_id_seq', 1, false);


--
-- Name: guacamole_user_group_user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_user_group_user_group_id_seq', 1, false);


--
-- Name: guacamole_user_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_user_history_history_id_seq', 48, true);


--
-- Name: guacamole_user_password_history_password_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_user_password_history_password_history_id_seq', 1, false);


--
-- Name: guacamole_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: guacuser
--

SELECT pg_catalog.setval('public.guacamole_user_user_id_seq', 4, true);


--
-- Name: guacamole_connection_group connection_group_name_parent; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group
    ADD CONSTRAINT connection_group_name_parent UNIQUE (connection_group_name, parent_id);


--
-- Name: guacamole_connection connection_name_parent; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection
    ADD CONSTRAINT connection_name_parent UNIQUE (connection_name, parent_id);


--
-- Name: guacamole_connection_attribute guacamole_connection_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_attribute
    ADD CONSTRAINT guacamole_connection_attribute_pkey PRIMARY KEY (connection_id, attribute_name);


--
-- Name: guacamole_connection_group_attribute guacamole_connection_group_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group_attribute
    ADD CONSTRAINT guacamole_connection_group_attribute_pkey PRIMARY KEY (connection_group_id, attribute_name);


--
-- Name: guacamole_connection_group_permission guacamole_connection_group_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group_permission
    ADD CONSTRAINT guacamole_connection_group_permission_pkey PRIMARY KEY (entity_id, connection_group_id, permission);


--
-- Name: guacamole_connection_group guacamole_connection_group_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group
    ADD CONSTRAINT guacamole_connection_group_pkey PRIMARY KEY (connection_group_id);


--
-- Name: guacamole_connection_history guacamole_connection_history_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_history
    ADD CONSTRAINT guacamole_connection_history_pkey PRIMARY KEY (history_id);


--
-- Name: guacamole_connection_parameter guacamole_connection_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_parameter
    ADD CONSTRAINT guacamole_connection_parameter_pkey PRIMARY KEY (connection_id, parameter_name);


--
-- Name: guacamole_connection_permission guacamole_connection_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_permission
    ADD CONSTRAINT guacamole_connection_permission_pkey PRIMARY KEY (entity_id, connection_id, permission);


--
-- Name: guacamole_connection guacamole_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection
    ADD CONSTRAINT guacamole_connection_pkey PRIMARY KEY (connection_id);


--
-- Name: guacamole_entity guacamole_entity_name_scope; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_entity
    ADD CONSTRAINT guacamole_entity_name_scope UNIQUE (type, name);


--
-- Name: guacamole_entity guacamole_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_entity
    ADD CONSTRAINT guacamole_entity_pkey PRIMARY KEY (entity_id);


--
-- Name: guacamole_sharing_profile_attribute guacamole_sharing_profile_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_attribute
    ADD CONSTRAINT guacamole_sharing_profile_attribute_pkey PRIMARY KEY (sharing_profile_id, attribute_name);


--
-- Name: guacamole_sharing_profile_parameter guacamole_sharing_profile_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_parameter
    ADD CONSTRAINT guacamole_sharing_profile_parameter_pkey PRIMARY KEY (sharing_profile_id, parameter_name);


--
-- Name: guacamole_sharing_profile_permission guacamole_sharing_profile_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_permission
    ADD CONSTRAINT guacamole_sharing_profile_permission_pkey PRIMARY KEY (entity_id, sharing_profile_id, permission);


--
-- Name: guacamole_sharing_profile guacamole_sharing_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile
    ADD CONSTRAINT guacamole_sharing_profile_pkey PRIMARY KEY (sharing_profile_id);


--
-- Name: guacamole_system_permission guacamole_system_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_system_permission
    ADD CONSTRAINT guacamole_system_permission_pkey PRIMARY KEY (entity_id, permission);


--
-- Name: guacamole_user_attribute guacamole_user_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_attribute
    ADD CONSTRAINT guacamole_user_attribute_pkey PRIMARY KEY (user_id, attribute_name);


--
-- Name: guacamole_user_group_attribute guacamole_user_group_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_attribute
    ADD CONSTRAINT guacamole_user_group_attribute_pkey PRIMARY KEY (user_group_id, attribute_name);


--
-- Name: guacamole_user_group_member guacamole_user_group_member_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_member
    ADD CONSTRAINT guacamole_user_group_member_pkey PRIMARY KEY (user_group_id, member_entity_id);


--
-- Name: guacamole_user_group_permission guacamole_user_group_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_permission
    ADD CONSTRAINT guacamole_user_group_permission_pkey PRIMARY KEY (entity_id, affected_user_group_id, permission);


--
-- Name: guacamole_user_group guacamole_user_group_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group
    ADD CONSTRAINT guacamole_user_group_pkey PRIMARY KEY (user_group_id);


--
-- Name: guacamole_user_group guacamole_user_group_single_entity; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group
    ADD CONSTRAINT guacamole_user_group_single_entity UNIQUE (entity_id);


--
-- Name: guacamole_user_history guacamole_user_history_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_history
    ADD CONSTRAINT guacamole_user_history_pkey PRIMARY KEY (history_id);


--
-- Name: guacamole_user_password_history guacamole_user_password_history_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_password_history
    ADD CONSTRAINT guacamole_user_password_history_pkey PRIMARY KEY (password_history_id);


--
-- Name: guacamole_user_permission guacamole_user_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_permission
    ADD CONSTRAINT guacamole_user_permission_pkey PRIMARY KEY (entity_id, affected_user_id, permission);


--
-- Name: guacamole_user guacamole_user_pkey; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user
    ADD CONSTRAINT guacamole_user_pkey PRIMARY KEY (user_id);


--
-- Name: guacamole_user guacamole_user_single_entity; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user
    ADD CONSTRAINT guacamole_user_single_entity UNIQUE (entity_id);


--
-- Name: guacamole_sharing_profile sharing_profile_name_primary; Type: CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile
    ADD CONSTRAINT sharing_profile_name_primary UNIQUE (sharing_profile_name, primary_connection_id);


--
-- Name: guacamole_connection_attribute_connection_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_attribute_connection_id ON public.guacamole_connection_attribute USING btree (connection_id);


--
-- Name: guacamole_connection_group_attribute_connection_group_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_group_attribute_connection_group_id ON public.guacamole_connection_group_attribute USING btree (connection_group_id);


--
-- Name: guacamole_connection_group_parent_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_group_parent_id ON public.guacamole_connection_group USING btree (parent_id);


--
-- Name: guacamole_connection_group_permission_connection_group_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_group_permission_connection_group_id ON public.guacamole_connection_group_permission USING btree (connection_group_id);


--
-- Name: guacamole_connection_group_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_group_permission_entity_id ON public.guacamole_connection_group_permission USING btree (entity_id);


--
-- Name: guacamole_connection_history_connection_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_connection_id ON public.guacamole_connection_history USING btree (connection_id);


--
-- Name: guacamole_connection_history_connection_id_start_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_connection_id_start_date ON public.guacamole_connection_history USING btree (connection_id, start_date);


--
-- Name: guacamole_connection_history_end_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_end_date ON public.guacamole_connection_history USING btree (end_date);


--
-- Name: guacamole_connection_history_sharing_profile_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_sharing_profile_id ON public.guacamole_connection_history USING btree (sharing_profile_id);


--
-- Name: guacamole_connection_history_start_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_start_date ON public.guacamole_connection_history USING btree (start_date);


--
-- Name: guacamole_connection_history_user_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_history_user_id ON public.guacamole_connection_history USING btree (user_id);


--
-- Name: guacamole_connection_parameter_connection_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_parameter_connection_id ON public.guacamole_connection_parameter USING btree (connection_id);


--
-- Name: guacamole_connection_parent_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_parent_id ON public.guacamole_connection USING btree (parent_id);


--
-- Name: guacamole_connection_permission_connection_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_permission_connection_id ON public.guacamole_connection_permission USING btree (connection_id);


--
-- Name: guacamole_connection_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_connection_permission_entity_id ON public.guacamole_connection_permission USING btree (entity_id);


--
-- Name: guacamole_sharing_profile_attribute_sharing_profile_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_sharing_profile_attribute_sharing_profile_id ON public.guacamole_sharing_profile_attribute USING btree (sharing_profile_id);


--
-- Name: guacamole_sharing_profile_parameter_sharing_profile_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_sharing_profile_parameter_sharing_profile_id ON public.guacamole_sharing_profile_parameter USING btree (sharing_profile_id);


--
-- Name: guacamole_sharing_profile_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_sharing_profile_permission_entity_id ON public.guacamole_sharing_profile_permission USING btree (entity_id);


--
-- Name: guacamole_sharing_profile_permission_sharing_profile_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_sharing_profile_permission_sharing_profile_id ON public.guacamole_sharing_profile_permission USING btree (sharing_profile_id);


--
-- Name: guacamole_sharing_profile_primary_connection_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_sharing_profile_primary_connection_id ON public.guacamole_sharing_profile USING btree (primary_connection_id);


--
-- Name: guacamole_system_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_system_permission_entity_id ON public.guacamole_system_permission USING btree (entity_id);


--
-- Name: guacamole_user_attribute_user_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_attribute_user_id ON public.guacamole_user_attribute USING btree (user_id);


--
-- Name: guacamole_user_group_attribute_user_group_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_group_attribute_user_group_id ON public.guacamole_user_group_attribute USING btree (user_group_id);


--
-- Name: guacamole_user_group_permission_affected_user_group_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_group_permission_affected_user_group_id ON public.guacamole_user_group_permission USING btree (affected_user_group_id);


--
-- Name: guacamole_user_group_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_group_permission_entity_id ON public.guacamole_user_group_permission USING btree (entity_id);


--
-- Name: guacamole_user_history_end_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_history_end_date ON public.guacamole_user_history USING btree (end_date);


--
-- Name: guacamole_user_history_start_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_history_start_date ON public.guacamole_user_history USING btree (start_date);


--
-- Name: guacamole_user_history_user_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_history_user_id ON public.guacamole_user_history USING btree (user_id);


--
-- Name: guacamole_user_history_user_id_start_date; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_history_user_id_start_date ON public.guacamole_user_history USING btree (user_id, start_date);


--
-- Name: guacamole_user_password_history_user_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_password_history_user_id ON public.guacamole_user_password_history USING btree (user_id);


--
-- Name: guacamole_user_permission_affected_user_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_permission_affected_user_id ON public.guacamole_user_permission USING btree (affected_user_id);


--
-- Name: guacamole_user_permission_entity_id; Type: INDEX; Schema: public; Owner: guacuser
--

CREATE INDEX guacamole_user_permission_entity_id ON public.guacamole_user_permission USING btree (entity_id);


--
-- Name: guacamole_connection_attribute guacamole_connection_attribute_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_attribute
    ADD CONSTRAINT guacamole_connection_attribute_ibfk_1 FOREIGN KEY (connection_id) REFERENCES public.guacamole_connection(connection_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_group_attribute guacamole_connection_group_attribute_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group_attribute
    ADD CONSTRAINT guacamole_connection_group_attribute_ibfk_1 FOREIGN KEY (connection_group_id) REFERENCES public.guacamole_connection_group(connection_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_group guacamole_connection_group_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group
    ADD CONSTRAINT guacamole_connection_group_ibfk_1 FOREIGN KEY (parent_id) REFERENCES public.guacamole_connection_group(connection_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_group_permission guacamole_connection_group_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group_permission
    ADD CONSTRAINT guacamole_connection_group_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_group_permission guacamole_connection_group_permission_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_group_permission
    ADD CONSTRAINT guacamole_connection_group_permission_ibfk_1 FOREIGN KEY (connection_group_id) REFERENCES public.guacamole_connection_group(connection_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_history guacamole_connection_history_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_history
    ADD CONSTRAINT guacamole_connection_history_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.guacamole_user(user_id) ON DELETE SET NULL;


--
-- Name: guacamole_connection_history guacamole_connection_history_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_history
    ADD CONSTRAINT guacamole_connection_history_ibfk_2 FOREIGN KEY (connection_id) REFERENCES public.guacamole_connection(connection_id) ON DELETE SET NULL;


--
-- Name: guacamole_connection_history guacamole_connection_history_ibfk_3; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_history
    ADD CONSTRAINT guacamole_connection_history_ibfk_3 FOREIGN KEY (sharing_profile_id) REFERENCES public.guacamole_sharing_profile(sharing_profile_id) ON DELETE SET NULL;


--
-- Name: guacamole_connection guacamole_connection_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection
    ADD CONSTRAINT guacamole_connection_ibfk_1 FOREIGN KEY (parent_id) REFERENCES public.guacamole_connection_group(connection_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_parameter guacamole_connection_parameter_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_parameter
    ADD CONSTRAINT guacamole_connection_parameter_ibfk_1 FOREIGN KEY (connection_id) REFERENCES public.guacamole_connection(connection_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_permission guacamole_connection_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_permission
    ADD CONSTRAINT guacamole_connection_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_connection_permission guacamole_connection_permission_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_connection_permission
    ADD CONSTRAINT guacamole_connection_permission_ibfk_1 FOREIGN KEY (connection_id) REFERENCES public.guacamole_connection(connection_id) ON DELETE CASCADE;


--
-- Name: guacamole_sharing_profile_attribute guacamole_sharing_profile_attribute_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_attribute
    ADD CONSTRAINT guacamole_sharing_profile_attribute_ibfk_1 FOREIGN KEY (sharing_profile_id) REFERENCES public.guacamole_sharing_profile(sharing_profile_id) ON DELETE CASCADE;


--
-- Name: guacamole_sharing_profile guacamole_sharing_profile_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile
    ADD CONSTRAINT guacamole_sharing_profile_ibfk_1 FOREIGN KEY (primary_connection_id) REFERENCES public.guacamole_connection(connection_id) ON DELETE CASCADE;


--
-- Name: guacamole_sharing_profile_parameter guacamole_sharing_profile_parameter_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_parameter
    ADD CONSTRAINT guacamole_sharing_profile_parameter_ibfk_1 FOREIGN KEY (sharing_profile_id) REFERENCES public.guacamole_sharing_profile(sharing_profile_id) ON DELETE CASCADE;


--
-- Name: guacamole_sharing_profile_permission guacamole_sharing_profile_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_permission
    ADD CONSTRAINT guacamole_sharing_profile_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_sharing_profile_permission guacamole_sharing_profile_permission_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_sharing_profile_permission
    ADD CONSTRAINT guacamole_sharing_profile_permission_ibfk_1 FOREIGN KEY (sharing_profile_id) REFERENCES public.guacamole_sharing_profile(sharing_profile_id) ON DELETE CASCADE;


--
-- Name: guacamole_system_permission guacamole_system_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_system_permission
    ADD CONSTRAINT guacamole_system_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_attribute guacamole_user_attribute_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_attribute
    ADD CONSTRAINT guacamole_user_attribute_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.guacamole_user(user_id) ON DELETE CASCADE;


--
-- Name: guacamole_user guacamole_user_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user
    ADD CONSTRAINT guacamole_user_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group_attribute guacamole_user_group_attribute_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_attribute
    ADD CONSTRAINT guacamole_user_group_attribute_ibfk_1 FOREIGN KEY (user_group_id) REFERENCES public.guacamole_user_group(user_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group guacamole_user_group_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group
    ADD CONSTRAINT guacamole_user_group_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group_member guacamole_user_group_member_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_member
    ADD CONSTRAINT guacamole_user_group_member_entity FOREIGN KEY (member_entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group_member guacamole_user_group_member_parent; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_member
    ADD CONSTRAINT guacamole_user_group_member_parent FOREIGN KEY (user_group_id) REFERENCES public.guacamole_user_group(user_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group_permission guacamole_user_group_permission_affected_user_group; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_permission
    ADD CONSTRAINT guacamole_user_group_permission_affected_user_group FOREIGN KEY (affected_user_group_id) REFERENCES public.guacamole_user_group(user_group_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_group_permission guacamole_user_group_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_group_permission
    ADD CONSTRAINT guacamole_user_group_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_history guacamole_user_history_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_history
    ADD CONSTRAINT guacamole_user_history_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.guacamole_user(user_id) ON DELETE SET NULL;


--
-- Name: guacamole_user_password_history guacamole_user_password_history_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_password_history
    ADD CONSTRAINT guacamole_user_password_history_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.guacamole_user(user_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_permission guacamole_user_permission_entity; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_permission
    ADD CONSTRAINT guacamole_user_permission_entity FOREIGN KEY (entity_id) REFERENCES public.guacamole_entity(entity_id) ON DELETE CASCADE;


--
-- Name: guacamole_user_permission guacamole_user_permission_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: guacuser
--

ALTER TABLE ONLY public.guacamole_user_permission
    ADD CONSTRAINT guacamole_user_permission_ibfk_1 FOREIGN KEY (affected_user_id) REFERENCES public.guacamole_user(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict YysCRm8RUaffvqzIgXuvYWFmo823MwQuAOWrKL7MyxAoCyE5SMqFEgaw6fE7I1s

