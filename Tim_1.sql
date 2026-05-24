DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Teo Kupčinovac - Izrada tablica --
CREATE TABLE kupac (
    kupac_id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    lozinka VARCHAR(255) NOT NULL,
    telefon VARCHAR(20),
    datum_registracije DATE,
    aktivan BOOLEAN DEFAULT TRUE
);

CREATE TABLE adresa (
    adresa_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    ulica VARCHAR(150) NOT NULL,
    grad VARCHAR(100) NOT NULL,
    postanski_broj VARCHAR(10) NOT NULL,
    drzava VARCHAR(60) DEFAULT 'Hrvatska',
    glavna_adresa BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id) ON DELETE CASCADE
);

CREATE TABLE dobavljac (
    dobavljac_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(150) NOT NULL,
    kontakt_osoba VARCHAR(100),
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(20),
    adresa VARCHAR(200)
);

CREATE TABLE kategorija (
    kategorija_id INT AUTO_INCREMENT PRIMARY KEY,
    nadkategorija_id INT,
    naziv VARCHAR(100) NOT NULL,
    opis TEXT,
    FOREIGN KEY (nadkategorija_id) REFERENCES kategorija(kategorija_id)
);

CREATE TABLE proizvod (
    proizvod_id INT AUTO_INCREMENT PRIMARY KEY,
    kategorija_id INT NOT NULL,
    naziv VARCHAR(150) NOT NULL,
    opis TEXT,
    cijena DECIMAL(10,2) NOT NULL,
    kolicina_na_skladistu INT DEFAULT 0,
    SKU VARCHAR(50) UNIQUE,
    aktivan BOOLEAN DEFAULT TRUE,
    datum_dodavanja DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kategorija_id) REFERENCES kategorija(kategorija_id)
);

CREATE TABLE narudzba (
    narudzba_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    adresa_id INT NOT NULL,
    datum_narudzbe DATETIME,
    status VARCHAR(50),
    ukupan_iznos DECIMAL(12,2),
    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id),
    FOREIGN KEY (adresa_id) REFERENCES adresa(adresa_id)
);

CREATE TABLE stavka_narudzbe (
    stavka_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    cijena_po_komadu DECIMAL(10,2) NOT NULL,
    ukupna_cijena DECIMAL(12,2),
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id),
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id)
);

CREATE TABLE placanje (
    placanje_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT,
    nacin_placanja VARCHAR(50),
    iznos DECIMAL(12,2),
    status_placanja VARCHAR(50),
    datum_placanja DATETIME,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id)
);

CREATE TABLE dostava (
    dostava_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT,
    kurirska_sluzba VARCHAR(100),
    broj_posiljke VARCHAR(50),
    status_dostave VARCHAR(50),
    procijenjeni_datum DATE,
    stvarni_datum DATE,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id)
);

CREATE TABLE nabava (
    nabava_id INT AUTO_INCREMENT PRIMARY KEY,
    dobavljac_id INT,
    datum_nabave DATETIME,
    status VARCHAR(50),
    ukupan_iznos DECIMAL(12,2),
    FOREIGN KEY (dobavljac_id) REFERENCES dobavljac(dobavljac_id)
);

CREATE TABLE stavka_nabave (
    stavka_nabave_id INT AUTO_INCREMENT PRIMARY KEY,
    nabava_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    nabavna_cijena DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (nabava_id) REFERENCES nabava(nabava_id) ON DELETE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id)
);

CREATE TABLE recenzija (
    recenzija_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    ocjena TINYINT CHECK (ocjena BETWEEN 1 AND 5),
    komentar TEXT,
    datum_recenzije DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id) ON DELETE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id) ON DELETE CASCADE,
    UNIQUE (kupac_id, proizvod_id)
);


-- Luka Wrana - Popunjavanje podacima --

INSERT INTO kategorija (kategorija_id, naziv, opis) VALUES
(1, 'Tamna čokolada', 'Premium tamne čokolade visokog udjela kakaa'),
(2, 'Mliječna čokolada', 'Kremaste mliječne čokolade s raznim okusima'),
(3, 'Bijela čokolada', 'Slatke bijele čokolade i kombinacije'),
(4, 'Praline', 'Ručno rađene praline punjene kremama i likerima'),
(5, 'Posebne ponude', 'Sezonske i limitirane kolekcije'),
(6, 'Čokoladne figure', 'Dekorativne figure od čokolade');


INSERT INTO dobavljac (dobavljac_id, naziv, kontakt_osoba, email, telefon, adresa) VALUES
(1, 'Cocoa Imports Europe', 'Marko Jurić', 'info@cocoa-eu.com', '01 555 111', 'Zagreb, Hrvatska'),
(2, 'Belgian Chocolate Supply', 'Anna De Vries', 'sales@belgianchoco.be', '+32 555 222', 'Brussels, Belgium'),
(3, 'Organic Cacao Farm', 'Luis Hernandez', 'contact@organiccacao.com', '+57 300 111', 'Medellin, Colombia');


INSERT INTO kupac (kupac_id, ime, prezime, email, lozinka, telefon) VALUES
(1, 'Luka', 'Kovač', 'luka@gmail.com', 'pass1', '0911111111'),
(2, 'Mia', 'Horvat', 'mia@gmail.com', 'pass2', '0911111112'),
(3, 'Ivan', 'Barić', 'ivan@gmail.com', 'pass3', '0911111113'),
(4, 'Ana', 'Novak', 'ana@gmail.com', 'pass4', '0911111114'),
(5, 'Petra', 'Marić', 'petra@gmail.com', 'pass5', '0911111115'),
(6, 'Marko', 'Šimić', 'marko@gmail.com', 'pass6', '0911111116'),
(7, 'Dario', 'Vuković', 'dario@gmail.com', 'pass7', '0911111117'),
(8, 'Nina', 'Kralj', 'nina@gmail.com', 'pass8', '0911111118'),
(9, 'Josip', 'Babić', 'josip@gmail.com', 'pass9', '0911111119'),
(10,'Sara', 'Lukic', 'sara@gmail.com', 'pass10', '0911111120');


INSERT INTO adresa (kupac_id, ulica, grad, postanski_broj, glavna_adresa) VALUES
(1,'Ilica 1','Zagreb','10000',1),
(1,'Gajeva 10','Zagreb','10000',0),
(2,'Korzo 5','Rijeka','51000',1),
(2,'Laginjina 2','Rijeka','51000',0),
(3,'Strossmayerova 3','Osijek','31000',1),
(3,'Vukovarska 9','Osijek','31000',0),
(4,'Poljička 7','Split','21000',1),
(4,'Riva 1','Split','21000',0),
(5,'Dubrava 12','Zagreb','10000',1),
(6,'Varaždinska 8','Varaždin','42000',1),
(7,'Čakovečka 15','Čakovec','40000',1),
(8,'Zagrebačka 22','Karlovac','47000',1),
(9,'Trg bana 4','Zagreb','10000',1),
(10,'Petrinjska 6','Zagreb','10000',1);


INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(2,'Mliječna čokolada s lješnjakom','Kremasta mliječna s prženim lješnjacima',3.50,100,'ML1'),
(2,'Mliječna s dehidriranom malinom','Voćna nota maline u mliječnoj čokoladi',3.80,90,'ML2'),
(2,'Mliječna karamel sea salt','Slatko-slana kombinacija karamele i soli',4.00,80,'ML3'),
(2,'Mliječna čokolada s bademom','Hrskavi bademi u mliječnoj bazi',3.60,110,'ML4'),
(2,'Mliječna kokos dream','Egzotični kokos u mliječnoj čokoladi',3.90,95,'ML5');

INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(1,'Tamna 70% kakao','Intenzivna gorka čokolada',3.20,120,'T1'),
(1,'Tamna s narančom','Citrusna aroma naranče',3.40,100,'T2'),
(1,'Tamna chili spice','Ljuta čokolada s chili paprikom',3.60,85,'T3');

INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(3,'Bijela vanilija','Kremasta vanilija čokolada',3.10,110,'B1'),
(3,'Bijela s jagodom','Voćna jagoda u bijeloj čokoladi',3.30,95,'B2'),
(3,'Bijela pistacija','Premium pistacija blend',3.80,70,'B3');

INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(4,'Praline rum','Punjenje s rum kremom',5.50,60,'P1'),
(4,'Praline lješnjak krema','Bogata lješnjak krema',5.80,65,'P2'),
(4,'Praline espresso','Kava + čokolada kombinacija',5.60,55,'P3');


INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(5,'Valentinovo box','Mix premium čokolada',12.90,40,'S1'),
(5,'Božićna kolekcija','Sezonski paketić',14.90,35,'S2'),
(5,'Gourmet tasting set','Degustacijski paket',19.90,25,'S3');


INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(6,'Čokoladni zeko','Ručna figura zeca',6.50,50,'F1'),
(6,'Čokoladni medvjedić','Dekorativni medvjedić',6.80,45,'F2'),
(6,'Čokoladno srce','Romantična figura srca',7.00,60,'F3');


DELIMITER $$

CREATE PROCEDURE generate_orders()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_customer INT;
    DECLARE random_address INT;
    DECLARE order_id INT;

    WHILE i <= 60 DO

        SET random_customer = FLOOR(1 + RAND() * 10);
        
        SELECT adresa_id
        INTO random_address
        FROM adresa
        WHERE kupac_id = random_customer
        ORDER BY RAND()
        LIMIT 1;

        INSERT INTO narudzba (
            kupac_id,
            adresa_id,
            datum_narudzbe,
            status,
            ukupan_iznos
        )
        VALUES (
            random_customer,
            random_address,
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*60) DAY),
            'Završena',
            0
        );

        SET order_id = LAST_INSERT_ID();

        INSERT INTO stavka_narudzbe (
            narudzba_id,
            proizvod_id,
            kolicina,
            cijena_po_komadu,
            ukupna_cijena
        )
        VALUES
        (order_id, FLOOR(1 + RAND()*18), 1, 3.5, 3.5),
        (order_id, FLOOR(1 + RAND()*18), 2, 4.0, 8.0),
        (order_id, FLOOR(1 + RAND()*18), 1, 5.5, 5.5);

        SET i = i + 1;
    END WHILE;

END $$

DELIMITER ;

CALL generate_orders();

UPDATE narudzba n
JOIN (
    SELECT narudzba_id, SUM(ukupna_cijena) AS total
    FROM stavka_narudzbe
    GROUP BY narudzba_id
) s ON s.narudzba_id = n.narudzba_id
SET n.ukupan_iznos = s.total;

INSERT INTO placanje (narudzba_id, nacin_placanja, iznos, status_placanja, datum_placanja)
SELECT 
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal'),
    ukupan_iznos,
    'Plaćeno',
    datum_narudzbe + INTERVAL FLOOR(RAND()*2) DAY
FROM narudzba;

INSERT INTO dostava (narudzba_id, kurirska_sluzba, broj_posiljke, status_dostave, procijenjeni_datum, stvarni_datum)
SELECT
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'DHL', 'GLS', 'HP'),
    CONCAT('HR', FLOOR(100000 + RAND()*900000)),
    'Dostavljeno',
    DATE(datum_narudzbe + INTERVAL 3 DAY),
    DATE(datum_narudzbe + INTERVAL 2 + FLOOR(RAND()*2) DAY)
FROM narudzba;


INSERT INTO nabava (dobavljac_id, datum_nabave, status, ukupan_iznos)
VALUES
(1, NOW() - INTERVAL 30 DAY, 'Zaprimljeno', 500),
(2, NOW() - INTERVAL 20 DAY, 'Zaprimljeno', 700),
(3, NOW() - INTERVAL 10 DAY, 'Zaprimljeno', 600);


INSERT INTO stavka_nabave (nabava_id, proizvod_id, kolicina, nabavna_cijena)
VALUES
(1, 1, 100, 2.0),
(1, 2, 80, 2.2),
(2, 6, 120, 1.8),
(2, 7, 90, 2.1),
(3, 10, 70, 2.5),
(3, 12, 60, 2.8);


INSERT INTO recenzija (kupac_id, proizvod_id, ocjena, komentar)
VALUES
(1,1,5,'Odlična čokolada!'),
(2,2,4,'Jako dobra, ali malo preslatka'),
(3,3,5,'Savršena kombinacija okusa'),
(4,4,4,'Fina i kremasta'),
(5,5,5,'Top proizvod!'),
(6,6,3,'Ok, ali očekivao sam više'),
(7,7,5,'Super okus naranče'),
(8,8,4,'Dobra, ali ljuta'),
(9,9,5,'Najbolja bijela čokolada'),
(10,10,4,'Vrlo ukusna'),
(1,6,5,'Tamna mi je favorit'),
(2,7,5,'Savršena aroma'),
(3,8,4,'Zanimljiva kombinacija'),
(4,9,5,'Odlična tekstura'),
(5,10,4,'Fino i lagano'),
(6,11,5,'Jagoda top'),
(7,12,5,'Pistacija odlična'),
(8,13,4,'Rum punjenje super'),
(9,14,5,'Lješnjak fantastičan'),
(10,15,5,'Espresso pun pogodak');


-- Luka Wrana - 4 pogleda --

CREATE OR REPLACE VIEW prihod_po_proizvodu AS
SELECT 
    p.proizvod_id,
    p.naziv,
    SUM(sn.kolicina * sn.cijena_po_komadu) AS ukupni_prihod
FROM proizvod p
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM prihod_po_proizvodu
ORDER BY ukupni_prihod DESC;


CREATE OR REPLACE VIEW proizvodi_po_kolicini AS
SELECT 
    p.proizvod_id,
    p.naziv,
    SUM(sn.kolicina) AS ukupna_kolicina
FROM proizvod p
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM proizvodi_po_kolicini
ORDER BY ukupna_kolicina DESC;


CREATE OR REPLACE VIEW popularnost_proizvoda AS
SELECT 
    p.proizvod_id,
    p.naziv,
    SUM(sn.kolicina) AS ukupna_kolicina,
    SUM(sn.kolicina * sn.cijena_po_komadu) AS prihod,
    (SUM(sn.kolicina) * 0.6 + SUM(sn.kolicina * sn.cijena_po_komadu) * 0.4) AS popularnost_score
FROM proizvod p
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM popularnost_proizvoda
ORDER BY popularnost_score DESC;


CREATE OR REPLACE VIEW koeficijent_kolicine_po_proizvodu AS
SELECT 
    p.proizvod_id,
    p.naziv,

    SUM(sn.kolicina) AS ukupna_kolicina,

    COUNT(DISTINCT n.narudzba_id) AS broj_narudzbi,

    CASE 
        WHEN COUNT(DISTINCT n.narudzba_id) = 0 THEN 0
        ELSE SUM(sn.kolicina) / COUNT(DISTINCT n.narudzba_id)
    END AS prosjecna_kolicina_po_narudzbi

FROM proizvod p
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM koeficijent_kolicine_po_proizvodu
ORDER BY prosjecna_kolicina_po_narudzbi DESC;


-- Andrej Pucović - 5 upita --

-- Upit 1: Ukupan broj narudžbi i potrošnja po kupcu
SELECT 
    k.kupac_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    k.email,
    COUNT(n.narudzba_id) AS broj_narudzbi,
    ROUND(SUM(n.ukupan_iznos), 2) AS ukupno_potroseno,
    ROUND(AVG(n.ukupan_iznos), 2) AS prosjecna_vrijednost_narudzbe
FROM kupac k
JOIN narudzba n ON k.kupac_id = n.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime, k.email
HAVING COUNT(n.narudzba_id) >= 1
ORDER BY ukupno_potroseno DESC;

-- Upit 2: Najprodavaniji proizvodi po količini i prihodu
SELECT 
    p.proizvod_id,
    p.naziv,
    k.naziv AS kategorija,
    SUM(sn.kolicina) AS ukupno_prodano,
    ROUND(SUM(sn.ukupna_cijena), 2) AS ukupni_prihod
FROM proizvod p
JOIN kategorija k ON p.kategorija_id = k.kategorija_id
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.naziv, k.naziv
ORDER BY ukupno_prodano DESC, ukupni_prihod DESC
LIMIT 5;

-- Upit 3: Proizvodi koji nisu prodani 
SELECT 
    p.proizvod_id,
    p.naziv,
    p.cijena,
    p.kolicina_na_skladistu
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
WHERE sn.proizvod_id IS NULL
ORDER BY p.naziv;

-- Upit 4: Kupci čija je potrošnja veća od prosjeka
SELECT *
FROM (
    SELECT 
        k.kupac_id,
        CONCAT(k.ime, ' ', k.prezime) AS kupac,
        ROUND(SUM(n.ukupan_iznos), 2) AS ukupna_potrosnja
    FROM kupac k
    JOIN narudzba n ON k.kupac_id = n.kupac_id
    GROUP BY k.kupac_id, k.ime, k.prezime
) x
WHERE x.ukupna_potrosnja > (
    SELECT AVG(potrosnja_po_kupcu)
    FROM (
        SELECT SUM(n2.ukupan_iznos) AS potrosnja_po_kupcu
        FROM narudzba n2
        GROUP BY n2.kupac_id
    ) y
)
ORDER BY x.ukupna_potrosnja DESC;

-- Upit 5: Mjesečni prihod trgovine
SELECT 
    YEAR(datum_narudzbe) AS godina,
    MONTH(datum_narudzbe) AS mjesec,
    COUNT(*) AS broj_narudzbi,
    ROUND(SUM(ukupan_iznos), 2) AS mjesecni_prihod,
    ROUND(AVG(ukupan_iznos), 2) AS prosjecna_narudzba
FROM narudzba
GROUP BY YEAR(datum_narudzbe), MONTH(datum_narudzbe)
ORDER BY godina, mjesec;


-- Andrej Pucović - 5 pogleda

-- Pogled 1: Aktivni kupci s osnovnim podacima
CREATE VIEW AP_Pogled_aktivni_kupci AS
SELECT 
    kupac_id,
    ime,
    prezime,
    email,
    telefon,
    datum_registracije
FROM kupac
WHERE aktivan = TRUE;

-- Pogled 2: Proizvodi i njihove kategorije
CREATE VIEW AP_Pogled_proizvodi_kategorije AS
SELECT 
    p.proizvod_id,
    p.naziv AS proizvod,
    k.naziv AS kategorija,
    p.cijena,
    p.kolicina_na_skladistu,
    p.SKU
FROM proizvod p
RIGHT JOIN kategorija k ON p.kategorija_id = k.kategorija_id;

-- Pogled 3: Detalji narudžbi
CREATE VIEW AP_Pogled_detalji_narudzbi AS
SELECT 
    n.narudzba_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    n.datum_narudzbe,
    n.status,
    n.ukupan_iznos,
    a.grad,
    a.ulica
FROM narudzba n
JOIN kupac k ON n.kupac_id = k.kupac_id
JOIN adresa a ON n.adresa_id = a.adresa_id;

-- Pogled 4: Stavke narudžbi
CREATE VIEW AP_Pogled_stavke_narudzbe AS
SELECT 
    sn.stavka_id,
    sn.narudzba_id,
    p.naziv AS proizvod,
    sn.kolicina,
    sn.cijena_po_komadu,
    sn.ukupna_cijena
FROM stavka_narudzbe sn
JOIN proizvod p 
    ON sn.proizvod_id = p.proizvod_id
    AND sn.ukupna_cijena > sn.cijena_po_komadu;

-- Pogled 5: Plaćanja narudžbi
CREATE VIEW AP_Pogled_placanja_narudzbi AS
SELECT 
    p.placanje_id,
    p.narudzba_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    p.nacin_placanja,
    p.iznos,
    p.status_placanja,
    p.datum_placanja,
    n.status AS status_narudzbe
FROM placanje p
JOIN narudzba n ON p.narudzba_id = n.narudzba_id
JOIN kupac k ON n.kupac_id = k.kupac_id;


-- Danijel Margić - 5 upita --

SELECT 
    p.proizvod_id,
    p.naziv AS proizvod,
    p.cijena AS prodajna_cijena,
    ROUND(AVG(sn.nabavna_cijena), 2) AS prosjecna_nabavna_cijena,
    ROUND((p.cijena - AVG(sn.nabavna_cijena)), 2) AS profit_po_komadu,
    ROUND(((p.cijena - AVG(sn.nabavna_cijena)) / p.cijena) * 100, 2) AS marza_postotak
FROM proizvod p
INNER JOIN stavka_nabave sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.naziv, p.cijena
ORDER BY marza_postotak DESC;

SELECT 
    k.naziv AS kategorija_naziv,
    COUNT(DISTINCT sn.narudzba_id) AS ukupno_narudzbi,
    SUM(sn.kolicina) AS prodano_komada,
    SUM(sn.ukupna_cijena) AS ukupni_prihod,
    ROUND(AVG(sn.ukupna_cijena), 2) AS prosjecna_vrijednost_stavke
FROM kategorija k
INNER JOIN proizvod p ON k.kategorija_id = p.kategorija_id
INNER JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
GROUP BY k.kategorija_id, k.naziv
ORDER BY ukupni_prihod DESC;

SELECT 
    p.proizvod_id,
    p.naziv AS proizvod_naziv,
    p.cijena,
    ROUND(AVG(r.ocjena), 2) AS prosjecna_ocjena,
    COUNT(r.recenzija_id) AS broj_recenzija
FROM proizvod p
INNER JOIN recenzija r ON p.proizvod_id = r.proizvod_id
GROUP BY p.proizvod_id, p.naziv, p.cijena
HAVING broj_recenzija >= 2
ORDER BY prosjecna_ocjena DESC, broj_recenzija DESC;

SELECT 
    p.proizvod_id,
    p.naziv,
    p.kolicina_na_skladistu,
    SUM(sn.kolicina) AS ukupno_prodano
FROM proizvod p
INNER JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
WHERE p.kolicina_na_skladistu < (
    SELECT AVG(kolicina_na_skladistu) FROM proizvod WHERE aktivan = TRUE
)
GROUP BY p.proizvod_id, p.naziv, p.kolicina_na_skladistu
ORDER BY p.kolicina_na_skladistu ASC;

SELECT 
    p.proizvod_id,
    p.SKU,
    p.naziv AS proizvod_naziv,
    COALESCE(SUM(sn.kolicina), 0) AS ukupno_prodanih_komada,
    COALESCE(SUM(sn.ukupna_cijena), 0) AS ukupni_ostvareni_prihod
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.SKU, p.naziv
ORDER BY ukupno_prodanih_komada ASC;

-- Danijel Margić - 5 pogleda --

CREATE OR REPLACE VIEW v_pregled_potrosnje_kupaca AS
SELECT 
    k.kupac_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac_ime_prezime,
    k.email,
    COUNT(n.narudzba_id) AS ukupno_narudzbi,
    COALESCE(SUM(n.ukupan_iznos), 0) AS ukupno_potroseno
FROM kupac k
LEFT JOIN narudzba n ON k.kupac_id = n.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime, k.email;

-- Pozivanje pogleda uz sortiranje po ukupnoj potrošnji silazno
SELECT * FROM v_pregled_potrosnje_kupaca 
ORDER BY ukupno_potroseno DESC;


CREATE OR REPLACE VIEW v_analiza_dobavljaca_opskrba AS
SELECT 
    d.dobavljac_id,
    d.naziv AS dobavljac_naziv,
    d.kontakt_osoba,
    COUNT(n.nabava_id) AS broj_realiziranih_nabava,
    COALESCE(SUM(n.ukupan_iznos), 0) AS ukupno_isplaceno_dobavljacu
FROM nabava n
RIGHT JOIN dobavljac d ON n.dobavljac_id = d.dobavljac_id
GROUP BY d.dobavljac_id, d.naziv, d.kontakt_osoba;

-- Pozivanje pogleda uz sortiranje po ukupnim troškovima nabave silazno
SELECT * FROM v_analiza_dobavljaca_opskrba 
ORDER BY ukupno_isplaceno_dobavljacu DESC;


CREATE OR REPLACE VIEW v_analiza_popularnosti_proizvoda AS
SELECT 
    p.proizvod_id,
    p.naziv AS proizvod_naziv,
    COALESCE(SUM(sn.kolicina), 0) AS ukupno_prodanih_komada,
    COALESCE(SUM(sn.ukupna_cijena), 0) AS ukupni_ostvareni_prihod
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.naziv
ORDER BY ukupno_prodanih_komada DESC;

-- Pozivanje pogleda uz sortiranje po prodanim komadima silazno
SELECT * FROM v_analiza_popularnosti_proizvoda 
ORDER BY ukupno_prodanih_komada DESC;

CREATE OR REPLACE VIEW v_javne_recenzije_proizvoda AS
SELECT 
    r.recenzija_id,
    p.naziv AS proizvod_naziv,
    CONCAT(k.ime, ' ', k.prezime) AS kupac_autor,
    r.ocjena,
    r.komentar,
    r.datum_recenzije
FROM recenzija r
INNER JOIN proizvod p ON r.proizvod_id = p.proizvod_id
INNER JOIN kupac k ON r.kupac_id = k.kupac_id
-- uz dodavanje uvjeta lako se izaberu recenzije sa odredjenom ocjenom
-- WHERE r.ocjena = 1; 

-- Pozivanje pogleda uz sortiranje po ocjenama uzlazno
SELECT * FROM v_javne_recenzije_proizvoda 
ORDER BY ocjena ASC;

CREATE OR REPLACE VIEW v_logistika_dostave_detalji AS
SELECT 
    d.dostava_id,
    d.narudzba_id,
    CONCAT(k.ime, ' ', k.prezime) AS primatelj,
    CONCAT(a.ulica, ', ', a.postanski_broj, ' ', a.grad) AS adresa_dostave,
    d.kurirska_sluzba,
    d.broj_posiljke,
    d.status_dostave
FROM dostava d
INNER JOIN narudzba n ON d.narudzba_id = n.narudzba_id
INNER JOIN kupac k ON n.kupac_id = k.kupac_id
INNER JOIN adresa a ON n.adresa_id = a.adresa_id;

-- Pozivanje pogleda uz filtriranje samo onih dostava koje su u tijeku
SELECT * FROM v_logistika_dostave_detalji 
WHERE status_dostave IN ('U tranzitu', 'Otpremljeno');

-- Andrej Pucović i Danijel Margić - Triggeri --

DELIMITER $$

CREATE TRIGGER trg_stavka_narudzbe_kontrola
BEFORE INSERT ON stavka_narudzbe
FOR EACH ROW
BEGIN
    DECLARE dostupno_na_skladistu INT;
    
    -- 1. Dohvaćanje trenutnog stanja na skladištu za proizvod
    SELECT kolicina_na_skladistu INTO dostupno_na_skladistu
    FROM proizvod
    WHERE proizvod_id = NEW.proizvod_id;
    
    -- 2. Provjera ima li dovoljno robe na skladištu
    IF NEW.kolicina > dostupno_na_skladistu THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Greška: Nema dovoljno proizvoda na skladištu za izvršavanje narudžbe!';
    END IF;
    
    -- 3. Automatski izračun ukupne cijene stavke
    SET NEW.ukupna_cijena = NEW.kolicina * NEW.cijena_po_komadu;
END$$

DELIMITER ;

INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (1, 1, 2, 3.50);

SELECT * FROM stavka_narudzbe WHERE narudzba_id = 1 AND proizvod_id = 1;

INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (1, 1, 500, 3.50);

DELIMITER $$

CREATE TRIGGER trg_azuriraj_zalihe_nakon_prodaje
AFTER INSERT ON stavka_narudzbe
FOR EACH ROW
BEGIN
    UPDATE proizvod 
    SET kolicina_na_skladistu = kolicina_na_skladistu - NEW.kolicina
    WHERE proizvod_id = NEW.proizvod_id;
END$$

DELIMITER ;

SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 3;

INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (2, 3, 5, 4.00);

SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 3;

DELIMITER $$

CREATE TRIGGER trg_validacija_email_kupca
BEFORE INSERT ON kupac
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Greška: Unesena e-mail adresa nije u ispravnom formatu!';
    END IF;
END$$

DELIMITER ;

INSERT INTO kupac (ime, prezime, email, lozinka, telefon, aktivan) 
VALUES ('Test', 'Korisnik', 'krivi_email_bez_znaka', 'lozinka123', '0919999999', 1);

INSERT INTO kupac (ime, prezime, email, lozinka, telefon, aktivan) 
VALUES ('Test', 'Korisnik', 'ispravan.email@gmail.com', 'lozinka123', '0919999999', 1);

SELECT * FROM kupac WHERE email = 'ispravan.email@gmail.com';

CREATE TRIGGER trg_povecaj_zalihe_nakon_nabave
AFTER INSERT ON stavka_nabave
FOR EACH ROW
BEGIN
    UPDATE proizvod 
    SET kolicina_na_skladistu = kolicina_na_skladistu + NEW.kolicina
    WHERE proizvod_id = NEW.proizvod_id;
END$$

DELIMITER ;

SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 4;

INSERT INTO stavka_nabave (nabava_id, proizvod_id, kolicina, nabavna_cijena) 
VALUES (1, 4, 50, 2.10);

SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 4;
