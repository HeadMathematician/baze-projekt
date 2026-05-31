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

CREATE OR REPLACE VIEW v_prihod_po_proizvodu AS
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
FROM v_prihod_po_proizvodu
ORDER BY ukupni_prihod DESC;


CREATE OR REPLACE VIEW v_proizvodi_po_kolicini AS
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
FROM v_proizvodi_po_kolicini
ORDER BY ukupna_kolicina DESC;


CREATE OR REPLACE VIEW v_koeficijent_kolicine_po_proizvodu AS
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
FROM v_koeficijent_kolicine_po_proizvodu
ORDER BY prosjecna_kolicina_po_narudzbi DESC;


-- Danijel Margić - 5 upita i 2 pogled --

-- Upit 1 -- 
SELECT 
    p.proizvod_id AS Sifra_proizvoda,
    p.naziv AS Naziv_cokolade,
    p.cijena AS Cijena_u_eurima,
    p.kolicina_na_skladistu AS Stanje_zaliha,
    CASE 
        WHEN p.kolicina_na_skladistu > 40 THEN 'Sigurna zaliha'
        ELSE 'Niska zaliha'
    END AS Status_zaliha
FROM proizvod AS p
WHERE p.aktivan = TRUE 
  AND p.kategorija_id = 1
  AND p.kolicina_na_skladistu > 0
  AND (p.naziv LIKE '%tamna%' OR p.naziv LIKE '%dark%')
ORDER BY p.cijena DESC;


-- Pogled 1 -- 
CREATE OR REPLACE VIEW v_analiza_uspjesnosti_kategorija AS
SELECT 
    k.kategorija_id AS Sifra_kategorije,
    k.naziv AS Naziv_kategorije,
    COUNT(DISTINCT sn.narudzba_id) AS Ukupno_narudzbi,
    SUM(sn.kolicina) AS Ukupno_prodanih_komada,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Ukupna_zarada_EUR
FROM kategorija AS k
INNER JOIN proizvod AS p ON k.kategorija_id = p.kategorija_id
INNER JOIN stavka_narudzbe AS sn ON p.proizvod_id = sn.proizvod_id
GROUP BY k.kategorija_id, k.naziv
ORDER BY Ukupna_zarada_EUR DESC;

SELECT * FROM v_analiza_uspjesnosti_kategorija;

SELECT * 
FROM v_analiza_uspjesnosti_kategorija
WHERE Ukupna_zarada_EUR > 500.00;

SELECT * 
FROM v_analiza_uspjesnosti_kategorija
WHERE Naziv_kategorije = 'Tamna čokolada';


-- Pogled 2 -- 
CREATE OR REPLACE VIEW v_analiza_tereta_dostave AS
SELECT 
    n.narudzba_id AS Sifra_narudzbe,
    CONCAT(k.ime, ' ', k.prezime) AS Kupac,
    n.cijena_dostave AS Cijena_dostave_EUR,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Vrijednost_robe_EUR,
    CASE 
        WHEN n.cijena_dostave = 0 THEN 'Besplatna dostava'
        WHEN (n.cijena_dostave / SUM(sn.kolicina * sn.cijena_po_komadu)) * 100 > 15.0 THEN 'Kritican trosak (iznad 15%)'
        ELSE 'Optimalan trosak'
    END AS Indeks_tereta_dostave
FROM narudzba AS n
INNER JOIN kupac AS k ON n.kupac_id = k.kupac_id
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY n.narudzba_id, k.ime, k.prezime, n.cijena_dostave
ORDER BY Vrijednost_robe_EUR DESC;

SELECT * FROM v_analiza_tereta_dostave;

-- Upit 2 -- 
SELECT 
    p.proizvod_id AS Sifra_proizvoda,
    p.naziv AS Naziv_cokolade,
    p.kolicina_na_skladistu AS Kolicina_zaliha,
    p.cijena AS Cijena_po_komadu,
    ROUND((p.kolicina_na_skladistu * p.cijena), 2) AS Vrijednost_zarobljenog_kapitala
FROM proizvod AS p
WHERE p.aktivan = TRUE
GROUP BY p.proizvod_id, p.naziv, p.kolicina_na_skladistu, p.cijena
HAVING Vrijednost_zarobljenog_kapitala > (
    SELECT AVG(izvedeno_stanje.vrijednost_artikla)
    FROM (
        SELECT (p2.kolicina_na_skladistu * p2.cijena) AS vrijednost_artikla
        FROM proizvod AS p2
        WHERE p2.aktivan = TRUE
    ) AS izvedeno_stanje
)
ORDER BY Vrijednost_zarobljenog_kapitala DESC;


-- Upit 2 --
SELECT 
    DAYNAME(n.datum_narudzbe) AS Dan_u_tjednu,
    COUNT(DISTINCT n.narudzba_id) AS Ukupan_broj_narudzbi,
    SUM(sn.kolicina) AS Ukupno_prodanih_komada,
    ROUND(AVG(sn.kolicina * sn.cijena_po_komadu), 2) AS Prosjecna_vrijednost_stavke_EUR
FROM narudzba AS n
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY DAYNAME(n.datum_narudzbe), WEEKDAY(n.datum_narudzbe)
ORDER BY WEEKDAY(n.datum_narudzbe) ASC;


-- Upit 4 -- 
SELECT 
    d.status_dostave AS Status_isporuke,
    COUNT(d.dostava_id) AS Broj_evidentiranih_paketa,
    ROUND(AVG(n.cijena_dostave), 2) AS Prosjecna_cijena_dostave_EUR
FROM dostava AS d
JOIN narudzba AS n ON d.narudzba_id = n.narudzba_id
GROUP BY d.status_dostave
HAVING AVG(n.cijena_dostave) > (
    SELECT AVG(izvedena_statistika.prosjek_statusa)
    FROM (
        SELECT AVG(n2.cijena_dostave) AS prosjek_statusa
        FROM dostava AS d2
        JOIN narudzba AS n2 ON d2.narudzba_id = n2.narudzba_id
        GROUP BY d2.status_dostave
    ) AS izvedena_statistika
)
ORDER BY Prosjecna_cijena_dostave_EUR DESC;


-- Upit 5 --
SELECT 
    n.narudzba_id AS Sifra_narudzbe,
    n.datum_narudzbe AS Datum_transakcije,
    SUM(sn.kolicina) AS Ukupno_komada_u_kosarici,
    MIN(sn.cijena_po_komadu) AS Najjeftinija_stavka_narudzbe,
    MAX(sn.cijena_po_komadu) AS Najskuplja_stavka_narudzbe
FROM narudzba AS n
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY n.narudzba_id, n.datum_narudzbe
HAVING SUM(sn.kolicina) > 5
ORDER BY n.datum_narudzbe DESC;


-- Andrej Pucović - 4 upita i 2 pogleda --

-- Upit 1 -- 
SELECT 
    n.narudzba_id AS Sifra_narudzbe,
    n.datum_narudzbe AS Datum_kupnje,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Ukupna_vrijednost_narudzbe
FROM narudzba AS n
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= NOW() - INTERVAL 6 MONTH
GROUP BY n.narudzba_id, n.datum_narudzbe
ORDER BY Ukupna_vrijednost_narudzbe DESC
LIMIT 3;


-- Upit 2 -- 
SELECT 
    k.kupac_id AS Sifra_kupca,
    CONCAT(k.ime, ' ', k.prezime) AS Kupac,
    COUNT(r.recenzija_id) AS Broj_recenzija,
    ROUND(AVG(r.ocjena), 2) AS Prosjecna_ocjena
FROM recenzija AS r
RIGHT JOIN kupac AS k ON r.kupac_id = k.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime
ORDER BY Prosjecna_ocjena DESC;


-- Upit 3 -- 
SELECT 
    k.kategorija_id AS Sifra_kategorije,
    k.naziv AS Naziv_kategorije,
    MIN(p.cijena) AS Najniza_cijena_kategorije,
    MAX(p.cijena) AS Najvisa_cijena_kategorije
FROM kategorija AS k
LEFT JOIN proizvod AS p ON k.kategorija_id = p.kategorija_id
GROUP BY k.kategorija_id, k.naziv
ORDER BY Najvisa_cijena_kategorije DESC;


-- Upit 4 --
SELECT 
    p.proizvod_id AS Sifra_proizvoda,
    p.naziv AS Naziv_premium_cokolade,
    COUNT(sn.narudzba_id) AS Broj_pojavljivanja_u_narudzbama,
    SUM(sn.kolicina) AS Ukupna_prodana_kolicina_komadi,
    ROUND(AVG(sn.kolicina), 1) AS Prosjecna_kolicina_po_stavki
FROM proizvod AS p
INNER JOIN stavka_narudzbe AS sn ON p.proizvod_id = sn.proizvod_id
WHERE p.cijena > 4.00 AND p.aktivan = TRUE
GROUP BY p.proizvod_id, p.naziv
ORDER BY Ukupna_prodana_kolicina_komadi DESC;


-- Pogled 1 -- 
CREATE OR REPLACE VIEW v_premium_proizvodi_i_potraznja AS
SELECT 
    p.proizvod_id AS Sifra_proizvoda,
    p.naziv AS Naziv_premium_cokolade,
    p.cijena AS Cijena_u_eurima,
    SUM(sn.kolicina) AS Ukupno_prodano_komada
FROM proizvod AS p
LEFT JOIN stavka_narudzbe AS sn ON p.proizvod_id = sn.proizvod_id
WHERE p.cijena > (
    SELECT AVG(p2.cijena) 
    FROM proizvod AS p2
)
GROUP BY p.proizvod_id, p.naziv, p.cijena
ORDER BY p.cijena DESC;

SELECT * FROM v_premium_proizvodi_i_potraznja;

SELECT * 
FROM v_premium_proizvodi_i_potraznja
WHERE Ukupno_prodano_komada IS NOT NULL;

SELECT * 
FROM v_premium_proizvodi_i_potraznja
WHERE Cijena_u_eurima > 10.00;


-- Pogled 2 -- 
CREATE OR REPLACE VIEW v_usporedba_proizvoda_i_kategorija AS
SELECT 
    p.proizvod_id AS Sifra_proizvoda,
    p.naziv AS Naziv_proizvoda,
    k.naziv AS Naziv_kategorije,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Zarada_proizvoda_EUR,
    ROUND((
        SELECT SUM(sn2.kolicina * sn2.cijena_po_komadu)
        FROM proizvod AS p2
        INNER JOIN stavka_narudzbe AS sn2 ON p2.proizvod_id = sn2.proizvod_id
        WHERE p2.kategorija_id = p.kategorija_id
    ), 2) AS Ukupna_zarada_kategorije_EUR
FROM proizvod AS p
INNER JOIN kategorija AS k ON p.kategorija_id = k.kategorija_id
INNER JOIN stavka_narudzbe AS sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.naziv, k.naziv, p.kategorija_id;

SELECT * FROM v_usporedba_proizvoda_i_kategorija;

SELECT * 
FROM v_usporedba_proizvoda_i_kategorija
WHERE Zarada_proizvoda_EUR > 50.00;

SELECT * 
FROM v_usporedba_proizvoda_i_kategorija
WHERE Naziv_kategorije = 'Mliječna čokolada';


-- Teo Kupčinovac - 2 pogleda --

-- Pogled 1 -- 
CREATE OR REPLACE VIEW v_pregled_vrijednosti_narudzbi AS
SELECT 
    n.narudzba_id AS Sifra_narudzbe,
    n.datum_narudzbe AS Datum_kreiranja,
    CONCAT(k.ime, ' ', k.prezime) AS Kupac,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Ukupna_vrijednost_EUR
FROM narudzba AS n
INNER JOIN kupac AS k ON n.kupac_id = k.kupac_id
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY n.narudzba_id, n.datum_narudzbe, k.ime, k.prezime;

SELECT * FROM v_pregled_vrijednosti_narudzbi;

SELECT * 
FROM v_pregled_vrijednosti_narudzbi
WHERE Ukupna_vrijednost_EUR > 100.00;

SELECT * 
FROM v_pregled_vrijednosti_narudzbi
WHERE Kupac LIKE '%Kovač%';


-- Pogled 2 -- 
CREATE OR REPLACE VIEW v_crm_segmentacija_kupaca AS
SELECT 
    k.kupac_id AS Sifra_kupca,
    CONCAT(k.ime, ' ', k.prezime) AS Kupac,
    COUNT(DISTINCT n.narudzba_id) AS Ukupno_narudzbi,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Ukupna_potrosnja_EUR,
    MAX(n.datum_narudzbe) AS Datum_zadnje_kupnje,
    CASE 
        WHEN SUM(sn.kolicina * sn.cijena_po_komadu) > 100.00 THEN 'VIP Kupac'
        WHEN SUM(sn.kolicina * sn.cijena_po_komadu) BETWEEN 40.00 AND 100.00 THEN 'Lojalan Kupac'
        ELSE 'Standardni Kupac'
    END AS Segment_kupca
FROM kupac AS k
INNER JOIN narudzba AS n ON k.kupac_id = n.kupac_id
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY k.kupac_id, k.ime, k.prezime;

SELECT * FROM v_crm_segmentacija_kupaca;

SELECT * 
FROM v_crm_segmentacija_kupaca
WHERE Segment_kupca = 'VIP Kupac';

SELECT * 
FROM v_crm_segmentacija_kupaca
ORDER BY Datum_zadnje_kupnje DESC;


-- Luka Juroš - 1 upita i 1 pogled --

-- Upit 1 -- 
SELECT 
    d.dobavljac_id AS Sifra_dobavljaca,
    d.naziv AS Naziv_dobavljaca,
    COUNT(DISTINCT snab.proizvod_id) AS Broj_razlicitih_artikala,
    MIN(snab.nabavna_cijena) AS Minimalna_nabavna_cijena,
    MAX(snab.nabavna_cijena) AS Maksimalna_nabavna_cijena
FROM dobavljac AS d
LEFT JOIN nabava AS n ON d.dobavljac_id = n.dobavljac_id
LEFT JOIN stavka_nabave AS snab ON n.nabava_id = snab.nabava_id
GROUP BY d.dobavljac_id, d.naziv
ORDER BY Maksimalna_nabavna_cijena DESC, Broj_razlicitih_artikala DESC;


-- Pogled 1 -- 
CREATE OR REPLACE VIEW v_pregled_potrosnje_kupaca AS
SELECT 
    k.kupac_id AS Sifra_kupca,
    CONCAT(k.ime, ' ', k.prezime) AS Kupac,
    COUNT(DISTINCT n.narudzba_id) AS Ukupno_narudzbi,
    ROUND(SUM(sn.kolicina * sn.cijena_po_komadu), 2) AS Ukupna_potrosnja_EUR
FROM kupac AS k
INNER JOIN narudzba AS n ON k.kupac_id = n.kupac_id
INNER JOIN stavka_narudzbe AS sn ON n.narudzba_id = sn.narudzba_id
GROUP BY k.kupac_id, k.ime, k.prezime
ORDER BY Ukupna_potrosnja_EUR DESC;

SELECT * FROM v_pregled_potrosnje_kupaca;

SELECT * 
FROM v_pregled_potrosnje_kupaca
WHERE Ukupna_potrosnja_EUR > 150.00;

SELECT * 
FROM v_pregled_potrosnje_kupaca
WHERE Kupac LIKE '%Kovač%';

