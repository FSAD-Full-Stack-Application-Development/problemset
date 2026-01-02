-- ============================================================
-- SQL COMMANDS FILE
-- Assignment: SQL Exercises (6–12)
-- Database: PostgreSQL 16 (Docker)
-- ============================================================


-- =====================
-- EXERCISE 6
-- =====================
-- Create table for stock data
DROP TABLE IF EXISTS my_stocks;
CREATE TABLE my_stocks (
    symbol VARCHAR(20) NOT NULL,
    n_shares INTEGER NOT NULL,
    date_acquired DATE NOT NULL
);

-- Load data from text file (executed in psql shell)
-- Example:
-- \copy my_stocks(symbol, n_shares, date_acquired)
-- FROM '/my_stocks.txt'
-- WITH (FORMAT text, DELIMITER E'\t', HEADER false);

-- Verify data
SELECT * FROM my_stocks;


-- =====================
-- EXERCISE 7
-- =====================
-- Create and populate stock_prices table in one statement
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices AS
SELECT 
    symbol,
    CURRENT_DATE AS quote_date,
    31.415 AS price
FROM my_stocks;

-- Verify
SELECT * FROM stock_prices;


-- =====================
-- EXERCISE 8
-- =====================
-- Report showing symbol, number of shares, price per share, and total value
SELECT 
    m.symbol,
    m.n_shares,
    s.price,
    (m.n_shares * s.price) AS current_value
FROM my_stocks m
JOIN stock_prices s ON m.symbol = s.symbol;


-- =====================
-- EXERCISE 9
-- =====================
-- Add a new stock to my_stocks
INSERT INTO my_stocks (symbol, n_shares, date_acquired)
VALUES ('NVDA', 10, CURRENT_DATE);

-- Outer join version to include all stocks, even those without a price
SELECT 
    m.symbol,
    m.n_shares,
    s.price,
    (m.n_shares * s.price) AS current_value
FROM my_stocks m
LEFT JOIN stock_prices s ON m.symbol = s.symbol;


-- =====================
-- EXERCISE 10
-- =====================
-- Define a PL/pgSQL function to compute ASCII-based stock value
CREATE OR REPLACE FUNCTION stock_value(sym VARCHAR)
RETURNS INTEGER AS $$
DECLARE
    total INTEGER := 0;
    i INTEGER;
BEGIN
    FOR i IN 1..LENGTH(sym) LOOP
        total := total + ASCII(SUBSTRING(sym, i, 1));
    END LOOP;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Update stock_prices using stock_value()
UPDATE stock_prices
SET price = stock_value(symbol);

-- Function to calculate total portfolio value
CREATE OR REPLACE FUNCTION portfolio_value()
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC := 0;
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT m.symbol, m.n_shares, s.price
        FROM my_stocks m
        JOIN stock_prices s ON m.symbol = s.symbol
    LOOP
        total := total + (rec.n_shares * rec.price);
    END LOOP;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Verify updated values
SELECT * FROM stock_prices;

-- Run the portfolio function
SELECT portfolio_value();


-- =====================
-- EXERCISE 11
-- =====================
-- Insert new rows for “winner” stocks (above average price)
INSERT INTO my_stocks (symbol, n_shares, date_acquired)
SELECT 
    m.symbol,
    m.n_shares,
    CURRENT_DATE
FROM my_stocks m
JOIN stock_prices s ON m.symbol = s.symbol
WHERE s.price > (SELECT AVG(price) FROM stock_prices);

-- Report: symbols and total shares held
SELECT symbol, SUM(n_shares) AS total_shares
FROM my_stocks
GROUP BY symbol;

-- Report: total value per symbol
SELECT 
    m.symbol,
    SUM(m.n_shares * s.price) AS total_value
FROM my_stocks m
JOIN stock_prices s ON m.symbol = s.symbol
GROUP BY m.symbol;

-- Report: only “winner” stocks (held in 2+ lots)
SELECT 
    m.symbol,
    SUM(m.n_shares) AS total_shares,
    SUM(m.n_shares * s.price) AS total_value
FROM my_stocks m
JOIN stock_prices s ON m.symbol = s.symbol
GROUP BY m.symbol
HAVING COUNT(*) >= 2;


-- =====================
-- EXERCISE 12
-- =====================
-- Create a view encapsulating the final “winner stocks” query
DROP VIEW IF EXISTS stocks_i_like;
CREATE VIEW stocks_i_like AS
SELECT 
    m.symbol,
    SUM(m.n_shares) AS total_shares,
    SUM(m.n_shares * s.price) AS total_value
FROM my_stocks m
JOIN stock_prices s ON m.symbol = s.symbol
GROUP BY m.symbol
HAVING COUNT(*) >= 2;

-- Verify view contents
SELECT * FROM stocks_i_like;

-- ============================================================
-- END OF SQL COMMANDS
-- ============================================================
