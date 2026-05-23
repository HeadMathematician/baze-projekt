#### Sveučilište Jurja Dobrile u Puli Zagrebačka 30, 52100 Pula, Hrvatska

# BP1 Projekt - E-commerce trgovinu za prodaju čokolade 

## Tim-1

### 1. godina prijediplomskog sveučilišnog studija informatike

- **Luka Juroš** (JMBAG: )
- **Teo Kupčinovac** (JMBAG: )
- **Luka Wrana** (JMBAG: )
- **Andrej Pucović** (JMBAG: 0246066534)
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

Glavni zadatak ovog dijela projekta bio je popuniti bazu podataka smislenim i kvalitetnim podacima koji realistično predstavljaju poslovanje e-commerce trgovine za prodaju čokolade. Cilj popune nije bio samo umetanje proizvoljnih vrijednosti, nego stvaranje povezanih i logičnih podataka koji će pravilno funkcionirati s relacijama, SQL upitima, pogledima (VIEW), procedurama i ostalim funkcionalnostima baze podataka.

Prilikom popune bilo je važno paziti na:

- povezanost podataka između relacija
- smislenost naziva, opisa i vrijednosti
- poštivanje primarnih i stranih ključeva
- realistične podatke koji odgovaraju stvarnom sustavu web trgovine
- podatke koji omogućuju kvalitetno testiranje SQL upita i analiza

Za popunu podataka korištene su SQL naredbe poput:

- `INSERT INTO` — umetanje novih redaka u tablicu
- `VALUES` — definiranje konkretnih vrijednosti koje se umeću
- `SELECT` — dohvaćanje podataka iz drugih tablica
- `INSERT INTO ... SELECT` — umetanje podataka dobivenih iz drugog upita
- `RAND()` — generiranje slučajnih vrijednosti
- `NOW()` — dohvaćanje trenutnog datuma i vremena
- `DATE()` i `INTERVAL` — rad s datumima
- `CONCAT()` — spajanje tekstualnih vrijednosti
- `ELT()` — odabir jedne vrijednosti iz liste na temelju indeksa

Podaci su djelomično uneseni ručno pomoću statičkih SQL naredbi, dok su određene relacije poput narudžbi generirane automatski pomoću pohranjenih procedura kako bi se stvorila veća količina testnih podataka.

&nbsp;


### 5.1 Popuna relacije *kategorija*


```sql
INSERT INTO kategorija (kategorija_id, naziv, opis) VALUES
(1, 'Tamna čokolada', 'Premium tamne čokolade visokog udjela kakaa'),
(2, 'Mliječna čokolada', 'Kremaste mliječne čokolade s raznim okusima'),
(3, 'Bijela čokolada', 'Slatke bijele čokolade i kombinacije'),
(4, 'Praline', 'Ručno rađene praline punjene kremama i likerima'),
(5, 'Posebne ponude', 'Sezonske i limitirane kolekcije'),
(6, 'Čokoladne figure', 'Dekorativne figure od čokolade');
```

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


&nbsp;


### 5.2 Popuna relacije *dobavljac*

```sql
INSERT INTO dobavljac (dobavljac_id, naziv, kontakt_osoba, email, telefon, adresa) VALUES
(1, 'Cocoa Imports Europe', 'Marko Jurić', 'info@cocoa-eu.com', '01 555 111', 'Zagreb, Hrvatska'),
(2, 'Belgian Chocolate Supply', 'Anna De Vries', 'sales@belgianchoco.be', '+32 555 222', 'Brussels, Belgium'),
(3, 'Organic Cacao Farm', 'Luis Hernandez', 'contact@organiccacao.com', '+57 300 111', 'Medellin, Colombia');
```

Popuna podataka u relaciji **dobavljac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži informacije o dobavljačima čokolade i sirovina.

- **dobavljac_id** se unosi ručno i predstavlja jedinstveni identifikator svakog dobavljača.

- **naziv** predstavlja ime tvrtke dobavljača.

- **kontakt_osoba** označava osobu za kontakt unutar tvrtke.

- **email** i **telefon** služe za komunikaciju s dobavljačem.

- **adresa** predstavlja lokaciju dobavljača.

U prikazanom primjeru unesena su 3 dobavljača iz različitih država.


&nbsp;

### 5.3 Popuna relacije *kupac*

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

Popuna podataka u relaciji **kupac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži osnovne informacije o kupcima.

- **kupac_id** se unosi ručno i predstavlja jedinstveni identifikator svakog kupca.

- **ime** i **prezime** predstavljaju osobne podatke kupca.

- **email** mora biti jedinstven jer se koristi za prijavu u sustav.

- **lozinka** predstavlja korisničku lozinku.

- **telefon** služi za kontakt s kupcem.

U prikazanom primjeru uneseno je 10 kupaca:


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

Popuna podataka u relaciji **adresa** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži adrese kupaca koje se koriste za dostavu narudžbi.

Svaka adresa povezana je s određenim kupcem pomoću stranog ključa `kupac_id`, čime se ostvaruje relacija između tablica `kupac` i `adresa`.

Atributi u relaciji imaju sljedeću ulogu:

- **kupac_id** — označava kojem kupcu pripada adresa
- **ulica** — naziv ulice i kućni broj
- **grad** — grad stanovanja kupca
- **postanski_broj** — poštanski broj grada
- **glavna_adresa** — označava je li adresa glavna adresa kupca (`1`) ili dodatna adresa (`0`)

U prikazanom primjeru neki kupci imaju više adresa, što omogućuje realističniji prikaz stvarnog sustava internetske trgovine gdje korisnici mogu imati različite adrese za dostavu.

&nbsp;

### 5.5 Popuna relacije *proizvod*

```sql
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
```

Popuna podataka u relaciji **proizvod** vrši se pomoću više `INSERT INTO` naredbi. Ova relacija predstavlja glavnu tablicu proizvoda koji se prodaju unutar web trgovine.

Svaki proizvod povezan je s određenom kategorijom pomoću atributa `kategorija_id`, čime se ostvaruje relacija između tablica `proizvod` i `kategorija`.

Atributi relacije imaju sljedeću svrhu:

- **kategorija_id** — određuje kojoj kategoriji proizvod pripada
- **naziv** — naziv proizvoda
- **opis** — dodatni opis proizvoda i njegovih karakteristika
- **cijena** — prodajna cijena proizvoda
- **kolicina_na_skladistu** — trenutno stanje proizvoda na skladištu
- **SKU** — jedinstvena oznaka proizvoda koja služi za identifikaciju proizvoda u skladištu i sustavu prodaje

Prilikom popune korišteni su realistični nazivi i opisi proizvoda kako bi podaci imali smisla u kontekstu trgovine za prodaju čokolade. Proizvodi su raspoređeni po kategorijama poput mliječnih, tamnih i bijelih čokolada, pralina, posebnih ponuda i dekorativnih figura.

Na taj način omogućeno je kvalitetnije testiranje SQL upita, filtriranja proizvoda po kategorijama i izrade pogleda nad bazom podataka.


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
    DECLARE id_narudzbe INT;
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE random_kupac INT;
    DECLARE random_proizvod INT;
    DECLARE random_addresa INT;
    DECLARE random_kolicina INT;

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

        WHILE j <= 3 DO

            SET random_proizvod = FLOOR(1 + RAND() * 20);
            SET random_kolicina = FLOOR(1 + RAND() * 3);

            INSERT INTO stavka_narudzbe (
                narudzba_id,
                proizvod_id,
                kolicina,
                cijena_po_komadu,
                ukupna_cijena
            )
            SELECT
                id_narudzbe,
                p.proizvod_id,
                random_kolicina,
                p.cijena,
                p.cijena * random_kolicina
            FROM proizvod p
            WHERE p.proizvod_id = random_proizvod;

            SET j = j + 1;

        END WHILE;

        UPDATE narudzba n
        SET n.ukupan_iznos = (
            SELECT SUM(sn.ukupna_cijena)
            FROM stavka_narudzbe sn
            WHERE sn.narudzba_id = id_narudzbe
        )
        WHERE n.narudzba_id = id_narudzbe;

        SET i = i + 1;
    END WHILE;

END $$

DELIMITER ;

CALL generiraj_narudzbe();
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
    DECLARE id_narudzbe INT;
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE random_kupac INT;
    DECLARE random_proizvod INT;
    DECLARE random_addresa INT;
    DECLARE random_kolicina INT;
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

- **id_narudzbe** Sprema ID novokreirane narudžbe
  
- **i** i **j** - služe kao brojači za petlju, imaju `DEFAULT` vrijednost 1 jer petlja kreće od prve iteracije i izvršava se dok se ne ispuni uvjet uvjet

- **random_kupac** - Sprema nasumični ID kupca

- **random_proizvod** - Sprema nasumični ID proizvoda

- **random_addresa** - Sprema nasumičnu adresu kupca
- 
- **kolicina** - Sprema nasumičnu kolicinu proizvoda u stavki narudžbe



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

Sad kad imamo svojeg kupca, sljedeće što trebamo za narudžbu je adresa. Pošto smo već generirali kupca, nije potrebno nasumićno generirati adresu jer relacije za adresu već sadrži stupac za `kupac_id`. Ovaj upit služi za dohvaćanje adrese iz podataka koristeći našu varijeblu `random_kupac` kao kljuć. 

Objašnjenje dijelova:

- `SELECT adresa_id` – dohvaća ID adrese iz tablice adresa
- `INTO random_addresa` – rezultat upita sprema u varijablu random_addresa koju smo deklarirali na početku
- `FROM adresa` – tablica iz koje dohvaćamo podatke
- `WHERE kupac_id` = random_kupac – filtrira adrese samo za odabranog kupca
- `ORDER BY RAND()` – nasumično sortira rezultate
- `LIMIT` 1 – uzima samo jedan rezultat (jednu adresu)

&nbsp;

```sql
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
```

S `random_kupac` i `random_addresa` imamo sve što trebamo da bi popunili redak narudžbe. Podatke popunjavama kao i kod prijašnjih relacija pomoći `INSERT` i `VALUES` naredba. Za `kupac_id` i `adresa_id` koristimo naše nasumićno generirane `random_kupac` i `random_addresa`, a `datum_narudzbe` se generira nasumićno pomoću `DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*60) DAY)` koji stvara datum koji je 0-60 dana udaljeni od trenutnog datuma.

&nbsp;

Objašnjenje izraza:

| Dio izraza | Funkcija | Objašnjenje |
|------------|----------|-------------|
| `NOW()` | Trenutni datum i vrijeme | Vraća sadašnji timestamp (npr. 2026-05-18 19:00:00) |
| `RAND()` | Slučajni broj | Generira decimalni broj između 0 i 1 |
| `RAND() * 60` | Skaliranje na raspon 0–60 | Pretvara slučajni broj u raspon dana (0–60) |
| `FLOOR(RAND()*60)` | Cijeli broj dana | Uklanja decimalni dio i daje cijeli broj (0–59) |
| `INTERVAL ... DAY` | Definicija vremenskog intervala | Pretvara broj u vremenski interval u danima |
| `DATE_SUB(NOW(), INTERVAL ... DAY)` | Oduzimanje datuma | Oduzima slučajan broj dana od trenutnog datuma |

&nbsp;

Vrijednosti za `status` i `ukupan_iznos`, trenutno ne zahtijevaju nikakvo racunjanje. Status narudžbe možemo uvijek definirati kao 'Završena' zato jer su ovo narudžbe napravljene u prošlosti. Za ukupan iznos čemo zasada insertirati vrijednost od 0 jer još nemamo stavke naružbe pa ne možemo izraćunati ukupnu cijenu.

&nbsp;

```sql
SET id_narudzbe = LAST_INSERT_ID();

WHILE j <= 3 DO

    SET random_proizvod = FLOOR(1 + RAND() * 20);
    SET random_kolicina = FLOOR(1 + RAND() * 3);

    INSERT INTO stavka_narudzbe (
        narudzba_id,
        proizvod_id,
        kolicina,
        cijena_po_komadu,
        ukupna_cijena
    )
    SELECT
        id_narudzbe,
        p.proizvod_id,
        random_kolicina,
        p.cijena,
        p.cijena * random_kolicina
    FROM proizvod p
    WHERE p.proizvod_id = random_proizvod;

    SET j = j + 1;

END WHILE;
```

Slijedi najkompliciraniji dio pohranjene procedure, a to je popuna stavka narudžba. Zamišljeno je da se za svaku stavku generiraju tri nasumićno generirane stavke s razlićitim proizvodima i količinama. Id narudžbe je bio automatski generiran od strane MySQL-a tijekom popune narudžbe i njega dohvaćamo pomoću `LAST_INSERT_ID()` i tu vrijednost spremamo u našu varijablu `narudzba_id`. Zatim započinjemo drugi loop unutar našeg glavnog loop-a koji će koristiti varijablu `j` kao counter i izvršiti tri iteracija za tri stavke narudžbe prema uvjetu `j <= 3`. Prije popunjavanja podacima, trebamo pohraniti nasumiću vrijednost od 1 do 20 u varijablu `random_proizvod` i vrijednost od 1 do 3 u varijablu `random_kolicina` tako da dobimo vrijednosti koje će prestavljati id za jednog od 20 proizvoda i njihovu nasumićnu količinu. Slijedi popunjavanje stavka podacima:

&nbsp;
 
```sql
INSERT INTO stavka_narudzbe (
        narudzba_id,
        proizvod_id,
        kolicina,
        cijena_po_komadu,
        ukupna_cijena
    )
    SELECT
        id_narudzbe,
        p.proizvod_id,
        random_kolicina,
        p.cijena,
        p.cijena * random_kolicina
    FROM proizvod p
    WHERE p.proizvod_id = random_proizvod;
```

Za razliku od prethodnih `INSERT` naredbi koje koriste `VALUES`, ovdje se koristi kombinacija `INSERT INTO ... SELECT`. Takav pristup omogućuje dohvaćanje podataka direktno iz druge tablice i njihovo umetanje u novu tablicu unutar iste naredbe.

`INSERT INTO stavka_narudzbe` definira tablicu u koju će se umetnuti podaci, dok `S`ELECT dio određuje koje će se vrijednosti umetnuti.

U `FROM proizvod p` dijelu dohvaćaju se podaci iz tablice proizvod, pri čemu je p alias (skraćeni naziv) za tablicu proizvod. Alias služi za kraće i preglednije pisanje naziva stupaca, pa umjesto `proizvod.cijena` možemo pisati `p.cijena`.

Uvjet `WHERE p.proizvod_id = random_proizvod` osigurava da se iz tablice proizvod dohvati samo jedan proizvod — onaj čiji je ID jednak nasumično generiranom ID-u spremljenom u varijabli random_proizvod.

Vrijednosti koje se umeću u tablicu `stavka_narudzbe` su:

| Vrijednost                   | Opis                                           |
| ---------------------------- | ---------------------------------------------- |
| `id_narudzbe`                | ID trenutno generirane narudžbe                |
| `p.proizvod_id`              | ID nasumično odabranog proizvoda               |
| `random_kolicina`            | Nasumično generirana količina proizvoda        |
| `p.cijena`                   | Stvarna cijena proizvoda iz tablice `proizvod` |
| `p.cijena * random_kolicina` | Izračun ukupne cijene stavke                   |

&nbsp;

Na kraju petlje koristi se `SET j = j + 1` što povećava brojač unutarnje petlje i omogućuje prelazak na generiranje sljedeće stavke narudžbe. Kada vrijednost j postane veća od 3, unutarnja WHILE petlja završava i procedura nastavlja s generiranjem sljedeće narudžbe.


&nbsp;

```sql
UPDATE narudzba n
    SET n.ukupan_iznos = (
        SELECT SUM(sn.ukupna_cijena)
        FROM stavka_narudzbe sn
        WHERE sn.narudzba_id = id_narudzbe
    )
    WHERE n.narudzba_id = id_narudzbe;

    SET i = i + 1;
```

Nakon što su generirane sve stavke za jednu narudžbu, potrebno je izračunati ukupan iznos narudžbe. To se radi pomoću `UPDATE` naredbe koja ažurira stupac `ukupan_iznos` u tablici `narudzba`.

Funkcija `SUM()` zbraja vrijednosti stupca `ukupna_cijena` za sve stavke koje pripadaju trenutno generiranoj narudžbi. Na taj način dobivamo ukupnu cijenu cijele narudžbe. `ukupna_cijena` se selektira od `stavka_narudzbe` koristeći `sn` kao alias i u naredbi `WHERE sn.narudzba_id = id_narudzbe` on osigurava da se zbrajaju samo stavke koje pripadaju trenutno obrađivanoj narudžbi.

Nakon što se izračuna ukupna vrijednost, ona se sprema u stupac ukupan_iznos odgovarajuće narudžbe pomoću `WHERE n.narudzba_id = id_narudzbe`. Time smo stigli do kraja jedne iteracije while loop-a i vrijednost od `i` se poveća za 1.

&nbsp;

```sql
CALL generiraj_narudzbe();
```

Nakon što je procedura definirana i spremljena u bazu podataka, može se pokrenuti pomoću naredbe `CALL`. Naredba poziva pohranjenu proceduru `generiraj_narudzbe()` i izvršava sve SQL naredbe koje se nalaze unutar nje.

Prilikom izvršavanja procedure automatski se:

generiraju nasumični kupci
dohvaćaju njihove adrese
stvaraju nove narudžbe
generiraju stavke narudžbi s nasumičnim proizvodima i količinama
izračunava ukupan iznos svake narudžbe

U ovoj implementaciji procedura generira ukupno 60 narudžbi, pri čemu svaka narudžba sadrži 3 stavke narudžbe. Time se automatski popunjava velika količina testnih podataka bez potrebe za ručnim unosom.

Pohranjene procedure posebno su korisne kod automatizacije zadataka, generiranja testnih podataka i izvođenja složenijih operacija nad bazom podataka jer omogućuju izvršavanje većeg broja SQL naredbi unutar jedne funkcionalne cjeline.

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

Popuna podataka u relaciji **placanje** vrši se pomoću naredbe `INSERT INTO ... SELECT`. Za razliku od prethodnih relacija gdje su vrijednosti unesene ručno, ovdje se podaci automatski generiraju na temelju postojećih podataka iz relacije `narudzba`.

Svako plaćanje povezano je s jednom narudžbom pomoću atributa `narudzba_id`.

Atributi relacije imaju sljedeću svrhu:

- **narudzba_id** — označava kojoj narudžbi pripada plaćanje
- **nacin_placanja** — način kojim je kupac izvršio plaćanje
- **iznos** — ukupni iznos plaćanja
- **status_placanja** — status izvršenog plaćanja
- **datum_placanja** — datum kada je plaćanje izvršeno

Za generiranje nasumičnog načina plaćanja koristi se funkcija:

```sql
ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal')
```

Funkcija `RAND()` generira slučajni broj, dok `ELT()` na temelju tog broja odabire jednu od ponuđenih vrijednosti.

Iznos plaćanja preuzima se direktno iz stupca `ukupan_iznos` relacije `narudzba`, čime se osigurava konzistentnost podataka između relacija.

Datum plaćanja generira se dodavanjem 0–1 dana na datum narudžbe kako bi podaci realistično prikazivali proces online kupovine.


&nbsp;


### 5.8 Popuna relacije *dostava*

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

Popuna relacije **dostava** također koristi `INSERT INTO ... SELECT` pristup kojim se podaci generiraju na temelju postojećih narudžbi.

Ova relacija sadrži informacije o dostavi svake narudžbe.

Atributi relacije imaju sljedeću svrhu:

- **narudzba_id** — označava kojoj narudžbi pripada dostava
- **kurirska_sluzba** — naziv dostavne službe
- **broj_posiljke** — jedinstveni broj pošiljke
- **status_dostave** — trenutno stanje dostave
- **procijenjeni_datum** — očekivani datum dostave
- **stvarni_datum** — datum kada je pošiljka stvarno dostavljena

Kurirska služba bira se nasumično pomoću funkcije `ELT()`, dok se broj pošiljke generira pomoću `CONCAT()` funkcije koja spaja prefiks `"HR"` i slučajno generirani broj.

Procijenjeni datum dostave postavljen je tri dana nakon datuma narudžbe, dok stvarni datum dostave može odstupati za jedan dan kako bi podaci izgledali realističnije.


&nbsp;


### 5.9 Popuna relacije *nabava*

```sql
(1, NOW() - INTERVAL 30 DAY, 'Zaprimljeno', 500),
(2, NOW() - INTERVAL 20 DAY, 'Zaprimljeno', 700),
(3, NOW() - INTERVAL 10 DAY, 'Zaprimljeno', 600);
```

Relacija **nabava** sadrži podatke o nabavi proizvoda od dobavljača. Svaka nabava predstavlja jednu zaprimljenu pošiljku robe.

Atributi relacije imaju sljedeću svrhu:

- **dobavljac_id** — označava od kojeg dobavljača dolazi nabava
- **datum_nabave** — datum kada je nabava izvršena
- **status** — stanje nabave
- **ukupan_iznos** — ukupna vrijednost nabave

Datumi nabave generirani su pomoću `NOW()` funkcije i vremenskih intervala kako bi podaci predstavljali nabave izvršene u prošlosti.


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

Relacija **stavka_nabave** predstavlja pojedinačne proizvode koji pripadaju određenoj nabavi. Ova relacija ostvaruje vezu između tablica `nabava` i `proizvod`.

Atributi relacije imaju sljedeću svrhu:

- **nabava_id** — označava kojoj nabavi pripada stavka
- **proizvod_id** — označava koji je proizvod nabavljen
- **kolicina** — količina nabavljenog proizvoda
- **nabavna_cijena** — cijena po kojoj je proizvod nabavljen

Podaci su uneseni ručno kako bi se simulirala stvarna nabava različitih proizvoda od različitih dobavljača.


&nbsp;


### 5.12 Popuna relacije *recenzija*

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

Relacija **recenzija** sadrži korisničke recenzije i ocjene proizvoda. Ova relacija omogućuje prikaz povratnih informacija kupaca i analizu zadovoljstva proizvodima.

Svaka recenzija povezana je s jednim kupcem i jednim proizvodom pomoću stranih ključeva `kupac_id` i `proizvod_id`.

Atributi relacije imaju sljedeću svrhu:

- **kupac_id** — označava autora recenzije
- **proizvod_id** — označava proizvod koji se recenzira
- **ocjena** — brojčana ocjena proizvoda
- **komentar** — tekstualni komentar kupca

Prilikom popune korištene su različite ocjene i komentari kako bi podaci djelovali realističnije i omogućili kvalitetnije testiranje agregacijskih SQL funkcija poput `AVG()`, `COUNT()` i filtriranja recenzija po proizvodima.


&nbsp;


## 6. Upiti (Andrej Pucović i Danijel Margić)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 6.1 Upit: Ukupan broj narudžbi i potrošnja po kupcu (Andrej Pucović)

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


## 7. Pogledi (Luka Wrana, Andrej Pucović, Danijel Margić)

opis -Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

&nbsp;

### 7.1 Pogled: Proizvodi po ukupnom prihodu (Luka Wrana)

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

Pogledi (VIEW) u MySQL-u predstavljaju virtualne tablice koje se temelje na rezultatima jednog ili više SQL upita. Oni ne spremaju podatke fizički kao obične tablice, nego svaki put prikazuju rezultat izvršavanja definiranog upita.

Glavna prednost pogleda je pojednostavljivanje kompleksnih SQL upita i lakši pristup često korištenim analizama podataka.

U ovom primjeru izrađen je pogled `prihod_po_proizvodu` čija je svrha prikazati proizvode sortirane prema ukupnom prihodu koji su ostvarili u posljednjih mjesec dana.

Pogled koristi podatke iz sljedećih relacija:

- `proizvod`
- `stavka_narudzbe`
- `narudzba`

Povezivanje relacija izvršava se pomoću `JOIN` naredbi:

```sql
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
```

Na taj način svaki proizvod dobiva povezane stavke narudžbi i informacije o narudžbi kojoj pripada.

Ukupan prihod proizvoda računa se pomoću izraza:

```sql
SUM(sn.kolicina * sn.cijena_po_komadu)
```

Za svaku stavku narudžbe množi se količina proizvoda s cijenom po komadu, a zatim se sve vrijednosti zbrajaju pomoću funkcije `SUM()`.

Rezultati se grupiraju pomoću:

```sql
GROUP BY p.proizvod_id, p.naziv
```

što omogućuje izračun ukupnog prihoda za svaki pojedini proizvod.

Uvjet:

```sql
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
```

ograničava rezultate samo na narudžbe iz posljednjih mjesec dana.

Nakon kreiranja pogleda koristi se:

```sql
SELECT *
FROM prihod_po_proizvodu
ORDER BY ukupni_prihod DESC;
```

Ovaj upit dohvaća podatke iz pogleda i sortira proizvode od najvećeg prema najmanjem ukupnom prihodu.

Takav pogled koristan je za:

- analizu najprofitabilnijih proizvoda
- praćenje prodajnih trendova
- donošenje odluka o nabavi i promocijama
- prepoznavanje proizvoda koji ostvaruju najveću zaradu
  

&nbsp;

### 7.2 Pogled: Popularnost proizvoda po ukupnoj količini narudžba (Luka Wrana)

```sql
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
```

Ovaj pogled služi za analizu popularnosti proizvoda na temelju ukupne prodane količine u posljednjih mjesec dana.

Za razliku od prethodnog pogleda koji analizira financijski prihod, ovdje je fokus na količini prodanih proizvoda.

Pogled koristi iste relacije:

- `proizvod`
- `stavka_narudzbe`
- `narudzba`

Ukupna količina proizvoda računa se pomoću:

```sql
SUM(sn.kolicina)
```

Funkcija `SUM()` zbraja količine svih prodanih jedinica pojedinog proizvoda.

Rezultati se ponovno grupiraju po proizvodu:

```sql
GROUP BY p.proizvod_id, p.naziv
```

Uvjet:

```sql
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
```

osigurava da analiza uključuje samo novije narudžbe.

Nakon kreiranja pogleda koristi se:

```sql
SELECT *
FROM proizvodi_po_kolicini
ORDER BY ukupna_kolicina DESC;
```

što omogućuje prikaz najprodavanijih proizvoda prema količini.

Ovakav pogled koristan je za:

- analizu popularnosti proizvoda
- planiranje zaliha
- prepoznavanje proizvoda s najvećom potražnjom
- optimizaciju skladišta i nabave
  

&nbsp;

### 7.3 Pogled: Koeficijen bulk-narudžba (Luka Wrana)

```sql
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
```

Ovaj pogled služi za analizu prosječne količine proizvoda po narudžbi, odnosno određivanje proizvoda koji se najčešće kupuju u većim količinama.

Cilj pogleda je identificirati proizvode koji imaju najveći potencijal za bulk-prodaju.

Pogled koristi podatke iz relacija:

- `proizvod`
- `stavka_narudzbe`
- `narudzba`

Unutar pogleda izračunavaju se tri ključne vrijednosti:

- ukupna prodana količina proizvoda
- broj različitih narudžbi u kojima se proizvod pojavljuje
- prosječna količina proizvoda po narudžbi

Ukupna količina računa se pomoću:

```sql
SUM(sn.kolicina)
```

Broj različitih narudžbi računa se pomoću:

```sql
COUNT(DISTINCT n.narudzba_id)
```

Korištenje `DISTINCT` osigurava da se ista narudžba ne broji više puta.

Glavni dio pogleda je izračun:

```sql
SUM(sn.kolicina) / COUNT(DISTINCT n.narudzba_id)
```

Ovaj izraz računa prosječnu količinu proizvoda po jednoj narudžbi.

Zaštita od dijeljenja s nulom ostvarena je pomoću `CASE` izraza:

```sql
CASE 
    WHEN COUNT(DISTINCT n.narudzba_id) = 0 THEN 0
    ELSE ...
END
```

Rezultati se sortiraju prema najvećoj prosječnoj količini po narudžbi:

```sql
ORDER BY prosjecna_kolicina_po_narudzbi DESC;
```

Takav pogled koristan je za:

- prepoznavanje proizvoda koji se kupuju u većim količinama
- planiranje promotivnih paketa
- analizu ponašanja kupaca
- optimizaciju skladišnih zaliha
- donošenje poslovnih odluka vezanih uz bulk-prodaju


&nbsp;

...
...
...

### 7.5 Pogled: Pogled aktivnih kupaca s osnovnim podacima (Andrej Pucović)

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


