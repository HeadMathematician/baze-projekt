#### Sveučilište Jurja Dobrile u Puli Zagrebačka 30, 52100 Pula, Hrvatska

# BP1 Projekt - E-commerce trgovinu za prodaju čokolade 

## Tim-1

### 1. godina prijediplomskog sveučilišnog studija informatike

- **Luka Juroš** (JMBAG: )
- **Teo Kupčinovac** (JMBAG: )
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

 opis

 - objasniti kako se stvaraju relacije u MySQL 
  
&nbsp;

### 4.1 Relacija *kupac*

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

## 5. Popuna podacima (Luka Wrana)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 5.1 Popuna relacije *kategorija*


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

### 5.2 Popuna relacije *dobavljac*

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

### 5.3 Popuna relacije *kupac*

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

### 5.4 Popuna relacije *adresa*

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

### 5.5 Popuna relacije *proizvod*

```sql
```

&nbsp;

### 5.6 Procedura za automatsko generiranje narudzba

Pohranjene procedure su unaprijed definirani SQL programi koji se spremaju unutar baze podataka i mogu se pozivati po potrebi. One omogućuju automatizaciju složenijih operacija koje uključuju više SQL naredbi, petlje, uvjete i rad s varijablama. One su u MySQL-u ekvivalentne funckijama iz drugih programskih jezika poput: Python, C++ i JavaScript.

Za razliku od običnog SQL upita koji izvršava samo jednu naredbu, procedura može sadržavati više naredbi koje se izvršavaju redom unutar jednog bloka.

U MySQL-u procedura se definira pomoću naredbe `CREATE PROCEDURE`, a pokreće se naredbom `CALL`.

Kod procedura se često koriste:

`DECLARE` - deklaracija varijabli

`SET` - postavljanje vrijednosti

`WHILE` - petlje

`IF` - uvjeti

`SELECT` ... `INTO` - spremanje rezultata upita u varijablu

`LAST_INSERT_ID()` - dohvaćanje ID-a zadnjeg unesenog retka.

&nbsp;

```sql
DELIMITER $$

CREATE PROCEDURE generiraj_narudzbe()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_kupac INT;
    DECLARE random_addresa INT;
    DECLARE id_narudzbe INT;

    WHILE i <= 60 DO

        SET random_kupac = FLOOR(1 + RAND() * 10);
        
        SELECT adresa_id
        INTO random_addresa
        FROM adresa
        WHERE kupac_id = random_kupac
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
            random_kupac,
            random_addresa,
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*60) DAY),
            'Završena',
            0
        );

        SET id_narudzbe = LAST_INSERT_ID();

        INSERT INTO stavka_narudzbe (
            narudzba_id,
            proizvod_id,
            kolicina,
            cijena_po_komadu,
            ukupna_cijena
        )
        VALUES
        (id_narudzbe, FLOOR(1 + RAND()*18), 1, 3.5, 3.5),
        (id_narudzbe, FLOOR(1 + RAND()*18), 2, 4.0, 8.0),
        (id_narudzbe, FLOOR(1 + RAND()*18), 1, 5.5, 5.5);

        SET i = i + 1;
    END WHILE;

END $$

DELIMITER ;

CALL generiraj_narudzbe();

UPDATE narudzba n
JOIN (
    SELECT narudzba_id, SUM(ukupna_cijena) AS total
    FROM stavka_narudzbe
    GROUP BY narudzba_id
) s ON s.narudzba_id = n.narudzba_id
SET n.ukupan_iznos = s.total;
```

&nbsp;

moja funckija bla bla

```sql
DELIMITER $$

...

END $$

DELIMITER ;
```

&nbsp;

Delimiter je znak ili niz znakova koji označava kraj jedne naredbe i on se u MySQL postavlja/mijenja naredbom `DELIMITER`. Prije nego definiramo svoju proceduru, mijenjamo delimiter od standardnog `;` na `$$` pomoću `DELIMITER $$` naredbe, i onda na kraju svoje procedure završavavo naredbu s `END $$` i vraćamo delimiter natrag na `;` pomoću `DELIMITER ;`. Ovo je potrebno zato što MySQL standardno koristi `;` kao završetak naredbe što funckionira kod upita koji imaju samo jednu naredbu, ali kod procedura (koje imaju više naredba koje završavaju s `;`) potrebno je postaviti drugi delimiter. 


```sql
CREATE PROCEDURE generiraj_narudzbe()
BEGIN
```
 
Pomoću `CREATE PROCEDURE` definiramo novu pohranjenu proceduru naziva `generiraj_narudzbe()`. `BEGIN` naredbom definiramo početak preocedure i sve naredbe koje pripadaju proceduro nalaze se između `BEGIN` ... `END`.

&nbsp;

```sql
    DECLARE i INT DEFAULT 1;
    DECLARE random_kupac INT;
    DECLARE random_addresa INT;
    DECLARE id_narudzbe INT;
```

Sljedeći korak u proceduri je deklaracija varijabli koje će se koristiti tijekom izvođenja procedure.

Varijable se deklariraju pomoću naredbe `DECLARE`, a osnovna struktura deklaracije izgleda ovako:

`DECLARE ime_varijable tip_podatka [DEFAULT zadana_vrijednost];`

| Dio             | Opis                                   |
| --------------- | -------------------------------------- |
| `DECLARE`       | Ključna riječ za deklaraciju varijable |
| `ime_varijable` | Naziv varijable                        |
| `tip_podatka`   | Tip podatka koji varijabla sprema      |
| `DEFAULT`       | Opcionalna zadana vrijednost           |

&nbsp;

U ovoj proceduri koriste se sljedeće varijable:

- **i** služi kao brojač za petlju, ima `DEFAULT` vrijednost 1 jer petlja kreće od prve iteracije i izvršava se dok je uvjet `WHILE i <= 60 DO`

- **random_kupac** Sprema nasumični ID kupca

- **random_addresa** Sprema nasumičnu adresu kupca

- **id_narudzbe** Sprema ID novokreirane narudžbe


&nbsp;

```sql
WHILE i <= 60 DO

...

END WHILE;
```

Započinje prvu iteraciju petlje koja će izvršavati naredbe koje se nalaze između `WHILE __uvjet__` i `END WHILE;`. Uvjet `i <= 60` označava koliko puta će se petlja ponoviti u pri čemu je broj `60` ukupan broj narudžba i stavki narudđba koje će se generirati. Ako želimo stvoriti 100 automatki generiranih narudžba onda bi koristili uvijet `i <= 100`. `END WHILE` Označava završetak naredba u sklopu while petlje, no petlja će tek završiti dok se ispuni uvijet.

&nbsp;

```sql
SET random_kupac = FLOOR(1 + RAND() * 10);
```

Pomoću `SET` naredbe dodijeljujemo vrijednosti varijablama. Naredba generira nasumični broj između 1 i 10 i sprema ga u varijablu random_kupac. Dobiveni broj predstavlja ID nasumično odabranog kupca iz tablice kupac. Primijetite da su svi id-evi iz stupca `kupac` brojevi od 1 do 10. Da bi naša tablica za kupce imala id-ove s brojčanim vrijednostima viših od 10, ova pohranjena procedura bi dohvatala samo id-eve unutar raspona 1-10. 

Da bi generirao nasumičan broj od 1 do 10 sam koristio:

- **FLOOR** uklanja decimalni dio broja i vraća cijeli broj

- **RAND** generira slučajni decimalni broj između 0 i 1

Pošto `RAND()` vraća decimalni broj manji od jedan (npr. 0.847), on se treba pomnožiti s 10 da bi se dobio decimalni u rasponu od 0 do 10 (npr. 8.47) i zatim se doda + 1 kako bi se raspon pomaknuo na raspon od 1 do 11 (npr. 9.47). `FLOOR()` onda uklanja decimalni dio broja i dobivamo nasumičan broj između 1 i 10 (npr. 9).


&nbsp;

```sql
 SELECT adresa_id
        INTO random_addresa
        FROM adresa
        WHERE kupac_id = random_kupac
        ORDER BY RAND()
        LIMIT 1;
```

&nbsp;

```sql
```

&nbsp;

```sql
```

&nbsp;

```sql
```

&nbsp;

```sql
```

&nbsp;

```sql
```

&nbsp;



### 5.7 Popuna relacije *placanje*

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

### 5.9 Popuna relacije *dostava*

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

### 5.11 Popuna relacije *stavka_nabave*

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


### 5.11 Popuna relacije *recenzija*

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


