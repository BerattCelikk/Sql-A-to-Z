/* 
===============================================================================
        Car Prices Database Example
===============================================================================
*/
/* 1. Create Database */
CREATE DATABASE otomobil_fiyatlari;

/* 2. Use Database */
USE otomobil_fiyatlari;

/* 3. Create Table */
CREATE TABLE otomobil_fiyatlari (
    id INT PRIMARY KEY IDENTITY(1,1),        -- Auto-incrementing primary key
	marka NVARCHAR(50) NOT NULL,             -- Brand
    model NVARCHAR(50) NOT NULL,             -- Model
    fiyat INT NOT NULL,                      -- Price
    motor INT NOT NULL,                      -- Engine capacity (cc)
    yakit NVARCHAR(20) NOT NULL,             -- Fuel type: Petrol, Diesel, Hybrid, Electric
    vites NVARCHAR(20) NOT NULL              -- Transmission: Manual, Automatic, Semi-Automatic
);

INSERT INTO otomobil_fiyatlari (marka, model, fiyat, motor, yakit, vites) VALUES
('BMW', '320i',       1200000, 1600, 'Petrol',   'Automatic'),
('BMW', '520d',       1800000, 2000, 'Diesel',   'Automatic'),
('Mercedes', 'C200',  1500000, 1600, 'Petrol',   'Automatic'),
('Mercedes', 'E220d', 2200000, 2000, 'Diesel',   'Automatic'),
('Audi', 'A4',        1400000, 1600, 'Petrol',   'Manual'),
('Audi', 'A6',        2000000, 2000, 'Petrol',   'Automatic'),
('Volkswagen', 'Passat', 950000, 1600, 'Diesel', 'Automatic'),
('Volkswagen', 'Golf',   750000, 1400, 'Petrol', 'Manual'),
('Toyota', 'Corolla',    650000, 1400, 'Petrol', 'Automatic'),
('Toyota', 'Camry',     1200000, 2500, 'Hybrid', 'Automatic'),
('Tesla', 'Model 3',   1800000, 0,    'Electric','Automatic'),
('Renault', 'Clio',     550000, 1200, 'Petrol', 'Manual');

/*
===============================================================================
1. USING DATABASE & BASIC SELECT
===============================================================================
*/

-- Display all records
SELECT * FROM otomobil_fiyatlari;

-- Select specific columns
SELECT marka, model, fiyat FROM otomobil_fiyatlari;

-- Display top 10 rows
SELECT TOP 10 * FROM otomobil_fiyatlari;

-- Use column aliases
SELECT 
    marka AS 'Car Brand',
    model AS 'Model Name',
    fiyat AS 'Price',
    yakit AS 'Fuel Type'
FROM otomobil_fiyatlari;

/*
===============================================================================
2. WHERE CONDITIONS & COMPARISON OPERATORS
===============================================================================
=   → equal
>   → greater than
<   → less than
>=  → greater or equal
<=  → less or equal
<>  → not equal (or !=)
*/

-- Cars with engine > 2000cc
SELECT * FROM otomobil_fiyatlari
WHERE motor > 2000;

-- Cars with price exactly 100,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat = 100000;

-- Price > 100,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat > 100000;

-- Price < 500,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat < 500000;

-- Price >= 200,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat >= 200000;

-- Engine <= 1600
SELECT * FROM otomobil_fiyatlari
WHERE motor <= 1600;

-- Price not equal 1,500,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat <> 1500000;

-- String exact match
SELECT * FROM otomobil_fiyatlari
WHERE marka = 'BMW';

-- String not equal
SELECT * FROM otomobil_fiyatlari
WHERE yakit <> 'Petrol';

/* Notes:
   - Strings must be in single quotes
   - Numbers do not require quotes
*/

-- Strings as numbers (works but not recommended)
SELECT * FROM otomobil_fiyatlari
WHERE fiyat > '100000';

-- Incorrect usage
SELECT * FROM otomobil_fiyatlari
WHERE fiyat > '100K';  -- ERROR

/*
===============================================================================
3. LOGICAL OPERATORS (AND, OR, NOT)
===============================================================================
*/

-- AND: All conditions must be true
SELECT * FROM otomobil_fiyatlari
WHERE fiyat < 500000 AND yakit = 'Diesel';

SELECT * FROM otomobil_fiyatlari
WHERE fiyat > 300000 AND yakit = 'Petrol' AND vites = 'Automatic';

SELECT * FROM otomobil_fiyatlari
WHERE motor > 2000 AND fiyat < 1000000 AND marka = 'BMW';

-- OR: At least one condition must be true
SELECT * FROM otomobil_fiyatlari
WHERE yakit = 'Petrol' OR yakit = 'Diesel';

SELECT * FROM otomobil_fiyatlari
WHERE fiyat < 100000 OR fiyat > 1000000;

SELECT * FROM otomobil_fiyatlari
WHERE marka = 'BMW' OR marka = 'Mercedes' OR marka = 'Audi';

-- NOT: negates condition
SELECT * FROM otomobil_fiyatlari
WHERE NOT yakit = 'Petrol';

SELECT * FROM otomobil_fiyatlari
WHERE yakit <> 'Petrol';

SELECT * FROM otomobil_fiyatlari
WHERE NOT vites = 'Automatic';

-- Complex conditions (use parentheses)
SELECT * FROM otomobil_fiyatlari
WHERE (yakit = 'Petrol' OR yakit = 'Diesel') 
  AND vites = 'Automatic' 
  AND fiyat > 500000;

SELECT * FROM otomobil_fiyatlari
WHERE (marka = 'BMW' OR marka = 'Mercedes') 
  AND fiyat BETWEEN 200000 AND 800000;

/*
===============================================================================
4. BETWEEN OPERATOR - Range Selection
===============================================================================
*/

-- Price between 200,000 and 500,000
SELECT * FROM otomobil_fiyatlari
WHERE fiyat BETWEEN 200000 AND 500000;

-- Same as
SELECT * FROM otomobil_fiyatlari
WHERE fiyat >= 200000 AND fiyat <= 500000;

-- Engine 1400-2000cc
SELECT * FROM otomobil_fiyatlari
WHERE motor BETWEEN 1400 AND 2000;

-- Price 100K-300K BMW
SELECT * FROM otomobil_fiyatlari
WHERE fiyat BETWEEN 100000 AND 300000 AND marka = 'BMW';

-- NOT BETWEEN
SELECT * FROM otomobil_fiyatlari
WHERE fiyat NOT BETWEEN 200000 AND 800000;

/*
===============================================================================
5. IN OPERATOR - Select from a List
===============================================================================
*/

-- Fuel Petrol or Diesel
SELECT * FROM otomobil_fiyatlari
WHERE yakit IN ('Petrol', 'Diesel');

-- Brands
SELECT * FROM otomobil_fiyatlari
WHERE marka IN ('BMW', 'Mercedes', 'Audi', 'Volkswagen');

-- NOT IN
SELECT * FROM otomobil_fiyatlari
WHERE yakit NOT IN ('Petrol', 'Diesel');

/*
===============================================================================
6. LIKE OPERATOR - Pattern Matching
===============================================================================
*/

-- Model starts with 'A'
SELECT * FROM otomobil_fiyatlari
WHERE model LIKE 'A%';

-- Model ends with 'o'
SELECT * FROM otomobil_fiyatlari
WHERE model LIKE '%o';

-- Model contains 'Sport'
SELECT * FROM otomobil_fiyatlari
WHERE model LIKE '%Sport%';

-- Second character 'u'
SELECT * FROM otomobil_fiyatlari
WHERE model LIKE '_u%';

/*
===============================================================================
7. AGGREGATE FUNCTIONS
===============================================================================
COUNT() → Row count
SUM()   → Total
AVG()   → Average
MIN()   → Minimum
MAX()   → Maximum
*/

SELECT COUNT(*) AS total_cars FROM otomobil_fiyatlari;
SELECT SUM(fiyat) AS total_price FROM otomobil_fiyatlari;
SELECT AVG(CAST(fiyat AS FLOAT)) AS avg_price FROM otomobil_fiyatlari;

/*
===============================================================================
8. GROUP BY
===============================================================================
*/

SELECT yakit, COUNT(*) AS count FROM otomobil_fiyatlari
GROUP BY yakit;

SELECT marka, AVG(CAST(fiyat AS FLOAT)) AS avg_price
FROM otomobil_fiyatlari
GROUP BY marka;

/* Using CASE to categorize engine sizes */
SELECT 
    CASE 
        WHEN motor <= 1400 THEN '1400cc or less'
        WHEN motor <= 2000 THEN '1401-2000cc'
        WHEN motor <= 2500 THEN '2001-2500cc'
        ELSE '2500cc+'
    END AS motor_category,
    COUNT(*) AS count,
    AVG(CAST(fiyat AS FLOAT)) AS avg_price
FROM otomobil_fiyatlari
GROUP BY 
    CASE 
        WHEN motor <= 1400 THEN '1400cc or less'
        WHEN motor <= 2000 THEN '1401-2000cc'
        WHEN motor <= 2500 THEN '2001-2500cc'
        ELSE '2500cc+'
    END
ORDER BY avg_price;

/*
===============================================================================
9. HAVING
===============================================================================
*/

SELECT marka, COUNT(*) AS count, AVG(CAST(fiyat AS FLOAT)) AS avg_price
FROM otomobil_fiyatlari
GROUP BY marka
HAVING AVG(CAST(fiyat AS FLOAT)) > 400000;

/*
===============================================================================
10. WHERE + GROUP BY + HAVING
===============================================================================
*/

SELECT marka, COUNT(*) AS count, AVG(CAST(fiyat AS FLOAT)) AS avg_price
FROM otomobil_fiyatlari
WHERE fiyat > 150000
GROUP BY marka
HAVING COUNT(*) > 5
ORDER BY avg_price DESC;

/*
===============================================================================
11. ORDER BY
===============================================================================
*/

SELECT marka, model, fiyat
FROM otomobil_fiyatlari
ORDER BY fiyat DESC;

/*
===============================================================================
12. Practical Examples & Exercises
===============================================================================
*/

-- Example: Price Segmentation
SELECT 
    CASE 
        WHEN fiyat < 200000 THEN 'Budget (<200K)'
        WHEN fiyat < 500000 THEN 'Midrange (200K-500K)'
        WHEN fiyat < 1000000 THEN 'Luxury (500K-1M)'
        ELSE 'Premium (>1M)'
    END AS segment,
    COUNT(*) AS car_count,
    ROUND(AVG(CAST(motor AS FLOAT)),0) AS avg_motor,
    COUNT(CASE WHEN yakit='Petrol' THEN 1 END) AS petrol_count
FROM otomobil_fiyatlari
GROUP BY 
    CASE 
        WHEN fiyat < 200000 THEN 'Budget (<200K)'
        WHEN fiyat < 500000 THEN 'Midrange (200K-500K)'
        WHEN fiyat < 1000000 THEN 'Luxury (500K-1M)'
        ELSE 'Premium (>1M)'
    END
ORDER BY avg_motor;

/*
===============================================================================
13. Exercises Solutions
===============================================================================
*/

-- Exercise 1 solution
SELECT 
    marka,
    COUNT(*) AS count,
    AVG(CAST(motor AS FLOAT)) AS avg_motor
FROM otomobil_fiyatlari
WHERE fiyat BETWEEN 300000 AND 700000 AND yakit='Petrol'
GROUP BY marka;

-- Exercise 2 solution
SELECT marka, model, fiyat, motor
FROM otomobil_fiyatlari
WHERE vites='Automatic' AND motor>2000
ORDER BY fiyat DESC;

-- Exercise 3 solution
SELECT yakit, vites, MIN(fiyat) AS min_price, MAX(fiyat) AS max_price
FROM otomobil_fiyatlari
GROUP BY yakit, vites;