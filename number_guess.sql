--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: username; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.username (
    username_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.username OWNER TO freecodecamp;

--
-- Name: guess_guess_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guess_guess_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guess_guess_id_seq OWNER TO freecodecamp;

--
-- Name: guess_guess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guess_guess_id_seq OWNED BY public.username.username_id;


--
-- Name: number_guess; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.number_guess (
    game_number_id integer NOT NULL,
    username_id integer NOT NULL,
    number_guess integer NOT NULL,
    number_of_tries integer DEFAULT 0
);


ALTER TABLE public.number_guess OWNER TO freecodecamp;

--
-- Name: number_guess_game_number_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.number_guess_game_number_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.number_guess_game_number_id_seq OWNER TO freecodecamp;

--
-- Name: number_guess_game_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.number_guess_game_number_id_seq OWNED BY public.number_guess.game_number_id;


--
-- Name: number_guess game_number_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.number_guess ALTER COLUMN game_number_id SET DEFAULT nextval('public.number_guess_game_number_id_seq'::regclass);


--
-- Name: username username_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.username ALTER COLUMN username_id SET DEFAULT nextval('public.guess_guess_id_seq'::regclass);


--
-- Data for Name: number_guess; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.number_guess VALUES (1, 17, 818, 0);
INSERT INTO public.number_guess VALUES (2, 28, 925, 0);
INSERT INTO public.number_guess VALUES (3, 28, 417, 0);
INSERT INTO public.number_guess VALUES (4, 29, 959, 0);
INSERT INTO public.number_guess VALUES (5, 29, 93, 0);
INSERT INTO public.number_guess VALUES (6, 28, 937, 0);
INSERT INTO public.number_guess VALUES (7, 28, 672, 0);
INSERT INTO public.number_guess VALUES (8, 28, 900, 0);


--
-- Data for Name: username; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.username VALUES (1, 'user_1676623280048');
INSERT INTO public.username VALUES (2, 'user_1676623280047');
INSERT INTO public.username VALUES (3, 'user_1676624236522');
INSERT INTO public.username VALUES (4, 'user_1676624236521');
INSERT INTO public.username VALUES (5, 'user_1676624610011');
INSERT INTO public.username VALUES (6, 'user_1676624610010');
INSERT INTO public.username VALUES (7, 'user_1676626010833');
INSERT INTO public.username VALUES (8, 'user_1676626010832');
INSERT INTO public.username VALUES (9, 'user_1676626869403');
INSERT INTO public.username VALUES (10, 'user_1676626869402');
INSERT INTO public.username VALUES (11, 'user_1676627429304');
INSERT INTO public.username VALUES (12, 'user_1676627429303');
INSERT INTO public.username VALUES (13, 'user_1676627710617');
INSERT INTO public.username VALUES (14, 'user_1676627710616');
INSERT INTO public.username VALUES (15, 'user_1676628684260');
INSERT INTO public.username VALUES (16, 'user_1676628684259');
INSERT INTO public.username VALUES (17, 'Budi');
INSERT INTO public.username VALUES (18, 'asd');
INSERT INTO public.username VALUES (19, 'g');
INSERT INTO public.username VALUES (20, 'user_1676629325222');
INSERT INTO public.username VALUES (21, 'user_1676629325221');
INSERT INTO public.username VALUES (22, '10');
INSERT INTO public.username VALUES (23, 'user_1676631070451');
INSERT INTO public.username VALUES (24, 'user_1676631070450');
INSERT INTO public.username VALUES (25, 'BUdi');
INSERT INTO public.username VALUES (26, 'user_1676632156013');
INSERT INTO public.username VALUES (27, 'user_1676632156012');
INSERT INTO public.username VALUES (28, 'user_1676632748189');
INSERT INTO public.username VALUES (29, 'user_1676632748188');


--
-- Name: guess_guess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guess_guess_id_seq', 29, true);


--
-- Name: number_guess_game_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.number_guess_game_number_id_seq', 8, true);


--
-- Name: username guess_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.username
    ADD CONSTRAINT guess_pkey PRIMARY KEY (username_id);


--
-- Name: number_guess number_guess_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.number_guess
    ADD CONSTRAINT number_guess_pkey PRIMARY KEY (game_number_id);


--
-- Name: number_guess number_guess_username_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.number_guess
    ADD CONSTRAINT number_guess_username_id_fkey FOREIGN KEY (username_id) REFERENCES public.username(username_id);


--
-- PostgreSQL database dump complete
--

