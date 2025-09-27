﻿CREATE DATABASE ILISKILER 
-- =========================================
-- DATABASE CREATION
-- =========================================
CREATE DATABASE ILISKILER;

USE ILISKILER;
-- =========================================
-- ONE-TO-ONE RELATIONSHIP
-- =========================================
/*
Definition: Each record in one table matches only one record in the other table.
Characteristics:
- One-to-one mapping in both directions
- Often used for splitting large tables for performance
- UNIQUE constraint required on the foreign key
*/

CREATE TABLE Kullanıcılar (
    kullanici_id INT IDENTITY(1,1) PRIMARY KEY, 
    kullanici_adi VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    kayit_tarihi DATETIME DEFAULT GETDATE()  -- Default current date and time
);

CREATE TABLE KullanıcıProfilleri (
    profil_id INT IDENTITY(1,1) PRIMARY KEY, 
    kullanici_id INT UNIQUE,  -- Ensures one-to-one relationship
    ad VARCHAR(50),
    soyad VARCHAR(50),
    telefon VARCHAR(20),
    dogum_tarihi DATE,
    FOREIGN KEY (kullanici_id) REFERENCES Kullanıcılar(kullanici_id)
);

- Insert sample data
INSERT INTO Kullanıcılar (kullanici_adi, email) 
VALUES ('ahmet123', 'ahmet@email.com');

INSERT INTO KullanıcıProfilleri (kullanici_id, ad, soyad, telefon, dogum_tarihi) 
VALUES (1, 'Ahmet', 'Yılmaz', '05551234567', '1990-05-20');

- =========================================
-- ONE-TO-MANY RELATIONSHIP
-- =========================================
/*
Definition: One record in the parent table can match multiple records in the child table.
Characteristics:
- Most common relationship type
- Parent-child relationship
- Foreign key resides on the "many" side
*/

CREATE TABLE Müşteriler (
    müşteri_id INT IDENTITY(1,1) PRIMARY KEY, 
    müşteri_adi VARCHAR(100) NOT NULL,
    telefon VARCHAR(20),
    email VARCHAR(100),
    adres NVARCHAR(MAX)
);

CREATE TABLE Siparişler (
    sipariş_id INT IDENTITY(1,1) PRIMARY KEY,
    müşteri_id INT,  -- Foreign key on the "many" side
    sipariş_tarihi DATETIME DEFAULT GETDATE(),
    toplam_tutar DECIMAL(10,2),
    durum VARCHAR(20) DEFAULT 'Beklemede',
    FOREIGN KEY (müşteri_id) REFERENCES Müşteriler(müşteri_id)
);

-- Insert sample customers
INSERT INTO Müşteriler (müşteri_adi, telefon, email, adres) VALUES
('Ali Veli', '05551234567', 'ali@email.com', 'İstanbul'),
('Ayşe Kaya', '05559876543', 'ayse@email.com', 'Ankara'),
('Mehmet Can', '05553456789', 'mehmet@email.com', 'İzmir'),
('Fatma Yıldız', '05552345678', 'fatma@email.com', 'Bursa'),
('Ahmet Demir', '05551239876', 'ahmet@email.com', 'Antalya');


-- Insert sample orders
INSERT INTO Siparişler (müşteri_id, sipariş_tarihi, toplam_tutar, durum) VALUES
(1, '2025-01-15', 150.50, 'Tamamlandı'),
(1, '2025-01-20', 75.25, 'Kargoda'),
(1, '2025-02-05', 200.00, 'Tamamlandı'),
(2, '2025-01-18', 200.00, 'Hazırlanıyor'),
(2, '2025-02-10', 120.50, 'Kargoda'),
(3, '2025-02-01', 300.75, 'Tamamlandı'),
(3, '2025-02-12', 180.00, 'Beklemede'),
(4, '2025-02-03', 250.00, 'Tamamlandı'),
(4, '2025-02-15', 95.50, 'Kargoda'),
(5, '2025-02-07', 400.00, 'Hazırlanıyor'),
(5, '2025-02-18', 150.25, 'Beklemede');


-- =========================================
-- MANY-TO-MANY RELATIONSHIP
-- =========================================
/*
Definition: Records in one table can match multiple records in another table, and vice versa.
Characteristics:
- Requires a junction (association) table
- Stores additional info in junction table if needed
*/

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

-- Sample data
INSERT INTO Öğrenciler (öğrenci_adi, numara, bölüm) VALUES
('Mehmet Ali', '2024001', 'Bilgisayar Mühendisliği'),
('Fatma Demir', '2024002', 'Matematik'),
('Can Özkan', '2024003', 'Bilgisayar Mühendisliği');

INSERT INTO Dersler (ders_adi, kredi, öğretmen) VALUES
('Veritabanı Yönetimi', 3, 'Dr. Ahmet Yılmaz'),
('Algoritma', 4, 'Dr. Ayşe Kaya'),
('Matematik', 3, 'Dr. Mehmet Demir');

INSERT INTO ÖğrenciDersleri (öğrenci_id, ders_id, notu, dönem) VALUES
(1, 1, 85.5, '2025 Bahar'),
(1, 2, 78.0, '2025 Bahar'),
(2, 1, 92.0, '2025 Bahar'),
(2, 3, 88.5, '2025 Bahar'),
(3, 1, 76.5, '2025 Bahar'),
(3, 2, 82.0, '2025 Bahar');

-- =========================================
-- JOINS EXAMPLES
-- =========================================

-- INNER JOIN: Only matching records from both tables
SELECT m.müşteri_adi, s.sipariş_tarihi, s.toplam_tutar, s.durum
FROM Müşteriler m
INNER JOIN Siparişler s ON m.müşteri_id = s.müşteri_id
ORDER BY s.sipariş_tarihi DESC;

-- Multiple joins example
SELECT o.öğrenci_adi, d.ders_adi, od.notu, od.dönem
FROM Öğrenciler o
INNER JOIN ÖğrenciDersleri od ON o.öğrenci_id = od.öğrenci_id
INNER JOIN Dersler d ON d.ders_id = od.ders_id
WHERE od.notu >= 80;

-- LEFT JOIN: All left table rows, NULL if no match in right table
SELECT m.müşteri_adi, 
       COALESCE(s.sipariş_tarihi, 'No Order') AS sipariş_tarihi,
       COALESCE(s.toplam_tutar, 0) AS toplam_tutar
FROM Müşteriler m
LEFT JOIN Siparişler s ON m.müşteri_id = s.müşteri_id;

-- RIGHT JOIN: All right table rows, NULL if no match in left table
SELECT COALESCE(m.müşteri_adi, 'Unknown Customer') AS müşteri_adi,
       s.sipariş_tarihi, s.toplam_tutar
FROM Müşteriler m
RIGHT JOIN Siparişler s ON m.müşteri_id = s.müşteri_id;

-- FULL OUTER JOIN: All rows from both tables
SELECT m.müşteri_adi, s.sipariş_tarihi, s.toplam_tutar
FROM Müşteriler m
FULL OUTER JOIN Siparişler s ON m.müşteri_id = s.müşteri_id;

-- CROSS JOIN: Cartesian product
SELECT m.müşteri_adi, s.sipariş_tarihi
FROM Müşteriler m
CROSS JOIN Siparişler s;

-- =========================================
-- SUBQUERIES
-- =========================================

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

-- Customers who placed orders over 200
SELECT müşteri_adi, telefon
FROM Müşteriler
WHERE müşteri_id IN (
    SELECT müşteri_id FROM Siparişler WHERE toplam_tutar > 200
);

-- =========================================
-- STRING FUNCTIONS (Text Operations)
-- =========================================
SELECT 
    LEN('Merhaba Dünya') AS uzunluk,
    LEFT('Merhaba', 3) AS soldan_3,
    RIGHT('Merhaba', 3) AS sagdan_3,
    SUBSTRING('Merhaba Dünya', 1, 7) AS alt_metin,
    UPPER('merhaba') AS buyuk_harf,
    LOWER('MERHABA') AS kucuk_harf,
    LTRIM('  Merhaba  ') AS sol_trim,
    RTRIM('  Merhaba  ') AS sag_trim,
    REPLACE('Merhaba Dünya', 'Dünya', 'SQL') AS degistir;

-- =========================================
-- DATE FUNCTIONS
-- =========================================
SELECT
    GETDATE() AS su_an,                      -- Current date and time
    GETUTCDATE() AS utc_tarih,               -- UTC date and time
    YEAR(GETDATE()) AS yil,                  -- Year
    MONTH(GETDATE()) AS ay,                  -- Month
    DAY(GETDATE()) AS gun,                   -- Day
    DATENAME(WEEKDAY, GETDATE()) AS haftanin_gunu, -- Weekday name
    DATEADD(DAY, 7, GETDATE()) AS bir_hafta_sonra, -- Add 7 days
    DATEDIFF(DAY, '2024-01-01', GETDATE()) AS gun_farki; -- Days difference