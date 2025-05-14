--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10
-- Dumped by pg_dump version 16.4

-- Started on 2025-04-25 10:15:07

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
-- TOC entry 6 (class 2615 OID 16902)
-- Name: process_paas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA process_paas;


ALTER SCHEMA process_paas OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 255 (class 1259 OID 16903)
-- Name: pr_paas_access_point; Type: TABLE; Schema: process_paas; Owner: postgres
--

SET SCHEMA process_paas;

CREATE TABLE pr_paas_access_point (
    id_access_point integer NOT NULL,
    pr_end_dt timestamp(6) without time zone,
    pr_modification_ts timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_ap_app character varying(50),
    pr_ap_description character varying(256),
    pr_ap_device character varying(50),
    pr_ap_os character varying(50),
    pr_ap_type_user character varying(50),
    pr_creation_user character varying(256),
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_access_point OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16908)
-- Name: pr_paas_access_point_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_access_point_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_access_point_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 256
-- Name: pr_paas_access_point_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_access_point_id_appian_seq OWNED BY pr_paas_access_point.id_appian;


--
-- TOC entry 257 (class 1259 OID 16909)
-- Name: pr_paas_access_point_sq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_access_point_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_access_point_sq OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 16910)
-- Name: pr_paas_case_event_tracker_sq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_event_tracker_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_event_tracker_sq OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16911)
-- Name: pr_paas_case_event_tracker; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_case_event_tracker (
    pr_case bigint DEFAULT nextval('pr_paas_case_event_tracker_sq'::regclass) NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_center character varying(4) NOT NULL,
    id_event integer NOT NULL,
    pr_event_trigger_accesspoint integer NOT NULL,
    pr_event_data character varying(3200),
    pr_event_trigger_ts timestamp without time zone,
    pr_ap_device character varying(50),
    pr_ap_os character varying(50),
    pr_ap_type_user character varying(50),
    pr_ap_app character varying(50),
    event_tracker_id integer NOT NULL,
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_case_event_tracker OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 16917)
-- Name: pr_paas_case_event_tracker_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_event_tracker_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_event_tracker_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 260
-- Name: pr_paas_case_event_tracker_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_case_event_tracker_id_appian_seq OWNED BY pr_paas_case_event_tracker.id_appian;


--
-- TOC entry 261 (class 1259 OID 16918)
-- Name: pr_paas_case_stage_tracker_sq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_stage_tracker_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_stage_tracker_sq OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 16919)
-- Name: pr_paas_case_stage_tracker; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_case_stage_tracker (
    pr_case bigint DEFAULT nextval('pr_paas_case_stage_tracker_sq'::regclass) NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer,
    id_center character varying(256) NOT NULL,
    pr_id_stage integer,
    pr_stage_start_user character varying(256),
    pr_stage_start_ts timestamp(6) without time zone,
    pr_stage_accesspoint_start integer,
    pr_ap_type_user_start character varying(256),
    pr_ap_app_start character varying(256),
    pr_ap_device_start character varying(256),
    pr_ap_os_start character varying(256),
    pr_stage_end_user character varying(256),
    pr_stage_end_ts timestamp(6) without time zone,
    pr_stage_accesspoint_end integer,
    pr_ap_type_end character varying(256),
    pr_ap_app_end character varying(256),
    pr_ap_device_end character varying(256),
    pr_ap_os_end character varying(256),
    pr_stage_time_spent character varying GENERATED ALWAYS AS (
CASE
    WHEN ((pr_stage_end_ts IS NOT NULL) AND (pr_stage_start_ts IS NOT NULL)) THEN ((((((((((floor(date_part('day'::text, (pr_stage_end_ts - pr_stage_start_ts))))::text || ' '::text) || lpad((floor((((date_part('hour'::text, (pr_stage_end_ts - pr_stage_start_ts)))::integer % 24))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('minute'::text, (pr_stage_end_ts - pr_stage_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('second'::text, (pr_stage_end_ts - pr_stage_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || '.'::text) || lpad((floor((((date_part('microsecond'::text, (pr_stage_end_ts - pr_stage_start_ts)))::integer % 1000000))::double precision))::text, 3, '0'::text)))::character varying
    ELSE NULL::character varying
END) STORED,
    stage_tracker_id bigint NOT NULL,
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_case_stage_tracker OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16926)
-- Name: pr_paas_case_stage_tracker_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_stage_tracker_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_stage_tracker_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 263
-- Name: pr_paas_case_stage_tracker_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_case_stage_tracker_id_appian_seq OWNED BY pr_paas_case_stage_tracker.id_appian;


--
-- TOC entry 299 (class 1259 OID 17123)
-- Name: pr_paas_case_status_tracker; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_case_status_tracker (
    pr_case bigint NOT NULL,
    id_center character varying(255) NOT NULL,
    pr_entity character varying(255) NOT NULL,
    status_tracker_id bigint NOT NULL,
    pr_status_accesspoint_end integer,
    pr_ap_app_end character varying(255),
    pr_ap_device_end character varying(255),
    pr_ap_os_end character varying(255),
    pr_ap_type_user_end character varying(255),
    pr_status_end_ts timestamp(6) without time zone,
    pr_status_end_user character varying(255),
    is_final boolean,
    id_process integer,
    pr_ap_device_start character varying(255),
    pr_ap_os_start character varying(255),
    pr_status_accesspoint_start integer,
    pr_ap_app_start character varying(255),
    pr_ap_type_user_start character varying(255),
    pr_status_start_ts timestamp(6) without time zone,
    pr_status_start_user character varying(255),
    pr_status integer,
    pr_status_time_spent character varying GENERATED ALWAYS AS (
CASE
    WHEN ((pr_status_end_ts IS NOT NULL) AND (pr_status_start_ts IS NOT NULL)) THEN ((((((((((floor(date_part('day'::text, (pr_status_end_ts - pr_status_start_ts))))::text || ' '::text) || lpad((floor((((date_part('hour'::text, (pr_status_end_ts - pr_status_start_ts)))::integer % 24))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('minute'::text, (pr_status_end_ts - pr_status_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('second'::text, (pr_status_end_ts - pr_status_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || '.'::text) || lpad((floor((((date_part('microsecond'::text, (pr_status_end_ts - pr_status_start_ts)))::integer % 1000000))::double precision))::text, 3, '0'::text)))::character varying
    ELSE NULL::character varying
END) STORED
);


ALTER TABLE pr_paas_case_status_tracker OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 16927)
-- Name: pr_paas_case_status_tracker_sq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_status_tracker_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_status_tracker_sq OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16936)
-- Name: pr_paas_case_task_tracker_sq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_task_tracker_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_task_tracker_sq OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 16937)
-- Name: pr_paas_case_task_tracker; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_case_task_tracker (
    pr_case bigint DEFAULT nextval('pr_paas_case_task_tracker_sq'::regclass) NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer,
    id_center character varying(256) NOT NULL,
    id_task integer,
    pr_action integer,
    pr_audit_type character varying(256),
    pr_asignee character varying(256),
    pr_group integer,
    pr_task_start_user character varying(256),
    pr_task_start_ts timestamp(6) without time zone,
    pr_task_accesspoint_start integer,
    pr_ap_type_user_start character varying(256),
    pr_ap_app_start character varying(256),
    pr_ap_device_start character varying(256),
    pr_ap_os_start character varying(256),
    pr_task_end_user character varying(256),
    pr_task_end_ts timestamp(6) without time zone,
    pr_task_accesspoint_end integer,
    pr_ap_type_end character varying(256),
    pr_ap_app_end character varying(256),
    pr_ap_device_end character varying(256),
    pr_ap_os_end character varying(256),
    pr_task_time_spent character varying GENERATED ALWAYS AS (
CASE
    WHEN ((pr_task_end_ts IS NOT NULL) AND (pr_task_start_ts IS NOT NULL)) THEN ((((((((((floor(date_part('day'::text, (pr_task_end_ts - pr_task_start_ts))))::text || ' '::text) || lpad((floor((((date_part('hour'::text, (pr_task_end_ts - pr_task_start_ts)))::integer % 24))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('minute'::text, (pr_task_end_ts - pr_task_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || ':'::text) || lpad((floor((((date_part('second'::text, (pr_task_end_ts - pr_task_start_ts)))::integer % 60))::double precision))::text, 2, ''::text)) || '.'::text) || lpad((floor((((date_part('microsecond'::text, (pr_task_end_ts - pr_task_start_ts)))::integer % 1000000))::double precision))::text, 3, '0'::text)))::character varying
    ELSE NULL::character varying
END) STORED,
    task_tracker_id bigint NOT NULL,
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_case_task_tracker OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 16944)
-- Name: pr_paas_case_task_tracker_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_case_task_tracker_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_case_task_tracker_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 267
-- Name: pr_paas_case_task_tracker_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_case_task_tracker_id_appian_seq OWNED BY pr_paas_case_task_tracker.id_appian;


--
-- TOC entry 268 (class 1259 OID 16945)
-- Name: pr_paas_customer_case; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_customer_case (
    id_case bigint NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    pr_center character varying(4) NOT NULL,
    pr_customer_id character varying(256) NOT NULL,
    pr_start_ts timestamp without time zone,
    pr_modification_ts timestamp without time zone,
    pr_creation_user character varying(256),
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_customer_case OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 16950)
-- Name: pr_paas_customer_case_historic; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_customer_case_historic (
    id_case bigint NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    pr_center character varying(4) NOT NULL,
    pr_customer_id character varying(256) NOT NULL,
    pr_start_ts timestamp without time zone,
    pr_modification_ts timestamp without time zone,
    pr_creation_user character varying(256),
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_customer_case_historic OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 16955)
-- Name: pr_paas_customer_case_historic_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_customer_case_historic_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_customer_case_historic_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 270
-- Name: pr_paas_customer_case_historic_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_customer_case_historic_id_appian_seq OWNED BY pr_paas_customer_case_historic.id_appian;


--
-- TOC entry 271 (class 1259 OID 16956)
-- Name: pr_paas_customer_case_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_customer_case_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_customer_case_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 271
-- Name: pr_paas_customer_case_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_customer_case_id_appian_seq OWNED BY pr_paas_customer_case.id_appian;


--
-- TOC entry 272 (class 1259 OID 16957)
-- Name: pr_paas_process; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    pr_name character varying(50),
    pr_description character varying(256),
    pr_owner character varying(50),
    pr_group character varying(50),
    is_reusable boolean,
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 16962)
-- Name: pr_paas_process_access_point; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_access_point (
    pr_entity character varying(4) DEFAULT nextval('pr_paas_access_point_sq'::regclass),
    id_process integer,
    id_access_point integer NOT NULL,
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_access_point OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 16968)
-- Name: pr_paas_process_access_point_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_access_point_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_access_point_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 274
-- Name: pr_paas_process_access_point_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_access_point_id_appian_seq OWNED BY pr_paas_process_access_point.id_appian;


--
-- TOC entry 275 (class 1259 OID 16969)
-- Name: pr_paas_process_case_new_id_case_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_case_new_id_case_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE pr_paas_process_case_new_id_case_seq OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 16970)
-- Name: pr_paas_process_case; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_case (
    id_case bigint DEFAULT nextval('pr_paas_process_case_new_id_case_seq'::regclass) NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    pr_center character varying(4) NOT NULL,
    pr_stage integer,
    pr_status integer NOT NULL,
    pr_ext_reference character varying(3200),
    pr_start_access_point integer NOT NULL,
    pr_start_ts timestamp without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL,
    specific_data character varying(3200)
);


ALTER TABLE pr_paas_process_case OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 16976)
-- Name: pr_paas_process_case_historic; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_case_historic (
    id_case bigint NOT NULL,
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    pr_center character varying(4) NOT NULL,
    pr_stage integer,
    pr_status integer NOT NULL,
    pr_ext_reference character varying(3200),
    pr_start_access_point integer NOT NULL,
    pr_start_ts timestamp without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp without time zone,
    pr_modification_user character varying(256),
    pr_case_life_time bigint GENERATED ALWAYS AS (
CASE
    WHEN ((pr_modification_ts IS NOT NULL) AND (pr_start_ts IS NOT NULL)) THEN (((((((((((floor(date_part('day'::text, (pr_modification_ts - pr_start_ts))))::bigint * 24) * 60) * 60) * 1000))::double precision + (((floor((((date_part('hour'::text, (pr_modification_ts - pr_start_ts)))::bigint % (24)::bigint))::double precision) * (60)::double precision) * (60)::double precision) * (1000)::double precision)) + ((floor((((date_part('minute'::text, (pr_modification_ts - pr_start_ts)))::bigint % (60)::bigint))::double precision) * (60)::double precision) * (1000)::double precision)) + (floor((((date_part('second'::text, (pr_modification_ts - pr_start_ts)))::bigint % (60)::bigint))::double precision) * (1000)::double precision)) + (
    CASE
        WHEN ((floor(date_part('milliseconds'::text, (pr_modification_ts - pr_start_ts))))::bigint > 500) THEN ((floor(date_part('milliseconds'::text, (pr_modification_ts - pr_start_ts))))::bigint - 1000)
        ELSE (floor(date_part('milliseconds'::text, (pr_modification_ts - pr_start_ts))))::bigint
    END)::double precision))::bigint
    ELSE (0)::bigint
END) STORED,
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_case_historic OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 16982)
-- Name: pr_paas_process_case_historic_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_case_historic_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_case_historic_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 278
-- Name: pr_paas_process_case_historic_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_case_historic_id_appian_seq OWNED BY pr_paas_process_case_historic.id_appian;


--
-- TOC entry 279 (class 1259 OID 16983)
-- Name: pr_paas_process_case_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_case_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_case_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 279
-- Name: pr_paas_process_case_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_case_id_appian_seq OWNED BY pr_paas_process_case.id_appian;


--
-- TOC entry 280 (class 1259 OID 16984)
-- Name: pr_paas_process_event; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_event (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_event integer NOT NULL,
    pr_event_name character varying(25),
    pr_event_description character varying(256),
    pr_origin_app character varying(50),
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_event OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 16989)
-- Name: pr_paas_process_event_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_event_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_event_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 281
-- Name: pr_paas_process_event_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_event_id_appian_seq OWNED BY pr_paas_process_event.id_appian;


--
-- TOC entry 282 (class 1259 OID 16990)
-- Name: pr_paas_process_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 282
-- Name: pr_paas_process_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_id_appian_seq OWNED BY pr_paas_process.id_appian;


--
-- TOC entry 283 (class 1259 OID 16991)
-- Name: pr_paas_process_management; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_management (
    id_management bigint NOT NULL,
    id_process integer NOT NULL,
    pr_entity character varying(4) NOT NULL,
    dns character varying(200) NOT NULL,
    pr_realm character varying(100) NOT NULL,
    pr_start_ts timestamp without time zone,
    pr_creation_user character varying(100),
    pr_modification_ts timestamp without time zone,
    pr_modification_user character varying(100),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_management OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 16996)
-- Name: pr_paas_process_management_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_management_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_management_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 284
-- Name: pr_paas_process_management_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_management_id_appian_seq OWNED BY pr_paas_process_management.id_appian;


--
-- TOC entry 285 (class 1259 OID 16997)
-- Name: pr_paas_process_management_id_management_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_management_id_management_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE pr_paas_process_management_id_management_seq OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 16998)
-- Name: pr_paas_process_management_id_management_seq1; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_management_id_management_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_management_id_management_seq1 OWNER TO postgres;

--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 286
-- Name: pr_paas_process_management_id_management_seq1; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_management_id_management_seq1 OWNED BY pr_paas_process_management.id_management;


--
-- TOC entry 287 (class 1259 OID 16999)
-- Name: pr_paas_process_reserved_case; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_reserved_case (
    id_case bigint NOT NULL,
    id_process integer NOT NULL,
    pr_entity character varying(4) NOT NULL,
    pr_center character varying(4),
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_reserved_case OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17002)
-- Name: pr_paas_process_reserved_case_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_reserved_case_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_reserved_case_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 288
-- Name: pr_paas_process_reserved_case_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_reserved_case_id_appian_seq OWNED BY pr_paas_process_reserved_case.id_appian;


--
-- TOC entry 289 (class 1259 OID 17003)
-- Name: pr_paas_process_stage; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_stage (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_stage integer NOT NULL,
    pr_stage_name character varying(25),
    pr_stage_description character varying(50),
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_stage OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17008)
-- Name: pr_paas_process_stage_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_stage_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_stage_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 290
-- Name: pr_paas_process_stage_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_stage_id_appian_seq OWNED BY pr_paas_process_stage.id_appian;


--
-- TOC entry 291 (class 1259 OID 17009)
-- Name: pr_paas_process_status; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_status (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_status integer NOT NULL,
    pr_status_name character varying(25),
    pr_status_description character varying(256),
    pr_status_type integer,
    pr_stage integer,
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_status OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17014)
-- Name: pr_paas_process_status_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_status_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_status_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 292
-- Name: pr_paas_process_status_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_status_id_appian_seq OWNED BY pr_paas_process_status.id_appian;


--
-- TOC entry 293 (class 1259 OID 17015)
-- Name: pr_paas_process_status_type; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_status_type (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_status_type integer NOT NULL,
    pr_type_name character varying(25),
    pr_type_description character varying(256),
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_status_type OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17020)
-- Name: pr_paas_process_status_type_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_status_type_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_status_type_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 294
-- Name: pr_paas_process_status_type_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_status_type_id_appian_seq OWNED BY pr_paas_process_status_type.id_appian;


--
-- TOC entry 295 (class 1259 OID 17021)
-- Name: pr_paas_process_task; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_process_task (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_task integer NOT NULL,
    pr_task_name character varying(50),
    pr_task_description character varying(256),
    pr_task_link character varying(2048),
    type_task integer,
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_process_task OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17026)
-- Name: pr_paas_process_task_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_process_task_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_process_task_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 296
-- Name: pr_paas_process_task_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_process_task_id_appian_seq OWNED BY pr_paas_process_task.id_appian;


--
-- TOC entry 297 (class 1259 OID 17027)
-- Name: pr_paas_task_action; Type: TABLE; Schema: process_paas; Owner: postgres
--

CREATE TABLE pr_paas_task_action (
    pr_entity character varying(4) NOT NULL,
    id_process integer NOT NULL,
    id_action integer NOT NULL,
    pr_action_name character varying(25),
    pr_action_description character varying(256),
    id_task integer,
    id_access_point integer,
    id_group integer,
    pr_end_dt timestamp(6) without time zone,
    pr_start_ts timestamp(6) without time zone,
    pr_creation_user character varying(256),
    pr_modification_ts timestamp(6) without time zone,
    pr_modification_user character varying(256),
    id_appian integer NOT NULL
);


ALTER TABLE pr_paas_task_action OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17032)
-- Name: pr_paas_task_action_id_appian_seq; Type: SEQUENCE; Schema: process_paas; Owner: postgres
--

CREATE SEQUENCE pr_paas_task_action_id_appian_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr_paas_task_action_id_appian_seq OWNER TO postgres;

--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 298
-- Name: pr_paas_task_action_id_appian_seq; Type: SEQUENCE OWNED BY; Schema: process_paas; Owner: postgres
--

ALTER SEQUENCE pr_paas_task_action_id_appian_seq OWNED BY pr_paas_task_action.id_appian;


--
-- TOC entry 3393 (class 2604 OID 17033)
-- Name: pr_paas_access_point id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_access_point ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_access_point_id_appian_seq'::regclass);


--
-- TOC entry 3395 (class 2604 OID 17034)
-- Name: pr_paas_case_event_tracker id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_event_tracker ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_case_event_tracker_id_appian_seq'::regclass);


--
-- TOC entry 3398 (class 2604 OID 17035)
-- Name: pr_paas_case_stage_tracker id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_stage_tracker ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_case_stage_tracker_id_appian_seq'::regclass);


--
-- TOC entry 3401 (class 2604 OID 17037)
-- Name: pr_paas_case_task_tracker id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_task_tracker ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_case_task_tracker_id_appian_seq'::regclass);


--
-- TOC entry 3402 (class 2604 OID 17038)
-- Name: pr_paas_customer_case id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_customer_case ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_customer_case_id_appian_seq'::regclass);


--
-- TOC entry 3403 (class 2604 OID 17039)
-- Name: pr_paas_customer_case_historic id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_customer_case_historic ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_customer_case_historic_id_appian_seq'::regclass);


--
-- TOC entry 3404 (class 2604 OID 17040)
-- Name: pr_paas_process id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_id_appian_seq'::regclass);


--
-- TOC entry 3406 (class 2604 OID 17041)
-- Name: pr_paas_process_access_point id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_access_point ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_access_point_id_appian_seq'::regclass);


--
-- TOC entry 3408 (class 2604 OID 17042)
-- Name: pr_paas_process_case id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_case ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_case_id_appian_seq'::regclass);


--
-- TOC entry 3410 (class 2604 OID 17043)
-- Name: pr_paas_process_case_historic id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_case_historic ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_case_historic_id_appian_seq'::regclass);


--
-- TOC entry 3411 (class 2604 OID 17044)
-- Name: pr_paas_process_event id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_event ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_event_id_appian_seq'::regclass);


--
-- TOC entry 3412 (class 2604 OID 17045)
-- Name: pr_paas_process_management id_management; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_management ALTER COLUMN id_management SET DEFAULT nextval('pr_paas_process_management_id_management_seq1'::regclass);


--
-- TOC entry 3413 (class 2604 OID 17046)
-- Name: pr_paas_process_management id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_management ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_management_id_appian_seq'::regclass);


--
-- TOC entry 3414 (class 2604 OID 17047)
-- Name: pr_paas_process_reserved_case id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_reserved_case ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_reserved_case_id_appian_seq'::regclass);


--
-- TOC entry 3415 (class 2604 OID 17048)
-- Name: pr_paas_process_stage id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_stage ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_stage_id_appian_seq'::regclass);


--
-- TOC entry 3416 (class 2604 OID 17049)
-- Name: pr_paas_process_status id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_status ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_status_id_appian_seq'::regclass);


--
-- TOC entry 3417 (class 2604 OID 17050)
-- Name: pr_paas_process_status_type id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_status_type ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_status_type_id_appian_seq'::regclass);


--
-- TOC entry 3418 (class 2604 OID 17051)
-- Name: pr_paas_process_task id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_task ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_process_task_id_appian_seq'::regclass);


--
-- TOC entry 3419 (class 2604 OID 17052)
-- Name: pr_paas_task_action id_appian; Type: DEFAULT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_task_action ALTER COLUMN id_appian SET DEFAULT nextval('pr_paas_task_action_id_appian_seq'::regclass);


--
-- TOC entry 3422 (class 2606 OID 17054)
-- Name: pr_paas_access_point pr_paas_access_point_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_access_point
    ADD CONSTRAINT pr_paas_access_point_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3424 (class 2606 OID 17056)
-- Name: pr_paas_case_event_tracker pr_paas_case_event_tracker_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_event_tracker
    ADD CONSTRAINT pr_paas_case_event_tracker_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3426 (class 2606 OID 17058)
-- Name: pr_paas_case_stage_tracker pr_paas_case_stage_tracker_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_stage_tracker
    ADD CONSTRAINT pr_paas_case_stage_tracker_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3428 (class 2606 OID 17062)
-- Name: pr_paas_case_task_tracker pr_paas_case_task_tracker_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_task_tracker
    ADD CONSTRAINT pr_paas_case_task_tracker_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3432 (class 2606 OID 17064)
-- Name: pr_paas_customer_case_historic pr_paas_customer_case_historic_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_customer_case_historic
    ADD CONSTRAINT pr_paas_customer_case_historic_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3430 (class 2606 OID 17066)
-- Name: pr_paas_customer_case pr_paas_customer_case_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_customer_case
    ADD CONSTRAINT pr_paas_customer_case_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3436 (class 2606 OID 17068)
-- Name: pr_paas_process_access_point pr_paas_process_access_point_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_access_point
    ADD CONSTRAINT pr_paas_process_access_point_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3440 (class 2606 OID 17070)
-- Name: pr_paas_process_case_historic pr_paas_process_case_historic_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_case_historic
    ADD CONSTRAINT pr_paas_process_case_historic_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3438 (class 2606 OID 17072)
-- Name: pr_paas_process_case pr_paas_process_case_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_case
    ADD CONSTRAINT pr_paas_process_case_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3442 (class 2606 OID 17074)
-- Name: pr_paas_process_event pr_paas_process_event_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_event
    ADD CONSTRAINT pr_paas_process_event_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3444 (class 2606 OID 17076)
-- Name: pr_paas_process_management pr_paas_process_management_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_management
    ADD CONSTRAINT pr_paas_process_management_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3434 (class 2606 OID 17078)
-- Name: pr_paas_process pr_paas_process_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process
    ADD CONSTRAINT pr_paas_process_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3448 (class 2606 OID 17080)
-- Name: pr_paas_process_reserved_case pr_paas_process_reserved_case_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_reserved_case
    ADD CONSTRAINT pr_paas_process_reserved_case_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3450 (class 2606 OID 17082)
-- Name: pr_paas_process_stage pr_paas_process_stage_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_stage
    ADD CONSTRAINT pr_paas_process_stage_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3452 (class 2606 OID 17084)
-- Name: pr_paas_process_status pr_paas_process_status_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_status
    ADD CONSTRAINT pr_paas_process_status_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3454 (class 2606 OID 17086)
-- Name: pr_paas_process_status_type pr_paas_process_status_type_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_status_type
    ADD CONSTRAINT pr_paas_process_status_type_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3456 (class 2606 OID 17088)
-- Name: pr_paas_process_task pr_paas_process_task_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_task
    ADD CONSTRAINT pr_paas_process_task_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3458 (class 2606 OID 17090)
-- Name: pr_paas_task_action pr_paas_task_action_pkey; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_task_action
    ADD CONSTRAINT pr_paas_task_action_pkey PRIMARY KEY (id_appian);


--
-- TOC entry 3446 (class 2606 OID 17092)
-- Name: pr_paas_process_management process_management_un; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_process_management
    ADD CONSTRAINT process_management_un UNIQUE (id_process, pr_entity, dns);


--
-- TOC entry 3460 (class 2606 OID 17130)
-- Name: pr_paas_case_status_tracker status_tracker_pk; Type: CONSTRAINT; Schema: process_paas; Owner: postgres
--

ALTER TABLE ONLY pr_paas_case_status_tracker
    ADD CONSTRAINT status_tracker_pk PRIMARY KEY (pr_case, id_center, pr_entity, status_tracker_id);


-- Completed on 2025-04-25 10:15:07

--
-- PostgreSQL database dump complete
--

