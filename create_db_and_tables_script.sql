CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE kupac (
    kupac_id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    lozinka VARCHAR(255) NOT NULL,
    telefon VARCHAR(20),
    datum_registracije DATE DEFAULT (CURRENT_DATE), /* Verzija MySQL Workbench 8.0.46 zahtjeva zagradu (CURRENT_DATE) */
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
