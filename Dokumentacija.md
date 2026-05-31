#### Sveučilište Jurja Dobrile u Puli Zagrebačka 30, 52100 Pula, Hrvatska

# BP1 Projekt - E-commerce trgovinu za prodaju čokolade

## Tim-1

### 1. godina prijediplomskog sveučilišnog studija informatike

- **Luka Juroš** (JMBAG: )
- **Teo Kupčinovac** (JMBAG: 1311029868)
- **Luka Wrana** (JMBAG: )
- **Andrej Pucković** (JMBAG: )
- **Danijel Margić** (JMBAG: )

&nbsp;

## 1. Uvod (Luka Juroš)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

## 2. Opis projekta (Luka Juroš)

- Podjela projekta (napravi sarzaj)
- Što je naša tema i objasniti koncept projekta
- Za što se ova baza koristi i kakofuncionira
- Features baze

&nbsp;

## 3. Konceptualini dizajn (Luka Juroš)

#### 3.1 Definiranje poslovnog procesa (ER + EER Dijagram)

- objasniti strukturu
- zašto se koriste ER i EER? Što su? Kako funcioniraju? Kako se rade?

&nbsp;

### 3.2 Entity Relationship (ER) dijagram

opis - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

![Slika 1: ER dijagram](ER_dijagram.png)

### 3.3 Enhanced Entity–Relationship (EER) dijagram (MySQL Workbench)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

![Slika 2: EER dijagram](EER_dijagram.png)

&nbsp;

## 4. Relacije (Teo Kupčinovac)

Nakon izrade konceptualnog i logičkog modela baze podataka slijedi implementacija relacija u MySQL sustavu. Relacije predstavljaju tablice u kojima se pohranjuju podaci o određenim entitetima poslovnog procesa. Svaka relacija sastoji se od atributa definiranih odgovarajućim tipovima podataka i ograničenjima. Prilikom izrade relacija korišten je SQL jezik i naredba `CREATE TABLE`. Svaka tablica definira vlastite atribute, primarne ključeve (`PRIMARY KEY`) i strane ključeve (`FOREIGN KEY`) koji omogućuju povezivanje podataka između različitih relacija. Primarni ključ služi za jedinstvenu identifikaciju svakog zapisa unutar tablice, dok strani ključ omogućuje povezivanje tablica i održavanje referencijalnog integriteta podataka. Osim toga, korištena su i dodatna ograničenja poput:

- `NOT NULL` – atribut mora sadržavati vrijednost
- `UNIQUE` – vrijednosti atributa moraju biti jedinstvene
- `DEFAULT` – definira zadanu vrijednost atributa
- `CHECK` – ograničava dozvoljene vrijednosti atributa
- `AUTO_INCREMENT` – automatski povećava vrijednost primarnog ključa
- `ON DELETE CASCADE` – automatski briše povezane zapise

&nbsp;

### 4.1 Relacija _kupac_

Prati osnovne podatke o kupcima u sustavu. Relacija **kupac** se sastoji od sljedećih atributa:

- **kupac_id** – podatak tipa `INT`, koji je primarni ključ unutar relacije. Automatski se povećava (`AUTO_INCREMENT`), što znači da svaki novi kupac dobiva jedinstveni identifikator.

- **ime** – podatak tipa `VARCHAR` ograničen na 50 znakova. Ograničen je s `NOT NULL`, što znači da vrijednost mora biti unesena.

- **prezime** – podatak tipa `VARCHAR` ograničen na 50 znakova. Također ima ograničenje `NOT NULL`.

- **email** – podatak tipa `VARCHAR` ograničen na 100 znakova. Ima ograničenja `NOT NULL` i `UNIQUE`, što znači da svaki kupac mora imati email i da ne mogu postojati dva kupca s istom email adresom.

- **lozinka** – podatak tipa `VARCHAR` ograničen na 255 znakova. Ograničen je s `NOT NULL` (vrijednost je obavezna; tipično se sprema hash lozinke, ne sama lozinka).

- **telefon** – podatak tipa `VARCHAR` ograničen na 20 znakova. Nema `NOT NULL` ograničenje, što znači da je unos opcionalan.

- **datum_registracije** – podatak tipa `DATE`. Predstavlja datum registracije kupca i također je opcionalan (može biti `NULL` ako nije zadano).

- **aktivan** – podatak tipa `BOOLEAN`. Ima zadanu vrijednost (`DEFAULT TRUE`), što znači da će novi kupac automatski biti označen kao aktivan ako se ne navede drugačije.

Ograničenje `NOT NULL` označava da atribut mora imati vrijednost, dok `UNIQUE` osigurava jedinstvenost podataka unutar tog atributa.

```sql
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

```

&nbsp;

### 4.2 Relacija _adresa_

Kupac može imati više adresa za dostavu, primjerice kućnu i poslovnu. Primarni ključ je **adresa_id** koji se automatski povećava. **kupac_id** je strani ključ prema tablici _kupac_, s `ON DELETE CASCADE`, dakle brisanjem kupca automatski se brišu i sve njegove adrese. **ulica**, **grad** i **postanski_broj** su obavezni atributi tipa `VARCHAR`. Zanimljivo je da **postanski_broj** nije `INT` nego `VARCHAR`, zato jer neki poštanski brojevi počinju nulom. **drzava** ima zadanu vrijednost `'Hrvatska'` pa ju nije potrebno ručno unositi za svaki zapis. **glavna_adresa** je `BOOLEAN` koji označava je li ta adresa primarna za dostavu. Kupac može imati više adresa, ali samo jedna može biti glavna.

```sql
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
```

&nbsp;

### 4.3 Relacija _dobavljac_

Pohranjuje kontaktne podatke tvrtki od kojih nabavljamo sirovine i gotove proizvode. **dobavljac_id** je primarni ključ s `AUTO_INCREMENT`. **naziv** je obavezan, dok su **kontakt_osoba**, **telefon** i **adresa** opcionalni jer ne mora svaka tvrtka imati specificiranog kontakta. **email** je obavezan i jedinstven (`NOT NULL` i `UNIQUE`). Ne mogu postojati dva dobavljača s istom email adresom.

```sql
CREATE TABLE dobavljac (
    dobavljac_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(150) NOT NULL,
    kontakt_osoba VARCHAR(100),
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(20),
    adresa VARCHAR(200)
);
```

&nbsp;

### 4.4 Relacija _kategorija_

Grupira proizvode u logične cjeline kako bi pretraživanje u webshop-u bilo jednostavnije. Posebno je zanimljiv atribut **nadkategorija_id** strani ključ koji pokazuje na samu tablicu _kategorija_, tzv. samoreferencijalni odnos. Njime se postiže hijerarhija kategorija, primjerice "Mliječna čokolada" može biti podkategorija od "Čokolade". Ako je `NULL`, ta je kategorija na najvišoj razini. **naziv** je obavezan, **opis** je opcionalan.

```sql
CREATE TABLE kategorija (
    kategorija_id INT AUTO_INCREMENT PRIMARY KEY,
    nadkategorija_id INT,
    naziv VARCHAR(100) NOT NULL,
    opis TEXT,
    FOREIGN KEY (nadkategorija_id) REFERENCES kategorija(kategorija_id)
);
```

&nbsp;

### 4.5 Relacija _proizvod_

Srž cijelog kataloga, svaki artikl koji prodajemo ima ovdje svoj zapis. **kategorija_id** je strani ključ koji ga smješta u odgovarajuću kategoriju. **cijena** je tipa `DECIMAL(10,2)` umjesto `FLOAT` jer se radi o novcu i bitna je preciznost na dvije decimale. **SKU** (Stock Keeping Unit) je interna šifra proizvoda koja mora biti jedinstvena (`UNIQUE`). **aktivan** je `BOOLEAN` koji omogućuje tkzv. meko brisanje, kad povučemo proizvod iz prodaje, ne brišemo ga iz baze nego ga samo označimo kao neaktivnog, čime čuvamo povijest. **datum_dodavanja** se automatski popunjava s `CURRENT_TIMESTAMP` pri unosu.

```sql
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
```

&nbsp;

### 4.6 Relacija _narudzba_

Bilježi svaku kupovinu u webshop-u. Sadrži strane ključeve prema **kupac** i **adresa**. Pri naručivanju kupac odabire na koju od svojih adresa šalje paket. **datum_narudzbe** bilježi točan trenutak kreiranja narudžbe, **status** prati fazu obrade (npr. "U obradi", "Poslano", "Završena"), a **ukupan_iznos** tipa `DECIMAL(12,2)` predstavlja ukupnu vrijednost svih stavki te narudžbe.

```sql
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
```

&nbsp;

### 4.7 Relacija _stavka_narudzbe_

Budući da jedna narudžba može sadržavati više različitih proizvoda, svaki redak u košarici postaje zasebna stavka. **narudzba_id** i **proizvod_id** su strani ključevi koji je vežu uz narudžbu i konkretni proizvod. **kolicina** je obavezna. **cijena_po_komadu** sprema se u trenutku narudžbe, a ne uzima se direktno iz tablice _proizvod_, to je namjerno, jer bi inače naknadna promjena cijene utjecala i na stare narudžbe. **ukupna_cijena** je umnožak količine i cijene po komadu.

```sql
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
```

&nbsp;

### 4.8 Relacija _placanje_

Bilježi detalje transakcije za svaku narudžbu. **narudzba_id** je strani ključ prema narudžbi. **nacin_placanja** opisuje kako je kupac platio (npr. "Kartica", "PayPal", "Pouzećem"), **status_placanja** prati je li plaćanje uspješno, a **datum_placanja** bilježi točan trenutak kad je transakcija izvršena.

```sql
CREATE TABLE placanje (
    placanje_id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT,
    nacin_placanja VARCHAR(50),
    iznos DECIMAL(12,2),
    status_placanja VARCHAR(50),
    datum_placanja DATETIME,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(narudzba_id)
);
```

&nbsp;

### 4.9 Relacija _dostava_

Nakon što je narudžba plaćena, paket se predaje kurirskoj službi. **narudzba_id** veže dostavu uz narudžbu. **kurirska_sluzba** i **broj_posiljke** (tracking broj) daju kupcu mogućnost praćenja paketa. **procijenjeni_datum** i **stvarni_datum** su oba tipa `DATE`, uspoređivanjem tih dvaju polja možemo pratiti koliko kurirske službe kasne ili jesu li paket dostavile ranije nego što je planirano.

```sql
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
```

&nbsp;

### 4.10 Relacija _nabava_

Dok prethodne tablice prate prodaju prema kupcima, ova tablica pokriva drugu stranu, tj. kupovinu robe od dobavljača. **dobavljac_id** je strani ključ koji pokazuje od koga je roba naručena. **datum_nabave**, **status** i **ukupan_iznos** prate tijek i vrijednost cijele nabave.

```sql
CREATE TABLE nabava (
    nabava_id INT AUTO_INCREMENT PRIMARY KEY,
    dobavljac_id INT,
    datum_nabave DATETIME,
    status VARCHAR(50),
    ukupan_iznos DECIMAL(12,2),
    FOREIGN KEY (dobavljac_id) REFERENCES dobavljac(dobavljac_id)
);
```

&nbsp;

### 4.11 Relacija _stavka_nabave_

Analogno stavkama narudžbe, ova tablica detaljizira što je točno nabavljeno u sklopu jedne nabave. **nabava_id** je strani ključ s `ON DELETE CASCADE`, tj. brisanjem nabave automatski se brišu i sve njene stavke. **proizvod_id** pokazuje koji je artikl nabavljen, **kolicina** koliko komada, a **nabavna_cijena** je cijena po komadu od dobavljača, koja se razlikuje od prodajne cijene.

```sql
CREATE TABLE stavka_nabave (
    stavka_nabave_id INT AUTO_INCREMENT PRIMARY KEY,
    nabava_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    nabavna_cijena DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (nabava_id) REFERENCES nabava(nabava_id) ON DELETE CASCADE,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(proizvod_id)
);
```

&nbsp;

### 4.12 Relacija _recenzija_

Kupci mogu ocjenjivati proizvode koje su kupili. **kupac_id** i **proizvod_id** su strani ključevi definirani s `ON DELETE CASCADE`. **ocjena** je tipa `TINYINT` s ograničenjem `CHECK (ocjena BETWEEN 1 AND 5)`, dakle baza ne prihvaća vrijednosti izvan tog raspona. **komentar** je opcionalan tekst, a **datum_recenzije** se automatski popunjava. Posebno je vrijedno naglasiti složeno ograničenje `UNIQUE (kupac_id, proizvod_id)` koje sprječava da isti kupac ostavi više od jedne recenzije za isti proizvod.

```sql
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
```

&nbsp;

## 5. Popuna podacima (Luka Wrana)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 5.1 Popuna relacije _kategorija_

Popuna podataka u relaciji **kategorija** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. U ovom primjeru unosi se početni skup kategorija proizvoda.

- **kategorija_id** se unosi ručno i predstavlja jedinstveni identifikator svake kategorije. Vrijednosti moraju biti jedinstvene.

- **naziv** predstavlja naziv kategorije te mora biti jedinstven i smislen kako bi jasno opisivao grupu proizvoda.

- **opis** daje dodatno objašnjenje kategorije i služi za detaljniji opis sadržaja unutar svake kategorije.

U prikazanom primjeru uneseno je 6 kategorija:

- **Tamna čokolada** – kategorija proizvoda s visokim udjelom kakaa
- **Mliječna čokolada** – kremaste čokolade s dodatkom mlijeka
- **Bijela čokolada** – slatke čokolade bez kakaa
- **Praline** – ručno izrađeni proizvodi punjeni kremama i likerima
- **Posebne ponude** – sezonski i ograničeni proizvodi
- **Čokoladne figure** – dekorativni proizvodi od čokolade

```sql
INSERT INTO kategorija (kategorija_id, naziv, opis) VALUES
(1, 'Tamna čokolada', 'Premium tamne čokolade visokog udjela kakaa'),
(2, 'Mliječna čokolada', 'Kremaste mliječne čokolade s raznim okusima'),
(3, 'Bijela čokolada', 'Slatke bijele čokolade i kombinacije'),
(4, 'Praline', 'Ručno rađene praline punjene kremama i likerima'),
(5, 'Posebne ponude', 'Sezonske i limitirane kolekcije'),
(6, 'Čokoladne figure', 'Dekorativne figure od čokolade');
```

&nbsp;

### 5.2 Popuna relacije _dobavljac_

Popuna podataka u relaciji **dobavljac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži informacije o dobavljačima čokolade i sirovina.

- **dobavljac_id** se unosi ručno i predstavlja jedinstveni identifikator svakog dobavljača.

- **naziv** predstavlja ime tvrtke dobavljača.

- **kontakt_osoba** označava osobu za kontakt unutar tvrtke.

- **email** i **telefon** služe za komunikaciju s dobavljačem.

- **adresa** predstavlja lokaciju dobavljača.

U prikazanom primjeru unesena su 3 dobavljača iz različitih država.

```sql
INSERT INTO dobavljac (dobavljac_id, naziv, kontakt_osoba, email, telefon, adresa) VALUES
(1, 'Cocoa Imports Europe', 'Marko Jurić', 'info@cocoa-eu.com', '01 555 111', 'Zagreb, Hrvatska'),
(2, 'Belgian Chocolate Supply', 'Anna De Vries', 'sales@belgianchoco.be', '+32 555 222', 'Brussels, Belgium'),
(3, 'Organic Cacao Farm', 'Luis Hernandez', 'contact@organiccacao.com', '+57 300 111', 'Medellin, Colombia');
```

&nbsp;

### 5.3 Popuna relacije _kupac_

Popuna podataka u relaciji **kupac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži osnovne informacije o kupcima.

- **kupac_id** se unosi ručno i predstavlja jedinstveni identifikator svakog kupca.

- **ime** i **prezime** predstavljaju osobne podatke kupca.

- **email** mora biti jedinstven jer se koristi za prijavu u sustav.

- **lozinka** predstavlja korisničku lozinku.

- **telefon** služi za kontakt s kupcem.

U prikazanom primjeru uneseno je 10 kupaca:

```sql
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
```

&nbsp;

### 5.4 Popuna relacije _adresa_

```sql
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

```

&nbsp;

### 5.5 Popuna relacije _proizvod_

```sql

```

&nbsp;

### 5.6 Procedura za automatsko generiranje narudzba

```sql
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
```

&nbsp;

### 5.7 Popuna relacije _placanje_

```sql
INSERT INTO placanje (narudzba_id, nacin_placanja, iznos, status_placanja, datum_placanja)
SELECT
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal'),
    ukupan_iznos,
    'Plaćeno',
    datum_narudzbe + INTERVAL FLOOR(RAND()*2) DAY
FROM narudzba;
```

&nbsp;

### 5.9 Popuna relacije _dostava_

```sql
INSERT INTO dostava (narudzba_id, kurirska_sluzba, broj_posiljke, status_dostave, procijenjeni_datum, stvarni_datum)
SELECT
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'DHL', 'GLS', 'HP'),
    CONCAT('HR', FLOOR(100000 + RAND()*900000)),
    'Dostavljeno',
    DATE(datum_narudzbe + INTERVAL 3 DAY),
    DATE(datum_narudzbe + INTERVAL 2 + FLOOR(RAND()*2) DAY)
FROM narudzba;
```

&nbsp;

### 5.11 Popuna relacije _stavka_nabave_

```sql
INSERT INTO stavka_nabave (nabava_id, proizvod_id, kolicina, nabavna_cijena)
VALUES
(1, 1, 100, 2.0),
(1, 2, 80, 2.2),
(2, 6, 120, 1.8),
(2, 7, 90, 2.1),
(3, 10, 70, 2.5),
(3, 12, 60, 2.8);
```

&nbsp;

### 5.11 Popuna relacije _recenzija_

```sql
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

```

&nbsp;

## 6. Upiti (Andrej Pucković i Danijel Margić)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 6.1 Upit: Ukupan broj narudžbi i potrošnja po kupcu (Andrej Pucković)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```sql
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
```

&nbsp;

...
...
...
...
...

### 6.6 Upit: Prosječna ocjena i broj recenzija po proizvodu (Danijel Margić)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```sql
SELECT
    p.proizvod_id,
    p.naziv,
    COUNT(r.recenzija_id) AS broj_recenzija,
    ROUND(AVG(r.ocjena), 2) AS prosjecna_ocjena
FROM proizvod p
LEFT JOIN recenzija r ON p.proizvod_id = r.proizvod_id
GROUP BY p.proizvod_id, p.naziv
HAVING COUNT(r.recenzija_id) > 0
ORDER BY prosjecna_ocjena DESC, broj_recenzija DESC;
```

&nbsp;

## 7. Pogledi (Luka Wrana, Andrej Pucković, Danijel Margić)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 7.1 Pogled: Proizvodi po ukupnom prihodu (Luka Wrana)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```sql
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
```

&nbsp;

...
...
...

### 7.5 Pogled: Pogled aktivnih kupaca s osnovnim podacima (Andrej Pucković)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```sql
CREATE OR REPLACE VIEW AP_Pogled_aktivni_kupci AS
SELECT
    kupac_id,
    ime,
    prezime,
    email,
    telefon,
    datum_registracije
FROM kupac
WHERE aktivan = TRUE;
```

...
...
...
...

&nbsp;

### 7.10 Pogled: Pogled dostave po narudžbi (Danijel Margić)

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```sql
CREATE OR REPLACE VIEW AP_Pogled_dostave_narudzbi AS
SELECT
    d.dostava_id,
    d.narudzba_id,
    d.kurirska_sluzba,
    d.broj_posiljke,
    d.status_dostave,
    d.procijenjeni_datum,
    d.stvarni_datum
FROM dostava d;
```

&nbsp;

...
...
...
...
