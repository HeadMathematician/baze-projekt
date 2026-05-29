DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_croatian_ci;
USE ecommerce;


-- Teo Kupčinovac - Izrada tablica --
CREATE TABLE kupac (
    kupac_id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    lozinka VARCHAR(255) NOT NULL,
    telefon VARCHAR(20),
    datum_registracije DATE NOT NULL DEFAULT (CURRENT_DATE),
    aktivan BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE adresa (
    adresa_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    ulica_i_broj VARCHAR(100) NOT NULL,
    grad VARCHAR(50) NOT NULL,
    postanski_broj VARCHAR(10) NOT NULL,
    drzava VARCHAR(50) NOT NULL DEFAULT 'Hrvatska',
    glavna_adresa BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id) ON DELETE CASCADE ON UPDATE CASCADE
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
    naziv VARCHAR(100) NOT NULL,
    opis TEXT
);


CREATE TABLE proizvod (
    proizvod_id INT AUTO_INCREMENT PRIMARY KEY,
    kategorija_id INT NOT NULL,
    naziv VARCHAR(150) NOT NULL,
    opis TEXT,
    cijena DECIMAL(10,2) NOT NULL CHECK (cijena > 0),
    kolicina_na_skladistu INT NOT NULL DEFAULT 0 CHECK (kolicina_na_skladistu >= 0),
    SKU VARCHAR(50) UNIQUE,
    aktivan BOOLEAN NOT NULL DEFAULT TRUE,
    datum_dodavanja DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kategorija_id) REFERENCES kategorija(kategorija_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE narudzba (
    narudzba_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    datum_narudzbe DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_narudzbe VARCHAR(50) NOT NULL DEFAULT 'na_cekanju',
    cijena_dostave DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id) ON DELETE CASCADE
);


CREATE TABLE stavka_narudzbe (
    stavka_narudzbe_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL CHECK (kolicina > 0),
    cijena_po_komadu DECIMAL(10,2) NOT NULL CHECK (cijena_po_komadu > 0),

    UNIQUE (narudzba_id, proizvod_id),

    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE placanje (
    placanje_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL UNIQUE,
    nacin_placanja VARCHAR(50) NOT NULL,
    status_placanja VARCHAR(50) NOT NULL DEFAULT 'u_obradi',
    datum_placanja DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE dostava (
    dostava_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL UNIQUE,
    kurirska_sluzba VARCHAR(100) NOT NULL,
    broj_posiljke VARCHAR(50),
    status_dostave VARCHAR(50) NOT NULL DEFAULT 'priprema',
    procijenjeni_datum DATE,
    stvarni_datum DATE,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE nabava (
    nabava_id INT AUTO_INCREMENT PRIMARY KEY,
    dobavljac_id INT NOT NULL,
    datum_nabave DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_nabave VARCHAR(50) NOT NULL DEFAULT 'na_cekanju',
    FOREIGN KEY (dobavljac_id) REFERENCES dobavljac(dobavljac_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE stavka_nabave (
    stavka_nabave_id INT AUTO_INCREMENT PRIMARY KEY,
    nabava_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    nabavna_cijena DECIMAL(10,2) NOT NULL CHECK (nabavna_cijena > 0),

    UNIQUE (nabava_id, proizvod_id),

    FOREIGN KEY (nabava_id) REFERENCES nabava(nabava_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE recenzija (
    recenzija_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    ocjena TINYINT NOT NULL CHECK (ocjena BETWEEN 1 AND 5),
    komentar TEXT,
    datum_recenzije DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (kupac_id, proizvod_id),

    FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id) ON DELETE CASCADE ON UPDATE CASCADE
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


INSERT INTO kupac (kupac_id, ime, prezime, email, lozinka, telefon, datum_registracije, aktivan) VALUES
(1, 'Luka', 'Kovač', 'luka.kovac@gmail.com', 'hash_pass_1', '0911111111', '2026-01-10', 1),
(2, 'Mia', 'Horvat', 'mia.horvat@gmail.com', 'hash_pass_2', '0911111112', '2026-01-12', 1),
(3, 'Ivan', 'Barić', 'ivan.baric@gmail.com', 'hash_pass_3', '0911111113', '2026-01-15', 1),
(4, 'Ana', 'Novak', 'ana.novak@gmail.com', 'hash_pass_4', '0911111114', '2026-01-20', 1),
(5, 'Petra', 'Marić', 'petra.maric@gmail.com', 'hash_pass_5', '0911111115', '2026-01-22', 1),
(6, 'Marko', 'Šimić', 'marko.simic@gmail.com', 'hash_pass_6', '0911111116', '2026-01-25', 0),
(7, 'Dario', 'Vuković', 'dario.vukovic@gmail.com', 'hash_pass_7', '0911111117', '2026-01-28', 1),
(8, 'Nina', 'Kralj', 'nina.kralj@gmail.com', 'hash_pass_8', '0911111118', '2026-02-01', 1),
(9, 'Josip', 'Babić', 'josip.babic@gmail.com', 'hash_pass_9', '0911111119', '2026-02-03', 1),
(10, 'Sara', 'Lukić', 'sara.lukic@gmail.com', 'hash_pass_10', '0911111120', '2026-02-05', 1),
(11, 'Stjepan', 'Radić', 'stjepan.radic@net.hr', 'hash_pass_11', '0952223344', '2026-02-10', 1),
(12, 'Elena', 'Zadro', 'elena.zadro@gmail.com', 'hash_pass_12', '0987776655', '2026-02-12', 0),
(13, 'Karlo', 'Perić', 'karlo.peric@outlook.com', 'hash_pass_13', '0923334455', '2026-02-14', 1),
(14, 'Marta', 'Vidaković', 'marta.v@gmail.com', 'hash_pass_14', '0914445566', '2026-02-18', 1),
(15, 'Tomislav', 'Prpić', 'tomo.prpic@gmail.com', 'hash_pass_15', '0998889900', '2026-02-20', 0),
(16, 'Lucija', 'Jurić', 'lucija.juric@yahoo.com', 'hash_pass_16', '0951112233', '2026-02-22', 1),
(17, 'Filip', 'Knežević', 'filip.k@gmail.com', 'hash_pass_17', '0915556677', '2026-02-25', 0),
(18, 'Iva', 'Lončar', 'iva.loncar@gmail.com', 'hash_pass_18', '0981114455', '2026-02-27', 1),
(19, 'Mateo', 'Brkić', 'mateo.brkic@gmail.com', 'hash_pass_19', '0928887766', '2026-03-01', 0),
(20, 'Valentina', 'Blažević', 'vale.blaz@outlook.com', 'hash_pass_20', '0993332211', '2026-03-04', 1),
(21, 'Bruno', 'Lovrić', 'bruno.lovric@gmail.com', 'hash_pass_21', '0917778899', '2026-03-06', 1),
(22, 'Dora', 'Pavić', 'dora.pavic@gmail.com', 'hash_pass_22', '0956667788', '2026-03-10', 1),
(23, 'Antonio', 'Tadić', 'antonio.tadic@net.hr', 'hash_pass_23', '0984445522', '2026-03-12', 1),
(24, 'Ema', 'Vidović', 'ema.vidovic@gmail.com', 'hash_pass_24', '0921119988', '2026-03-15', 1),
(25, 'Leon', 'Tomat', 'leon.tomat@gmail.com', 'hash_pass_25', '0913335544', '2026-03-18', 1),
(26, 'Lana', 'Kraljević', 'lana.k@gmail.com', 'hash_pass_26', '0994441122', '2026-03-20', 1),
(27, 'Marin', 'Sarić', 'marin.saric@gmail.com', 'hash_pass_27', '0959998877', '2026-03-22', 1),
(28, 'Tea', 'Marković', 'tea.mar@outlook.com', 'hash_pass_28', '0912228833', '2026-03-25', 1),
(29, 'Robert', 'Galić', 'robert.galic@gmail.com', 'hash_pass_29', '0981112299', '2026-03-28', 0),
(30, 'Anamarija', 'Barišić', 'anamarija.b@gmail.com', 'hash_pass_30', '0926665544', '2026-04-01', 1),
(31, 'Nikola', 'Pavičić', 'nikola.p@gmail.com', 'hash_pass_31', '0914447788', '2026-04-03', 1),
(32, 'Helena', 'Matić', 'helena.matic@gmail.com', 'hash_pass_32', '0953339900', '2026-04-05', 1);


INSERT INTO adresa (adresa_id, kupac_id, ulica_i_broj, grad, postanski_broj, drzava, glavna_adresa) VALUES
(1, 1, 'Ilica 1', 'Zagreb', '10000', 'Hrvatska', 1),
(2, 2, 'Korzo 5', 'Rijeka', '51000', 'Hrvatska', 1),
(3, 3, 'Strossmayerova 3', 'Osijek', '31000', 'Hrvatska', 1),
(4, 4, 'Poljička 7', 'Split', '21000', 'Hrvatska', 1),
(5, 5, 'Dubrava 12', 'Zagreb', '10000', 'Hrvatska', 1),
(6, 6, 'Varaždinska 8', 'Varaždin', '42000', 'Hrvatska', 1),
(7, 7, 'Čakovečka 15', 'Čakovec', '40000', 'Hrvatska', 1),
(8, 8, 'Zagrebačka 22', 'Karlovac', '47000', 'Hrvatska', 1),
(9, 9, 'Trg bana Jelačića 4', 'Zagreb', '10000', 'Hrvatska', 1),
(10, 10, 'Petrinjska 6', 'Zagreb', '10000', 'Hrvatska', 1),
(11, 11, 'Vukovarska 45', 'Split', '21000', 'Hrvatska', 1),
(12, 12, 'Matije Gupca 12', 'Zadar', '23000', 'Hrvatska', 1),
(13, 13, 'Riječka 88', 'Opatija', '51410', 'Hrvatska', 1),
(14, 14, 'Osječka 101', 'Đakovo', '31400', 'Hrvatska', 1),
(15, 15, 'Kralja Tomislava 2', 'Pula', '52100', 'Hrvatska', 1),
(16, 16, 'Gundulićeva 14', 'Zagreb', '10000', 'Hrvatska', 1),
(17, 17, 'Frankopanska 9', 'Karlovac', '47000', 'Hrvatska', 1),
(18, 18, 'Splitska 33', 'Šibenik', '22000', 'Hrvatska', 1),
(19, 19, 'Dubrovačka 5', 'Dubrovnik', '20000', 'Hrvatska', 1),
(20, 20, 'Svačićeva 18', 'Slavonski Brod', '35000', 'Hrvatska', 1),
(21, 21, 'Ante Starčevića 55', 'Vinkovci', '32100', 'Hrvatska', 1),
(22, 22, 'Zagrebačka 112', 'Varaždin', '42000', 'Hrvatska', 1),
(23, 23, 'Trg Slobode 3', 'Poreč', '52440', 'Hrvatska', 1),
(24, 24, 'Križanićeva 7', 'Zagreb', '10000', 'Hrvatska', 1),
(25, 25, 'Stanka Vraza 22', 'Samobor', '10430', 'Hrvatska', 1),
(26, 26, 'Matice Hrvatske 4', 'Bjelovar', '43000', 'Hrvatska', 1),
(27, 27, 'Kumičićeva 19', 'Rijeka', '51000', 'Hrvatska', 1),
(28, 28, 'Ilirska 2', 'Osijek', '31000', 'Hrvatska', 1),
(29, 29, 'Velebitska 67', 'Split', '21000', 'Hrvatska', 1),
(30, 30, 'Maksimirska 90', 'Zagreb', '10000', 'Hrvatska', 1),
(31, 31, 'Nazorova 14', 'Koprivnica', '48000', 'Hrvatska', 1),
(32, 32, 'Držićeva 8', 'Sisak', '44000', 'Hrvatska', 1),
(33, 1, 'Savska cesta 55', 'Zagreb', '10000', 'Hrvatska', 0),
(34, 5, 'Cvjetna 9', 'Velika Gorica', '10410', 'Hrvatska', 0),
(35, 12, 'Splitska 44', 'Makarska', '21300', 'Hrvatska', 0);


INSERT INTO proizvod (kategorija_id, naziv, opis, cijena, kolicina_na_skladistu, SKU) VALUES
(2,'Mliječna čokolada s lješnjakom','Kremasta mliječna s prženim lješnjacima',3.50,100,'ML1'),
(2,'Mliječna s dehidriranom malinom','Voćna nota maline u mliječnoj čokoladi',3.80,90,'ML2'),
(2,'Mliječna karamel sea salt','Slatko-slana kombinacija karamele i soli',4.00,80,'ML3'),
(2,'Mliječna čokolada s bademom','Hrskavi bademi u mliječnoj bazi',3.60,110,'ML4'),
(2,'Mliječna kokos dream','Egzotični kokos u mliječnoj čokoladi',3.90,95,'ML5'),

(1,'Tamna 70% kakao','Intenzivna gorka čokolada',3.20,120,'T1'),
(1,'Tamna s narančom','Citrusna aroma naranče',3.40,100,'T2'),
(1,'Tamna chili spice','Ljuta čokolada s chili paprikom',3.60,85,'T3'),
(1,'Tamna mint fusion','Svježa menta i tamna čokolada',3.70,75,'T4'),
(1,'Tamna espresso intense','Bogata aroma espresso kave',3.90,65,'T5'),

(3,'Bijela vanilija','Kremasta vanilija čokolada',3.10,110,'B1'),
(3,'Bijela s jagodom','Voćna jagoda u bijeloj čokoladi',3.30,95,'B2'),
(3,'Bijela pistacija','Premium pistacija blend',3.80,70,'B3'),
(3,'Bijela limun cheesecake','Kombinacija limuna i keksa',3.60,85,'B4'),
(3,'Bijela cookies cream','Keksići u kremastoj bijeloj čokoladi',3.70,80,'B5'),

(4,'Praline rum','Punjenje s rum kremom',5.50,60,'P1'),
(4,'Praline lješnjak krema','Bogata lješnjak krema',5.80,65,'P2'),
(4,'Praline espresso','Kava + čokolada kombinacija',5.60,55,'P3'),
(4,'Praline pistacija','Punjene pistacija kremom',6.10,50,'P4'),
(4,'Praline caramel gold','Tekuća karamela u sredini',6.20,45,'P5'),

(5,'Valentinovo box','Mix premium čokolada',12.90,40,'S1'),
(5,'Božićna kolekcija','Sezonski paketić',14.90,35,'S2'),
(5,'Gourmet tasting set','Degustacijski paket',19.90,25,'S3'),
(5,'Uskrsna kolekcija','Tematski uskrsni paket',15.90,30,'S4'),
(5,'Luxury gold edition','Ekskluzivna premium kolekcija',24.90,15,'S5'),

(6,'Čokoladni zeko','Ručna figura zeca',6.50,50,'F1'),
(6,'Čokoladni medvjedić','Dekorativni medvjedić',6.80,45,'F2'),
(6,'Čokoladno srce','Romantična figura srca',7.00,60,'F3'),
(6,'Čokoladna ruža','Elegantna ruža od čokolade',7.50,40,'F4'),
(6,'Čokoladni dinosaurus','Zabavna figura za djecu',8.20,35,'F5');


DELIMITER $$

CREATE PROCEDURE generiraj_narudzbe()
BEGIN
    DECLARE id_narudzbe INT;
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE random_kupac INT;
    DECLARE random_proizvod INT;
    DECLARE random_kolicina INT;

    WHILE i <= 60 DO

        SET random_kupac = FLOOR(1 + RAND() * 32);

        INSERT INTO narudzba (
            kupac_id,
            datum_narudzbe,
            status_narudzbe,
            cijena_dostave
        )
        VALUES (
            random_kupac,
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*60) DAY),
            'Završena',
            ROUND(2 + (RAND() * 5), 2)
        );

        SET id_narudzbe = LAST_INSERT_ID();
        SET j = 1;

        WHILE j <= 3 DO

            SET random_proizvod = FLOOR(1 + RAND() * 30);
            SET random_kolicina = FLOOR(1 + RAND() * 3);

            INSERT IGNORE INTO stavka_narudzbe (
                narudzba_id,
                proizvod_id,
                kolicina,
                cijena_po_komadu
            )
            SELECT
                id_narudzbe,
                p.proizvod_id,
                random_kolicina,
                p.cijena
            FROM proizvod p
            WHERE p.proizvod_id = random_proizvod;

            SET j = j + 1;

        END WHILE;

        SET i = i + 1;
    END WHILE;

END $$

DELIMITER ;

CALL generiraj_narudzbe();


INSERT INTO placanje (narudzba_id, nacin_placanja, status_placanja, datum_placanja)
SELECT 
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal'),
    'placeno',
    datum_narudzbe + INTERVAL FLOOR(RAND()*2) DAY
FROM narudzba;


INSERT INTO dostava (narudzba_id, kurirska_sluzba, broj_posiljke, status_dostave, procijenjeni_datum, stvarni_datum)
SELECT
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'DHL', 'GLS', 'HP'),
    CONCAT('HR', FLOOR(100000 + RAND()*900000)),
    'dostavljeno',
    DATE(datum_narudzbe + INTERVAL 3 DAY),
    DATE(datum_narudzbe + INTERVAL 2 + FLOOR(RAND()*2) DAY)
FROM narudzba;


INSERT INTO nabava (nabava_id, dobavljac_id, datum_nabave, status_nabave) VALUES
(1, 1, '2026-04-01', 'Zaprimljeno'),
(2, 2, '2026-04-03', 'Zaprimljeno'),
(3, 3, '2026-04-05', 'Zaprimljeno'),
(4, 1, '2026-04-07', 'Zaprimljeno'),
(5, 2, '2026-04-10', 'Zaprimljeno'),
(6, 3, '2026-04-12', 'Zaprimljeno'),
(7, 1, '2026-04-15', 'Zaprimljeno'),
(8, 2, '2026-04-18', 'Zaprimljeno'),
(9, 3, '2026-04-20', 'Zaprimljeno'),
(10, 1, '2026-04-22', 'Zaprimljeno');


INSERT INTO stavka_nabave (nabava_id, proizvod_id, kolicina, nabavna_cijena) VALUES
(1, 1, 100, 2.00),
(1, 2, 80, 2.50),
(1, 3, 60, 3.83),
(2, 6, 90, 2.00),
(2, 7, 70, 2.50),
(2, 8, 70, 2.10),
(3, 10, 110, 2.10),
(3, 11, 85, 2.40),
(3, 12, 75, 5.48),
(4, 14, 95, 2.50),
(4, 15, 65, 3.00),
(4, 16, 55, 8.50),
(5, 18, 100, 2.00),
(5, 19, 80, 2.20),
(5, 20, 80, 3.90),
(6, 22, 120, 2.20),
(6, 23, 90, 2.50),
(6, 24, 75, 6.17),
(7, 25, 110, 2.10),
(7, 26, 85, 2.60),
(7, 27, 70, 5.21),
(8, 28, 100, 2.50),
(8, 29, 80, 3.00),
(8, 30, 90, 3.78),
(9, 28, 90, 2.00),
(9, 29, 70, 2.50),
(9, 30, 90, 3.17),
(10, 1, 100, 2.50),
(10, 2, 80, 3.00),
(10, 3, 85, 6.00);


INSERT INTO recenzija (kupac_id, proizvod_id, ocjena, komentar, datum_recenzije) VALUES
(1, 1, 5, 'Odlična čokolada, lješnjaci su krupni i fino pečeni.', '2026-05-11 10:00:00'),
(1, 2, 4, 'Jako ukusno, malo slađe nego što sam očekivao.', '2026-05-11 10:05:00'),
(2, 4, 5, 'Savršeni bademi, tekstura je vrhunska i kremasta.', '2026-05-13 11:15:00'),
(3, 1, 5, 'Najbolja mliječna čokolada na tržištu, kupujem opet.', '2026-05-16 09:30:00'),
(5, 12, 3, 'Rum se previše osjeti, ali sama čokolada je u redu.', '2026-05-21 14:22:00'),
(6, 2, 5, 'Savršena voćna nota, malina daje odličnu kiselost.', '2026-05-23 15:00:00'),
(8, 1, 4, 'Klasičan dobar okus, standardna kvaliteta.', '2026-05-24 09:00:00'),
(9, 8, 5, 'Chili se osjeti taman koliko treba na kraju.', '2026-05-24 10:15:00'),
(10, 6, 5, 'Pravi izbor za ljubitelje tamne i gorke čokolade.', '2026-05-24 10:45:00'),
(11, 3, 4, 'Dobra kombinacija soli i karamele, hrskavo.', '2026-05-24 11:00:00'),
(12, 10, 2, 'Menta mi nikako ne odgovara u ovoj kombinaciji.', '2026-05-24 11:10:00'),
(13, 3, 5, 'Karamela je fantastična, slanoća pogađa balans.', '2026-05-24 11:20:00'),
(14, 15, 5, 'Kutija uživo izgleda prekrasno, odličan poklon.', '2026-05-24 11:35:00'),
(16, 14, 4, 'Fini mekani tartufi, bogat okus pravog kakaa.', '2026-05-24 11:50:00'),
(17, 13, 5, 'Nugat krema je nevjerojatno glatka, preporuka.', '2026-05-24 12:10:00'),
(18, 15, 4, 'Premium pakiranje i brza dostava, čokolade ukusne.', '2026-05-24 12:30:00'),
(19, 11, 3, 'Malo previše slatko za moj ukus, ali tekstura je OK.', '2026-05-24 12:45:00'),
(20, 18, 5, 'Prava tradicionalna griotta, višnja je sočna.', '2026-05-24 13:15:00'),
(21, 16, 5, 'Odličan blagdanski mix, djeca su oduševljena.', '2026-05-24 13:30:00'),
(22, 2, 4, 'Dobra čokolada, komadići maline su svježi.', '2026-05-24 14:00:00'),
(23, 16, 4, 'Uskrsna košarica je bogata, isplati se kupiti.', '2026-05-24 14:15:00'),
(24, 19, 3, 'Zanimljiv okus figure, ali nije za svaki dan.', '2026-05-24 14:45:00'),
(25, 12, 4, 'Kvalitetan rum i jak okus.', '2026-05-24 15:00:00'),
(26, 1, 5, 'Moja omiljena čokolada s lješnjacima, bez greške.', '2026-05-24 15:20:00'),
(27, 16, 5, 'Božićni začini se osjete u cijeloj kući, predivno.', '2026-05-24 15:40:00'),
(28, 10, 1, 'Čokolada je stigla otopljena, jako loše iskustvo.', '2026-05-24 15:55:00'),
(29, 3, 5, 'Najbolji omjer cijene i kvalitete za slani karamel.', '2026-05-24 16:15:00'),
(30, 17, 5, 'Degustacijski set je vrhunski vođen kroz okuse.', '2026-05-24 16:45:00'),
(15, 5, 4, 'Kokos daje odličnu teksturu mliječnoj bazi.', '2026-05-24 17:00:00'),
(4, 17, 5, 'Poklon paket je pun pogodak za rođendan.', '2026-05-24 17:15:00');


-- Luka Wrana - 3 pogleda --

CREATE OR REPLACE VIEW prihod_po_proizvodu AS
SELECT 
    p.proizvod_id,
    p.naziv,
    COUNT(DISTINCT sn.narudzba_id) AS broj_narudzbi,
    SUM(sn.kolicina) AS ukupno_prodano,
    SUM(sn.kolicina * sn.cijena_po_komadu) AS ukupni_prihod
FROM proizvod p
JOIN stavka_narudzbe sn 
    ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n 
    ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM prihod_po_proizvodu
ORDER BY ukupni_prihod DESC;


CREATE OR REPLACE VIEW proizvodi_po_kolicini AS
SELECT 
    p.proizvod_id,
    p.naziv,
    COUNT(DISTINCT sn.narudzba_id) AS broj_narudzbi,
    SUM(sn.kolicina) AS ukupna_kolicina
FROM proizvod p
JOIN stavka_narudzbe sn 
    ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n 
    ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM proizvodi_po_kolicini
ORDER BY ukupna_kolicina DESC;


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
JOIN stavka_narudzbe sn 
    ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n 
    ON n.narudzba_id = sn.narudzba_id
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
    n.status_narudzbe,
    n.ukupan_iznos,
    a.grad,
    a.ulica
FROM narudzba n
JOIN kupac k ON n.kupac_id = k.kupac_id
JOIN adresa a ON n.adresa_id = a.adresa_id;

-- Pogled 4: Stavke narudžbi
CREATE VIEW AP_Pogled_stavke_narudzbe AS
SELECT 
    sn.stavka_narudzbe_id,
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
    n.status_narudzbe AS status_narudzbe
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
INNER JOIN kupac k ON r.kupac_id = k.kupac_id;

-- uz dodavanje uvjeta lako se izaberu recenzije sa odredjenom ocjenom
-- WHERE r.ocjena = 1; 

-- Pozivanje pogleda uz sortiranje po ocjenama uzlazno

SELECT * 
FROM v_javne_recenzije_proizvoda 
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
VALUES ('', 'Korisnik', 'krivi_email_bez_znaka', 'lozinka123', '0919999999', 1);

INSERT INTO kupac (ime, prezime, email, lozinka, telefon, aktivan) 
VALUES ('', 'Korisnik', 'ispravan.email@gmail.com', 'lozinka123', '0919999999', 1);

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


