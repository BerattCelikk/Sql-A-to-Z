-- ================================================
-- CREATE DATABASE
-- ================================================
CREATE DATABASE PERSONEL;  
-- Creates a new database named "PERSONEL".


-- ================================================
-- CREATE TABLE (Entity)
-- ================================================
CREATE TABLE KULLANICILAR (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing Primary Key
    ad NVARCHAR(50),                   -- First name (string, max 50 chars)
    soyad NVARCHAR(50),                -- Last name (string, max 50 chars)
    yas INT                            -- Age (integer)
);


-- ================================================
-- SELECT QUERIES
-- ================================================

SELECT * 
FROM KULLANICILAR;  
-- Selects all columns and rows from the table.


SELECT ad 
FROM KULLANICILAR;  
-- Selects only the "ad" (first name) column.


SELECT ad, soyad 
FROM KULLANICILAR;  
-- Selects only the "ad" (first name) and "soyad" (last name) columns.


-- ================================================
-- INSERT DATA
-- ================================================
INSERT INTO KULLANICILAR (ad, soyad, yas) 
VALUES ('kemal', 'tas', 36);  
-- Inserts a new record into the table.


-- ================================================
-- UPDATE DATA
-- ================================================
UPDATE KULLANICILAR
SET yas = 25                -- Sets the age to 25
WHERE ad = 'ayse';          -- Only for the row where "ad" = 'ayse'


-- ================================================
-- DELETE DATA
-- ================================================
DELETE FROM KULLANICILAR
WHERE id = 1;  
-- Deletes the row where the id is equal to 1.


-- ================================================
-- SELECT DISTINCT
-- ================================================
SELECT DISTINCT ad 
FROM KULLANICILAR;  
-- Returns only unique (distinct) first names.


-- ================================================
-- SELECT TOP
-- ================================================
SELECT TOP 2 ad 
FROM KULLANICILAR;  
-- Returns the first 2 rows of the "ad" column.
