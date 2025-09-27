# A to Z SQL Examples Repository

This repository contains comprehensive **SQL examples** including **database creation, table creation, CRUD operations, relationships, joins, subqueries, functions**, and more. It is designed for learning and practicing SQL from beginner to advanced levels.

Each section includes explanations of concepts, syntax, and examples for practical understanding.

---

## 1️⃣ Database Creation

**Explanation:**  
Databases are containers for tables, views, procedures, and other objects. Creating a database is the first step before adding any tables or data.

```sql
-- Create new databases
CREATE DATABASE PERSONEL;           -- Creates a database named PERSONEL
CREATE DATABASE otomobil_fiyatlari; -- Creates a database for car prices
CREATE DATABASE ILISKILER;           -- Creates a database for relationships examples

-- Use the databases
USE otomobil_fiyatlari;  -- Switches context to the car prices database
USE ILISKILER;           -- Switches context to the relationships database
```

---

2️⃣ Table Creation

Explanation:
Tables store data in rows and columns. Each column has a data type and constraints like PRIMARY KEY, UNIQUE, or NOT NULL.

```sql
CREATE TABLE KULLANICILAR (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-increment primary key
    ad NVARCHAR(50),                   -- First name
    soyad NVARCHAR(50),                -- Last name
    yas INT                            -- Age
);
```


Notes:

-IDENTITY(1,1) automatically generates a unique ID starting from 1.

-PRIMARY KEY ensures each row is unique.

Car Prices Table
```sql
CREATE TABLE otomobil_fiyatlari (
    id INT IDENTITY(1,1) PRIMARY KEY,
    marka NVARCHAR(50) NOT NULL,       -- Car brand
    model NVARCHAR(50) NOT NULL,       -- Car model
    fiyat INT NOT NULL,                -- Price
    motor INT NOT NULL,                -- Engine size in cc
    yakit NVARCHAR(20) NOT NULL,       -- Fuel type
    vites NVARCHAR(20) NOT NULL        -- Transmission type
);
```

Notes:

-NOT NULL ensures that the column cannot be empty.

-Choosing appropriate data types helps with storage efficiency and validation.

Relationships Tables (ILISKILER DB)
# One-to-One Relationship

Explanation:
Each record in one table matches exactly one record in another table. Usually used for splitting large tables or storing sensitive info separately.

```sql
CREATE TABLE Kullanıcılar (
    kullanici_id INT IDENTITY(1,1) PRIMARY KEY,
    kullanici_adi VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    kayit_tarihi DATETIME DEFAULT GETDATE()
);

CREATE TABLE KullanıcıProfilleri (
    profil_id INT IDENTITY(1,1) PRIMARY KEY,
    kullanici_id INT UNIQUE,                  -- Ensures one-to-one mapping
    ad VARCHAR(50),
    soyad VARCHAR(50),
    telefon VARCHAR(20),
    dogum_tarihi DATE,
    FOREIGN KEY (kullanici_id) REFERENCES Kullanıcılar(kullanici_id)
);
```

Notes:

-UNIQUE on kullanici_id ensures each profile is linked to only one user.

-FOREIGN KEY maintains referential integrity.

# One-to-Many Relationship

Explanation:
One parent record can relate to many child records. Most common relationship in databases, e.g., Customers and Orders.

```sql
CREATE TABLE Müşteriler (
    müşteri_id INT IDENTITY(1,1) PRIMARY KEY,
    müşteri_adi VARCHAR(100) NOT NULL,
    telefon VARCHAR(20),
    email VARCHAR(100),
    adres NVARCHAR(MAX)
);

CREATE TABLE Siparişler (
    sipariş_id INT IDENTITY(1,1) PRIMARY KEY,
    müşteri_id INT,  -- Foreign key in the "many" table
    sipariş_tarihi DATETIME DEFAULT GETDATE(),
    toplam_tutar DECIMAL(10,2),
    durum VARCHAR(20) DEFAULT 'Beklemede',
    FOREIGN KEY (müşteri_id) REFERENCES Müşteriler(müşteri_id)
);
```

# Many-to-Many Relationship

Explanation:
Records in one table can relate to multiple records in another table, and vice versa. Requires a junction table.

```sql
CREATE TABLE Öğrenciler (
    öğrenci_id INT IDENTITY(1,1) PRIMARY KEY,
    öğrenci_adi VARCHAR(100) NOT NULL,
    numara VARCHAR(20) UNIQUE,
    bölüm VARCHAR(50)
);

CREATE TABLE Dersler (
    ders_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_adi VARCHAR(100) NOT NULL,
    kredi INT,
    öğretmen VARCHAR(100)
);

CREATE TABLE ÖğrenciDersleri (
    ogrenci_ders_id INT IDENTITY(1,1) PRIMARY KEY,
    öğrenci_id INT,
    ders_id INT,
    notu DECIMAL(5,2),
    dönem VARCHAR(20),
    FOREIGN KEY (öğrenci_id) REFERENCES Öğrenciler(öğrenci_id),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id)
);
```

3️⃣ CRUD Operations

Explanation:
CRUD stands for Create, Read, Update, Delete – the basic operations for managing database data.

```sql
SELECT Queries (Read)
-- Select all columns
SELECT * FROM KULLANICILAR;

-- Select specific columns
SELECT ad, soyad FROM KULLANICILAR;

-- Unique values
SELECT DISTINCT ad FROM KULLANICILAR;

-- Top N rows
SELECT TOP 2 ad FROM KULLANICILAR;

INSERT Data (Create)
INSERT INTO KULLANICILAR (ad, soyad, yas)
VALUES ('Kemal', 'Tas', 36);

UPDATE Data
UPDATE KULLANICILAR
SET yas = 25
WHERE ad = 'Ayse'; -- Only updates Ayse's age

DELETE Data
DELETE FROM KULLANICILAR
WHERE id = 1; -- Deletes the user with id 1
```

4️⃣ WHERE & Logical Operators

Explanation:
WHERE filters rows based on conditions. Logical operators combine multiple conditions.

```sql
-- Comparison operators: =, <>, >, <, >=, <=
SELECT * FROM otomobil_fiyatlari WHERE motor > 2000;

-- AND: both conditions must be true
SELECT * FROM otomobil_fiyatlari
WHERE fiyat < 500000 AND yakit = 'Diesel';

-- OR: at least one condition must be true
SELECT * FROM otomobil_fiyatlari
WHERE marka = 'BMW' OR marka = 'Audi';

-- NOT: negates a condition
SELECT * FROM otomobil_fiyatlari
WHERE NOT vites = 'Automatic';
```

5️⃣ BETWEEN, IN, LIKE Operators

Explanation:

```sql
BETWEEN checks if a value is within a range.

IN checks if a value matches any value in a list.

LIKE performs pattern matching.

-- BETWEEN
SELECT * FROM otomobil_fiyatlari WHERE fiyat BETWEEN 200000 AND 500000;

-- IN
SELECT * FROM otomobil_fiyatlari WHERE marka IN ('BMW', 'Audi', 'Mercedes');

-- LIKE (pattern matching)
SELECT * FROM otomobil_fiyatlari WHERE model LIKE 'A%';   -- Starts with 'A'
SELECT * FROM otomobil_fiyatlari WHERE model LIKE '%Sport%'; -- Contains 'Sport'
```

6️⃣ Aggregate Functions

Explanation:
Used to calculate summary statistics over multiple rows.
```sql
SELECT COUNT(*) AS total_cars FROM otomobil_fiyatlari;       -- Number of cars
SELECT SUM(fiyat) AS total_price FROM otomobil_fiyatlari;   -- Total price
SELECT AVG(CAST(fiyat AS FLOAT)) AS avg_price FROM otomobil_fiyatlari; -- Average price
SELECT MIN(fiyat) AS min_price, MAX(fiyat) AS max_price FROM otomobil_fiyatlari;
```

7️⃣ GROUP BY & HAVING

Explanation:
```sql
GROUP BY aggregates data by one or more columns.

HAVING filters groups (like WHERE but for aggregates).

-- Count of cars per fuel type
SELECT yakit, COUNT(*) AS count
FROM otomobil_fiyatlari
GROUP BY yakit;

-- Average price per brand, only brands with avg > 400,000
SELECT marka, AVG(CAST(fiyat AS FLOAT)) AS avg_price
FROM otomobil_fiyatlari
GROUP BY marka
HAVING AVG(CAST(fiyat AS FLOAT)) > 400000;
```
8️⃣ JOINs (Relationships Queries)

Explanation:
```sql
INNER JOIN returns rows with matches in both tables.

LEFT/RIGHT JOIN returns all rows from one table and matched rows from another.

FULL OUTER JOIN returns all rows from both tables.

CROSS JOIN returns Cartesian product.

-- Inner join example
SELECT m.müşteri_adi, s.sipariş_tarihi, s.toplam_tutar
FROM Müşteriler m
INNER JOIN Siparişler s ON m.müşteri_id = s.müşteri_id;

-- Left join example
SELECT m.müşteri_adi, COALESCE(s.toplam_tutar,0) AS toplam_tutar
FROM Müşteriler m
LEFT JOIN Siparişler s ON m.müşteri_id = s.müşteri_id;

-- Multiple joins (students and courses)
SELECT o.öğrenci_adi, d.ders_adi, od.notu
FROM Öğrenciler o
INNER JOIN ÖğrenciDersleri od ON o.öğrenci_id = od.öğrenci_id
INNER JOIN Dersler d ON d.ders_id = od.ders_id
WHERE od.notu >= 80;
```
9️⃣ Subqueries

Explanation:
A query inside another query. Useful for dynamic filtering.
```sql
-- Students with above-average grades
SELECT o.öğrenci_adi, od.notu
FROM Öğrenciler o
JOIN ÖğrenciDersleri od ON o.öğrenci_id = od.öğrenci_id
WHERE od.notu > (
    SELECT AVG(notu) FROM ÖğrenciDersleri
);

-- Customer with the most expensive order
SELECT müşteri_adi
FROM Müşteriler
WHERE müşteri_id = (
    SELECT müşteri_id
    FROM Siparişler
    WHERE toplam_tutar = (SELECT MAX(toplam_tutar) FROM Siparişler)
);
```
🔟 String & Date Functions
String Functions
```sql
SELECT
    LEN('Hello World') AS length,
    LEFT('Hello', 3) AS first_3,
    RIGHT('Hello', 3) AS last_3,
    SUBSTRING('Hello World', 1, 5) AS substring,
    UPPER('hello') AS uppercase,
    LOWER('HELLO') AS lowercase,
    LTRIM('  Hello') AS ltrim,
    RTRIM('Hello  ') AS rtrim,
    REPLACE('Hello SQL', 'SQL', 'World') AS replaced_text;
```

Date Functions
```sql
SELECT
    GETDATE() AS now,
    GETUTCDATE() AS utc_now,
    YEAR(GETDATE()) AS year,
    MONTH(GETDATE()) AS month,
    DAY(GETDATE()) AS day,
    DATENAME(WEEKDAY, GETDATE()) AS weekday_name,
    DATEADD(DAY, 7, GETDATE()) AS next_week,
    DATEDIFF(DAY, '2024-01-01', GETDATE()) AS days_diff;
```
