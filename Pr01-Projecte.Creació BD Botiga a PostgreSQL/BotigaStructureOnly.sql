--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.1

-- Started on 2018-02-16 15:54:28

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12278)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 512 (class 1247 OID 16388)
-- Name: Adreça; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "Adreça" AS (
	poblacion text,
	provincia text,
	cp text,
	domicili text
);


ALTER TYPE "Adreça" OWNER TO postgres;

--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 512
-- Name: TYPE "Adreça"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE "Adreça" IS 'Campo Adreça de la tabla Personas';


--
-- TOC entry 612 (class 1247 OID 16436)
-- Name: Juego; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "Juego" AS (
	id character varying(120),
	nombre character varying(120),
	precio double precision,
	id_proveedor character varying(120),
	edad_minima integer
);


ALTER TYPE "Juego" OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16389)
-- Name: Personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Personas" (
    id character varying(30) NOT NULL,
    nombre character varying(120) NOT NULL,
    apellido character varying(120) NOT NULL,
    "adreça" "Adreça",
    telefon character varying(30)
);


ALTER TABLE "Personas" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16397)
-- Name: Clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Clientes" (
    empresa character varying(120),
    limite_credito double precision
)
INHERITS ("Personas");


ALTER TABLE "Clientes" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16413)
-- Name: Productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Productos" (
    id character varying(120) NOT NULL,
    nombre character varying(120) NOT NULL,
    precio double precision,
    id_proveedor character varying(120)
);


ALTER TABLE "Productos" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16423)
-- Name: Juegos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Juegos" (
    edad_minima integer
)
INHERITS ("Productos");


ALTER TABLE "Juegos" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16437)
-- Name: Packs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Packs" (
    lista_juegos "Juego"[] NOT NULL,
    descuento double precision
)
INHERITS ("Productos");


ALTER TABLE "Packs" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16405)
-- Name: Proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Proveedores" (
    empresa character varying(120),
    pais character varying(120)
)
INHERITS ("Personas");


ALTER TABLE "Proveedores" OWNER TO postgres;

--
-- TOC entry 2057 (class 2606 OID 16404)
-- Name: Clientes Clientes_pgk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Clientes"
    ADD CONSTRAINT "Clientes_pgk" PRIMARY KEY (id);


--
-- TOC entry 2055 (class 2606 OID 16396)
-- Name: Personas Personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Personas"
    ADD CONSTRAINT "Personas_pkey" PRIMARY KEY (id);


--
-- TOC entry 2061 (class 2606 OID 16417)
-- Name: Productos Productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Productos"
    ADD CONSTRAINT "Productos_pkey" PRIMARY KEY (id);


--
-- TOC entry 2059 (class 2606 OID 16412)
-- Name: Proveedores Proveedores_pgk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Proveedores"
    ADD CONSTRAINT "Proveedores_pgk" PRIMARY KEY (id);


--
-- TOC entry 2064 (class 2606 OID 16427)
-- Name: Juegos joc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Juegos"
    ADD CONSTRAINT joc_pk PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 16444)
-- Name: Packs pk_pack_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Packs"
    ADD CONSTRAINT pk_pack_id PRIMARY KEY (id);


--
-- TOC entry 2062 (class 1259 OID 16433)
-- Name: fki_id_provedor_joc_fk_Proveedores; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_id_provedor_joc_fk_Proveedores" ON "Juegos" USING btree (id_proveedor);


--
-- TOC entry 2069 (class 2606 OID 16445)
-- Name: Packs fk_id_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Packs"
    ADD CONSTRAINT fk_id_proveedor FOREIGN KEY (id_proveedor) REFERENCES "Proveedores"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2068 (class 2606 OID 16428)
-- Name: Juegos id_provedor_joc_fk_Proveedores; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Juegos"
    ADD CONSTRAINT "id_provedor_joc_fk_Proveedores" FOREIGN KEY (id_proveedor) REFERENCES "Proveedores"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2067 (class 2606 OID 16418)
-- Name: Productos id_proveedorfk_proveedores; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Productos"
    ADD CONSTRAINT id_proveedorfk_proveedores FOREIGN KEY (id_proveedor) REFERENCES "Proveedores"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2018-02-16 15:54:28

--
-- PostgreSQL database dump complete
--

