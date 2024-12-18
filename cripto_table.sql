--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;



SET default_tablespace = '';

SET default_with_oids = false;

---
--- drop tables
---


DROP TABLE IF EXISTS bitcoin_prices;

--
-- Name: bitcoin_prices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE IF NOT EXISTS bitcoin_prices (
    id SERIAL PRIMARY KEY,
    amount_usd NUMERIC NOT NULL,
    amount_brl NUMERIC NOT NULL,
    base VARCHAR(10) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    timestamp TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS ethereum_prices (
    id SERIAL PRIMARY KEY,
    amount_usd NUMERIC NOT NULL,
    amount_brl NUMERIC NOT NULL,
    base VARCHAR(10) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    timestamp TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION get_weekly_btc_price_range()
RETURNS TABLE (max_price NUMERIC, min_price NUMERIC) AS $$
BEGIN
	RETURN QUERY
	SELECT MAX(amount_usd)::NUMERIC AS max_price, MIN(amount_usd)::NUMERIC AS min_price
	FROM bitcoin_prices
	WHERE timestamp >= NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_weekly_eth_price_range()
RETURNS TABLE (max_price NUMERIC, min_price NUMERIC) AS $$
BEGIN
	RETURN QUERY
	SELECT MAX(amount_usd)::NUMERIC AS max_price, MIN(amount_usd)::NUMERIC AS min_price
	FROM ethereum_prices
	WHERE timestamp >= NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql;