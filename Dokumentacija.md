#### Sveučilište Jurja Dobrile u Puli Zagrebačka 30, 52100 Pula, Hrvatska

# BP1 Projekt - E-commerce trgovinu za prodaju čokolade 

## Tim-1

### 1. godina prijediplomskog sveučilišnog studija informatike

- **Luka Juroš** (JMBAG: )
- **Teo Kupčinovac** (JMBAG: )
- **Luka Wrana** (JMBAG: 0303128892)
- **Andrej Pucković** (JMBAG: 0246066534)
- **Danijel Margić** (JMBAG: 0275053078)


&nbsp;

## 1. Uvod (Luka Juroš)

U sklopu kolegija Baze podataka I zadatak projektnog rada bio je osmisliti, dizajnirati i implementirati relacijsku bazu podataka koja modelira stvarni poslovni proces koristeći znanja obrađena tijekom semestra. Projekt je obuhvaćao analizu problema, modeliranje podataka pomoću ER i EER dijagrama, implementaciju baze podataka u MySQL sustavu te izradu SQL upita, pogleda i dokumentacije.
  

&nbsp;


## 2. Opis projekta (Luka Juroš)

Tema našeg projekta je sustav za upravljanje e-commerce trgovinom za prodaju čokolada. Projekt je podijeljen u nekoliko glavnih faza razvoja baze podataka:

- **Konceptualni dizajn baze podataka** – analiza poslovnog procesa te izrada ER i EER dijagrama pomoću Lucidchart-a i MySQL Workbench-a.
  
- **Implementacija relacija i tablica** – stvaranje relacija u MySQL sustavu korištenjem SQL skripti i naredbi CREATE TABLE uz definiranje primarnih i stranih ključeva.
  
- **Unos i generiranje podataka** – popunjavanje baze smislenim testnim podacima koji simuliraju stvarno poslovanje webshop sustava za prodaju čokolada.
  
- **Izrada SQL upita i pogleda** – razvoj složenih SQL upita i VIEW pogleda za dohvat i analizu podataka iz baze.
  
- **Implementacija triggera** – automatizacija određenih procesa i održavanje konzistentnosti podataka unutar sustava.

Projekt je razvijan korištenjem više alata i tehnologija. Lucidchart je korišten za modeliranje ER dijagrama, MySQL Workbench za implementaciju baze i generiranje EER dijagrama, GitHub za verzioniranje i dijeljenje koda, a Discord za komunikaciju unutar tima. ChatGPT korišten je kao pomoć pri generiranju dijela testnih podataka.


&nbsp;

## 3. Konceptualini dizajn (Luka Juroš)

#### 3.1 Definiranje poslovnog procesa (ER + EER Dijagram)

Konceptualni dizajn baze podataka predstavlja prvi i najvažniji korakau razvoju sustava baze podataka. U ovoj fazi definira se poslovni proces, identificiraju se svi važni entiteti te njihovi međusobni odnosi. Konceptuali dizaj je najvažniji korak jer definira strukturu cijelog projekta i svaki sljedeći korak ovisi o njemu. Za modeliranje sustava korišteni su ER (Entity Relationship) i EER (Enhanced Entity Relationship) dijagrami. ER dijagram omogućuje lakše razumijevanje strukture baze podataka prije same implementacije, dok EER dijagram daje detaljniji prikaz sustava koji je prikladan za implementaciju u relacijskim sustavima baza podataka poput MySQL-a.

&nbsp;

### 3.2 Entity Relationship (ER) dijagram

U nastavku je opisan ER dijagram sustava za upravljanje e-trgovinom. Dijagram prikazuje 12 entiteta i njihove međusobne veze s pripadajućim kardinalnostima. Svaka veza je opisana u kontekstu poslovnog procesa e-trgovine.

Skup entiteta `KUPAC` povezan je sa skupom entiteta `ADRESA` vezom „ima", jedan naprema više (1:N), jer jedan kupac može imati više adresa (npr. adresu stanovanja i adresu za dostavu), dok se svaka adresa odnosi na točno jednog kupca.

Skup entiteta `KUPAC` povezan je sa skupom entiteta `NARUDŽBA` vezom „kreira", jedan naprema više (1:N), jer jedan kupac može kreirati više narudžbi tijekom vremena, dok se svaka narudžba odnosi na točno jednog kupca koji ju je kreirao.

Skup entiteta `KUPAC` povezan je sa skupom entiteta `RECENZIJA` vezom „piše", jedan naprema više (1:N), jer jedan kupac može napisati više recenzija za različite proizvode, dok svaku recenziju piše točno jedan kupac.

Skup entiteta `KATEGORIJA` povezan je sa skupom entiteta `PROIZVOD` vezom „pripada", jedan naprema više (1:N), jer jedna kategorija može sadržavati više proizvoda, dok svaki proizvod pripada točno jednoj kategoriji.

Skup entiteta `KATEGORIJA` povezan je sam sa sobom (rekurzivna veza) vezom „nadkategorija", jedan naprema više (1:N), jer jedna kategorija može biti nadkategorija za više podkategorija (npr. kategorija „Elektronika" sadrži podkategorije „Mobiteli", „Računala" i „Audio"), dok svaka podkategorija ima najviše jednu nadkategoriju. Kategorije na vrhu hijerarhije (korijenske kategorije) nemaju nadkategoriju.

Skup entiteta `PROIZVOD` povezan je sa skupom entiteta `RECENZIJA` vezom „ocjenjuje", jedan naprema više (1:N), jer jedan proizvod može imati više recenzija od različitih kupaca, dok se svaka recenzija odnosi na točno jedan proizvod. Entitet `RECENZIJA` također predstavlja razrješenje više-naprema-više (M:N) veze između entiteta KUPAC i `PROIZVOD`, jer jedan kupac može ocijeniti više proizvoda, a jedan proizvod može biti ocijenjen od više kupaca.

Skup entiteta `NARUDŽBA` povezan je sa skupom entiteta `STAVKA_NARUDŽBE` vezom „sadrži", jedan naprema više (1:N), jer jedna narudžba može sadržavati više stavki (različitih proizvoda), dok se svaka stavka narudžbe odnosi na točno jednu narudžbu.

Skup entiteta `PROIZVOD` povezan je sa skupom entiteta `STAVKA_NARUDŽBE` vezom „u_stavci", jedan naprema više (1:N), jer jedan proizvod može biti stavka u više različitih narudžbi, dok se svaka stavka narudžbe odnosi na točno jedan proizvod. Entitet `STAVKA_NARUDŽBE` predstavlja razrješenje više-naprema-više (M:N) veze između entiteta NARUDŽBA i `PROIZVOD`, jer jedna narudžba može sadržavati više proizvoda, a jedan proizvod može se nalaziti u više narudžbi.

Skup entiteta `NARUDŽBA` povezan je sa skupom entiteta `PLAĆANJE` vezom „placa_se", jedan naprema jedan (1:1), jer se svaka narudžba plaća točno jednim plaćanjem, dok se svako plaćanje odnosi na točno jednu narudžbu.

Skup entiteta `NARUDŽBA` povezan je sa skupom entiteta `DOSTAVA` vezom „dostavlja_se", jedan naprema jedan (1:1), jer se svaka narudžba dostavlja točno jednom dostavom, dok se svaka dostava odnosi na točno jednu narudžbu.

Skup entiteta `NARUDŽBA` povezan je sa skupom entiteta ADRESA vezom „na_adresu", više naprema jedan (N:1), jer se više narudžbi može dostaviti na istu adresu, dok se svaka narudžba dostavlja na točno jednu adresu kupca.

Skup entiteta `DOBAVLJAČ` povezan je sa skupom entiteta `NABAVA` vezom „opskrbljuje", jedan naprema više (1:N), jer jedan dobavljač može isporučiti više nabavnih narudžbi, dok se svaka nabavna narudžba odnosi na točno jednog dobavljača.

Skup entiteta `NABAVA` povezan je sa skupom entiteta `STAVKA_NABAVE` vezom „sadrži", jedan naprema više (1:N), jer jedna nabavna narudžba može sadržavati više stavki (različitih proizvoda), dok se svaka stavka nabave odnosi na točno jednu nabavnu narudžbu.

Skup entiteta `PROIZVOD` povezan je sa skupom entiteta `STAVKA_NABAVE` vezom „nabavlja_se", jedan naprema više (1:N), jer se jedan proizvod može nabavljati više puta kroz različite nabavne narudžbe, dok se svaka stavka nabave odnosi na točno jedan proizvod. Entitet `STAVKA_NABAVE` predstavlja razrješenje više-naprema-više (M:N) veze između entiteta `NABAVA` i `PROIZVOD`, jer jedna nabavna narudžba može uključivati više proizvoda, a jedan proizvod može se nabavljati od više dobavljača kroz više nabavnih narudžbi.

### Pregled kardinalnosti

U sustavu su zastupljene sve osnovne vrste kardinalnosti:

**Veze jedan naprema jedan (1:1):** NARUDŽBA ↔ PLAĆANJE, NARUDŽBA ↔ DOSTAVA

**Veze jedan naprema više (1:N):** KUPAC → ADRESA, KUPAC → NARUDŽBA, KUPAC → RECENZIJA, KATEGORIJA → PROIZVOD, KATEGORIJA → KATEGORIJA (rekurzivna), DOBAVLJAČ → NABAVA, NARUDŽBA → STAVKA_NARUDŽBE, NABAVA → STAVKA_NABAVE

**Razriješene veze više naprema više (M:N):** NARUDŽBA ↔ PROIZVOD (preko STAVKA_NARUDŽBE), NABAVA ↔ PROIZVOD (preko STAVKA_NABAVE), KUPAC ↔ PROIZVOD (preko RECENZIJA)

![Slika 1: ER dijagram](ER_dijagram.png)


&nbsp;


### 3.3 Enhanced Entity–Relationship (EER) dijagram (MySQL Workbench)

EER dijagram izrađen je pomoću alata MySQL Workbench te predstavlja detaljniju i tehnički precizniju verziju ER dijagrama. Dok ER dijagram služi za prikaz osnovnih entiteta i njihovih odnosa, EER dijagram prikazuje stvarnu strukturu baze podataka koja se koristi pri implementaciji u MySQL sustavu. U dijagramu su definirane sve relacije, atributi, primarni i strani ključevi te ograničenja integriteta podataka. Posebna pažnja posvećena je pravilnom povezivanju tablica i definiranju kardinalnosti odnosa između entiteta kako bi se osigurala konzistentnost podataka unutar sustava. EER dijagram također prikazuje pomoćne relacije poput `STAVKA_NARUDŽBE`, `STAVKA_NABAVE` i `RECENZIJA` koje služe za razrješavanje više naprema više (M:N) odnosa između glavnih entiteta baze podataka. Osim toga, prikazana je i hijerarhijska struktura kategorija pomoću samoreferencijalne veze unutar relacije `KATEGORIJA`.


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


### 4.1 Relacija kupac

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


&nbsp;


### 4.2 Relacija adresa

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

Kupac može imati više adresa za dostavu, primjerice kućnu i poslovnu. Primarni ključ je **adresa_id** koji se automatski povećava. **kupac_id** je strani ključ prema tablici _kupac_, s `ON DELETE CASCADE`, dakle brisanjem kupca automatski se brišu i sve njegove adrese. **ulica**, **grad** i **postanski_broj** su obavezni atributi tipa `VARCHAR`. Zanimljivo je da **postanski_broj** nije `INT` nego `VARCHAR`, zato jer neki poštanski brojevi počinju nulom. **drzava** ima zadanu vrijednost `'Hrvatska'` pa ju nije potrebno ručno unositi za svaki zapis. **glavna_adresa** je `BOOLEAN` koji označava je li ta adresa primarna za dostavu. Kupac može imati više adresa, ali samo jedna može biti glavna.


&nbsp;


### 4.3 Relacija dobavljac

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

Pohranjuje kontaktne podatke tvrtki od kojih nabavljamo sirovine i gotove proizvode. **dobavljac_id** je primarni ključ s `AUTO_INCREMENT`. **naziv** je obavezan, dok su **kontakt_osoba**, **telefon** i **adresa** opcionalni jer ne mora svaka tvrtka imati specificiranog kontakta. **email** je obavezan i jedinstven (`NOT NULL` i `UNIQUE`). Ne mogu postojati dva dobavljača s istom email adresom.


&nbsp;


### 4.4 Relacija kategorija

```sql
CREATE TABLE kategorija (
    kategorija_id INT AUTO_INCREMENT PRIMARY KEY,
    nadkategorija_id INT,
    naziv VARCHAR(100) NOT NULL,
    opis TEXT,
    FOREIGN KEY (nadkategorija_id) REFERENCES kategorija(kategorija_id)
);
```

Grupira proizvode u logične cjeline kako bi pretraživanje u webshop-u bilo jednostavnije. Posebno je zanimljiv atribut **nadkategorija_id** strani ključ koji pokazuje na samu tablicu _kategorija_, tzv. samoreferencijalni odnos. Njime se postiže hijerarhija kategorija, primjerice "Mliječna čokolada" može biti podkategorija od "Čokolade". Ako je `NULL`, ta je kategorija na najvišoj razini. **naziv** je obavezan, **opis** je opcionalan.


&nbsp;


### 4.5 Relacija proizvod

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

Srž cijelog kataloga, svaki artikl koji prodajemo ima ovdje svoj zapis. **kategorija_id** je strani ključ koji ga smješta u odgovarajuću kategoriju. **cijena** je tipa `DECIMAL(10,2)` umjesto `FLOAT` jer se radi o novcu i bitna je preciznost na dvije decimale. **SKU** (Stock Keeping Unit) je interna šifra proizvoda koja mora biti jedinstvena (`UNIQUE`). **aktivan** je `BOOLEAN` koji omogućuje tkzv. meko brisanje, kad povučemo proizvod iz prodaje, ne brišemo ga iz baze nego ga samo označimo kao neaktivnog, čime čuvamo povijest. **datum_dodavanja** se automatski popunjava s `CURRENT_TIMESTAMP` pri unosu.


&nbsp;


### 4.6 Relacija narudzba

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

Bilježi svaku kupovinu u webshop-u. Sadrži strane ključeve prema **kupac** i **adresa**. Pri naručivanju kupac odabire na koju od svojih adresa šalje paket. **datum_narudzbe** bilježi točan trenutak kreiranja narudžbe, **status** prati fazu obrade (npr. "U obradi", "Poslano", "Završena"), a **ukupan_iznos** tipa `DECIMAL(12,2)` predstavlja ukupnu vrijednost svih stavki te narudžbe.


&nbsp;


### 4.7 Relacija stavka_narudzbe

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

Budući da jedna narudžba može sadržavati više različitih proizvoda, svaki redak u košarici postaje zasebna stavka. **narudzba_id** i **proizvod_id** su strani ključevi koji je vežu uz narudžbu i konkretni proizvod. **kolicina** je obavezna. **cijena_po_komadu** sprema se u trenutku narudžbe, a ne uzima se direktno iz tablice _proizvod_, to je namjerno, jer bi inače naknadna promjena cijene utjecala i na stare narudžbe. **ukupna_cijena** je umnožak količine i cijene po komadu.


&nbsp;


### 4.8 Relacija placanje

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

Bilježi detalje transakcije za svaku narudžbu. **narudzba_id** je strani ključ prema narudžbi. **nacin_placanja** opisuje kako je kupac platio (npr. "Kartica", "PayPal", "Pouzećem"), **status_placanja** prati je li plaćanje uspješno, a **datum_placanja** bilježi točan trenutak kad je transakcija izvršena.


&nbsp;


### 4.9 Relacija dostava

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

Nakon što je narudžba plaćena, paket se predaje kurirskoj službi. **narudzba_id** veže dostavu uz narudžbu. **kurirska_sluzba** i **broj_posiljke** (tracking broj) daju kupcu mogućnost praćenja paketa. **procijenjeni_datum** i **stvarni_datum** su oba tipa `DATE`, uspoređivanjem tih dvaju polja možemo pratiti koliko kurirske službe kasne ili jesu li paket dostavile ranije nego što je planirano.


&nbsp;


### 4.10 Relacija nabava

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

Dok prethodne tablice prate prodaju prema kupcima, ova tablica pokriva drugu stranu, tj. kupovinu robe od dobavljača. **dobavljac_id** je strani ključ koji pokazuje od koga je roba naručena. **datum_nabave**, **status** i **ukupan_iznos** prate tijek i vrijednost cijele nabave.


&nbsp;


### 4.11 Relacija stavka_nabave

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

Analogno stavkama narudžbe, ova tablica detaljizira što je točno nabavljeno u sklopu jedne nabave. **nabava_id** je strani ključ s `ON DELETE CASCADE`, tj. brisanjem nabave automatski se brišu i sve njene stavke. **proizvod_id** pokazuje koji je artikl nabavljen, **kolicina** koliko komada, a **nabavna_cijena** je cijena po komadu od dobavljača, koja se razlikuje od prodajne cijene.


&nbsp;


### 4.12 Relacija recenzija

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

Kupci mogu ocjenjivati proizvode koje su kupili. **kupac_id** i **proizvod_id** su strani ključevi definirani s `ON DELETE CASCADE`. **ocjena** je tipa `TINYINT` s ograničenjem `CHECK (ocjena BETWEEN 1 AND 5)`, dakle baza ne prihvaća vrijednosti izvan tog raspona. **komentar** je opcionalan tekst, a **datum_recenzije** se automatski popunjava. Posebno je vrijedno naglasiti složeno ograničenje `UNIQUE (kupac_id, proizvod_id)` koje sprječava da isti kupac ostavi više od jedne recenzije za isti proizvod.


&nbsp;


## 5. Popuna podacima (Luka Wrana)

Glavni zadatak ovog dijela projekta bio je popuniti bazu podataka smislenim i kvalitetnim podacima koji realistično simuliraju e-commerce trgovinu za prodaju čokolade. Važno je stvoriti kvalitetne podatke koji će biti korisni za izvođenje upita i izradu pogleda, jer je svrha podataka njihova analiza i donošenje zaključaka na temelju dobivenih rezultata.

Kada vlasnik trgovine analizira podatke o proizvodima i narudžbama, može pokušati utvrditi koji su proizvodi popularni, a koji nisu, te na temelju toga donositi poslovne odluke. Na temelju podataka, mogao bi povećati cijenu proizvoda za koje postoji velika potražnja ili prestati prodavati proizvode koji ostvaruju slabe rezultate.

Podaci mogu biti nasumično generirani jer je ponašanje kupaca prirodno nasumičan no, podaci moraju svakako ostati smisleni i konzistentni kako bi analiza bila pouzdana te kako bi se na temelju nje mogli donositi pravilni zaključci i poslovne odluke.

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


### 5.1 Popuna relacije kategorija


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

- **kategorija_id**- jedinstveni identifikator svake kategorije
  
- **naziv** - naziv kategorije

- **opis** - daje dodatno objašnjenje kategorije i služi za detaljniji opis sadržaja


&nbsp;


### 5.2 Popuna relacije dobavljac

```sql
INSERT INTO dobavljac (dobavljac_id, naziv, kontakt_osoba, email, telefon, adresa) VALUES
(1, 'Cocoa Imports Europe', 'Marko Jurić', 'info@cocoa-eu.com', '01 555 111', 'Zagreb, Hrvatska'),
(2, 'Belgian Chocolate Supply', 'Anna De Vries', 'sales@belgianchoco.be', '+32 555 222', 'Brussels, Belgium'),
(3, 'Organic Cacao Farm', 'Luis Hernandez', 'contact@organiccacao.com', '+57 300 111', 'Medellin, Colombia');
```

Popuna podataka u relaciji **dobavljac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži informacije o dobavljačima čokolade i sirovina.

- **dobavljac_id** - jedinstveni identifikator svakog dobavljača

- **naziv** - tvrtke dobavljača.

- **kontakt_osoba** - osoba za kontakt unutar tvrtke

- **email** i **telefon** - služe za komunikaciju s dobavljačem, moraju biti jedinstveni

- **adresa** - predstavlja lokaciju dobavljača


&nbsp;

### 5.3 Popuna relacije kupac

```sql
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
```

Popuna podataka u relaciji **kupac** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži osnovne informacije o kupcima.

- **kupac_id** - predstavlja jedinstveni identifikator svakog kupca

- **ime** i **prezime** - predstavljaju osobne podatke kupca

- **email** - email adresa kupca, mora biti jedinstven jer se koristi za prijavu u sustav

- **lozinka** - predstavlja korisničku lozinku, mora biti jedinstven jer se koristi za prijavu u sustav 

- **telefon** - služi za kontakt s kupcem, mora biti jedinstven
  
- **datum_registracije** - predstavlja datum registracije kupca u sustavu

- **aktivan** - predstavlja informaciju o tome da li je kupac aktivan ili ne


&nbsp;


### 5.4 Popuna relacije adresa

```sql
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
```

Popuna podataka u relaciji **adresa** vrši se unosom više zapisa pomoću SQL naredbe `INSERT INTO`. Ova relacija sadrži adrese kupaca koje se koriste za dostavu narudžbi.

Svaka adresa povezana je s određenim kupcem pomoću stranog ključa `kupac_id`, čime se ostvaruje relacija između tablica `kupac` i `adresa`.

Atributi u relaciji imaju sljedeću ulogu:

- **adresa_id** - jedinstveni identifikator adrese

- **kupac_id** - označava kojem kupcu pripada adresa
 
- **ulica_i_broj** - naziv ulice i kućni broj
 
- **grad** - grad stanovanja kupca
 
- **postanski_broj** - poštanski broj grada

- **drzava** - država stanovanja kupca
 
- **glavna_adresa** - označava je li adresa glavna adresa kupca (`1`) ili dodatna adresa (`0`)

U prikazanom primjeru neki kupci imaju više adresa, što omogućuje realističniji prikaz stvarnog sustava internetske trgovine gdje korisnici mogu imati različite adrese za dostavu.

&nbsp;

### 5.5 Popuna relacije proizvod

```sql
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
```

Popuna podataka u relaciji **proizvod** vrši se pomoću više `INSERT INTO` naredbi. Ova relacija predstavlja glavnu tablicu proizvoda koji se prodaju unutar web trgovine. Svaki proizvod povezan je s određenom kategorijom pomoću atributa `kategorija_id`, čime se ostvaruje relacija između tablica `proizvod` i `kategorija`.

Atributi relacije imaju sljedeću svrhu:

- **kategorija_id** - određuje kojoj kategoriji proizvod pripada
  
- **naziv** - naziv proizvoda
  
- **opis** - dodatni opis proizvoda i njegovih karakteristika
  
- **cijena** - prodajna cijena proizvoda
  
- **kolicina_na_skladistu** - trenutno stanje proizvoda na skladištu
  
- **SKU** - jedinstvena oznaka proizvoda koja služi za identifikaciju proizvoda u skladištu i sustavu prodaje

Prilikom popune korišteni su realistični nazivi i opisi proizvoda kako bi podaci imali smisla u kontekstu trgovine za prodaju čokolade. Proizvodi su raspoređeni po kategorijama poput mliječnih, tamnih i bijelih čokolada, pralina, posebnih ponuda i dekorativnih figura. Na taj način omogućeno je kvalitetnije testiranje SQL upita, filtriranja proizvoda po kategorijama i izrade pogleda nad bazom podataka.


&nbsp;


### 5.6 Pohranjena procedura za automatsko generiranje narudzba

Pohranjene procedure su unaprijed definirani SQL programi koji se spremaju unutar baze podataka i mogu se pozivati po potrebi. One omogućuju automatizaciju složenijih operacija koje uključuju više SQL naredbi, petlje, uvjete i rad s varijablama. One su u MySQL-u ekvivalentne funckijama iz drugih programskih jezika poput Pythona, C++-a i JavaScripta.

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
```

&nbsp;

Ova pohranjena procedura služi za automatsko generiranje testnih podataka u bazi podataka sustava za narudžbe. U ovoj implementaciji procedura generira ukupno 60 narudžbi, pri čemu svaka narudžba sadrži 3 stavke narudžbe. Na taj način se automatski popunjava veća količina realističnih testnih podataka bez potrebe za ručnim unosom.

Procedura redom:

- generira nasumične kupce
  
- dohvaća njihove pripadajuće adrese
  
- stvara nove narudžbe
  
- generira stavke narudžbi s nasumično odabranim proizvodima i količinama
  
- izračunava ukupan iznos svake narudžbe



```sql
DELIMITER $$

...

END $$

DELIMITER ;
```

&nbsp;

Delimiter je znak ili niz znakova koji označava kraj SQL naredbe. U MySQL-u se delimiter postavlja ili mijenja pomoću naredbe `DELIMITER`. Prije definiranja procedure potrebno je promijeniti standardni delimiter `;` u neki drugi simbol, primjerice `$$`, pomoću naredbe `DELIMITER $$`. Na kraju procedure naredba završava s `END $$`, nakon čega se delimiter vraća na standardni `;` pomoću naredbe `DELIMITER` ;.

Ovo je potrebno zato što MySQL standardno koristi `;` kao završetak SQL naredbe, što funkcionira kod jednostavnih upita koji sadrže samo jednu naredbu. Međutim, procedure sadrže više SQL naredbi koje također završavaju znakom `;`, pa je potrebno definirati drugačiji delimiter kako bi MySQL znao gdje procedura završava.


```sql
CREATE PROCEDURE generiraj_narudzbe()
BEGIN
```
 
Pomoću naredbe `CREATE PROCEDURE `definira se nova pohranjena procedura naziva `generiraj_narudzbe()`.

Naredba `BEGIN` označava početak procedure, a sve SQL naredbe koje pripadaju proceduri nalaze se između blokova `BEGIN` i `END`.


&nbsp;


```sql
DECLARE id_narudzbe INT;
DECLARE i INT DEFAULT 1;
DECLARE j INT DEFAULT 1;
DECLARE random_kupac INT;
DECLARE random_proizvod INT;
DECLARE random_kolicina INT;
```

Sljedeći korak u proceduri je deklaracija varijabli koje će se koristiti tijekom izvođenja procedure. Varijable se deklariraju pomoću naredbe `DECLARE`, a osnovna struktura deklaracije izgleda ovako:

`DECLARE ime_varijable tip_podatka [DEFAULT zadana_vrijednost];`

| Dio             | Opis                                   |
| --------------- | -------------------------------------- |
| `DECLARE`       | Ključna riječ za deklaraciju varijable |
| `ime_varijable` | Naziv varijable                        |
| `tip_podatka`   | Tip podatka koji varijabla sprema      |
| `DEFAULT`       | Opcionalna zadana vrijednost           |


&nbsp;


U ovoj proceduri koriste se sljedeće varijable:

- **id_narudzbe** sprema ID novokreirane narudžbe
  
- **i** i **j** - služe kao brojači petlji i imaju `DEFAULT` vrijednost 1 jer petlje kreću od prve iteracije

- **random_kupac** - sprema nasumično odabrani ID kupca

- **random_proizvod** - sprema nasumično odabrani ID proizvoda

- **random_kolicina** - sprema nasumično generiranu količinu proizvoda


&nbsp;


```sql
WHILE i <= 60 DO

...

END WHILE;
```

Ovim dijelom započinje glavna `WHILE` petlja koja izvršava sve naredbe između `WHILE` i END `WHILE`. Uvjet `i <= 60` određuje koliko će se puta petlja izvršiti. U ovom slučaju procedura generira ukupno 60 narudžbi. Ako bi se željelo generirati 100 narudžbi, uvjet bi bio `i <= 100`. Naredba `END WHILE` označava kraj iteracije, nakon čega MySQL ponovno provjerava uvjet. Petlja se izvršava sve dok je uvjet zadovoljen.

&nbsp;

```sql
SET random_kupac = FLOOR(1 + RAND() * 32);
```


Pomoću naredbe `SET` dodjeljuje se vrijednost varijabli `random_kupac`. Ova naredba generira nasumičan broj između 1 i 32 te ga sprema u varijablu `random_kupac`. Dobiveni broj predstavlja ID nasumično odabranog kupca iz tablice kupac. Za generiranje nasumičnog broja koriste se funkcije:

**RAND()** – generira slučajni decimalni broj između 0 i 1
**FLOOR()** – uklanja decimalni dio broja i vraća cijeli broj

Izraz `RAND() * 32` generira decimalni broj između 0 i 32 (npr. 8.47). Dodavanjem vrijednosti 1 raspon se pomiče na 1–33 (npr. 9.47), dok `FLOOR()` uklanja decimalni dio i vraća cijeli broj između 1 i 32 (npr. 9). 

Važno je napomenuti da ova procedura pretpostavlja da tablica `kupac` sadrži ID-eve u rasponu od 1 do 32. Kada bi u tablici postojali ID-evi izvan tog raspona, procedura bi jedino mogla dohvatiti prvih 32 kupaca.


&nbsp;


```sql
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
```

Nakon što je generirani kupac, moguće je umetnuti novu narudžbu u tablicu `narudzba`. Podaci se umeću pomoću naredbi `INSERT INTO` i `VALUES`. Za stupce `kupac_id` koristi se prethodno generirana vrijednost `random_kupac`, a vrijednost stupca `datum_narudzbe` generira se pomoću izraza `DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*60) DAY)` koji generira datum koji je između 0 i 60 dana udaljen od trenutnog datuma.

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

Vrijednost stupca `status` postavlja se na 'Završena' jer procedura simulira već izvršene narudžbe, a vrijednost za `cijena_dostave` se generira pomoću izraza `ROUND(2 + (RAND() * 5), 2)`. U ovom slučaju, `2 + (RAND() * 5)` generira broj između 2 i 7 i pomoću funkcije `ROUND()` se taj broj zaokružuje na dvije decimale.

&nbsp;

```sql
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
```

Nakon stvaranja narudžbe potrebno je generirati njezine stavke. ID posljednje umetnute narudžbe dohvaća se pomoću funkcije `LAST_INSERT_ID()` te se sprema u varijablu `id_narudzbe`. Unutarnjoj kontrolnoj varijabli `j` potrebno je ponovno dodijeliti početnu vrijednost 1, iako ona već ima definiranu `DEFAULT` vrijednost. Razlog je dinamika u ponašanju ugniježđenih petlji. Unutarnja WHILE petlja `WHILE j <= 3 DO` koja generira stavke narudžbe izvršava se tri puta i nakon završetka te petlje, vrijednost varijable `j` ostaje 3. U sljedećoj iteraciji vanjske petlje `WHILE i <= 60 DO`, vrijednost `j` se ne resetira automatski, pa uvjet `j <= 3` više nije zadovoljen i unutarnja petlja se ne izvršava. Zbog toga je nužno resetirati brojač `j` na početnu vrijednost 1 prije svake nove iteracije unutarnje petlje.

Tijekom svake iteracije unutarnje petlje `WHILE j <= 3 DO` generiraju se nasumični ID proizvoda i nasumična količina proizvoda. Varijabla `random_proizvod` dobiva vrijednost između 1 i 30, dok `random_kolicina` dobiva vrijednost između 1 i 3. Na taj način svaka narudžba dobiva tri stavke s različitim proizvodima i količinama.


&nbsp;
 
```sql
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
```

Za razliku od prethodnih `INSERT` naredbi koje koriste `VALUES`, ovdje se koristi kombinacija `INSERT IGNORE INTO ... SELECT`. Takav pristup omogućuje dohvaćanje podataka direktno iz druge tablice i njihovo umetanje u novu tablicu unutar iste naredbe. `INSERT IGNORE INTO stavka_narudzbe` definira tablicu u koju će se umetnuti podaci, dok `SELECT` dio određuje koje će se vrijednosti umetnuti. Koirsti se `IGNORE` klauzula, kako se ne bi dohvatali podaci za proizvode koji su već dodani kao stvake narudžbe.

U `FROM proizvod p` dijelu dohvaćaju se podaci iz tablice proizvod, pri čemu je p alias (skraćeni naziv) za tablicu proizvod. Alias služi za kraće i preglednije pisanje naziva stupaca, pa umjesto `proizvod.cijena` možemo pisati `p.cijena`. Uvjet `WHERE p.proizvod_id = random_proizvod` osigurava da se iz tablice proizvod dohvati točno taj proizvod čiji ID je jednak nasumično generiranom ID-u spremljenom u varijabli `random_proizvod`.

Vrijednosti koje se umeću u tablicu `stavka_narudzbe` su:

| Vrijednost                   | Opis                                           |
| ---------------------------- | ---------------------------------------------- |
| `id_narudzbe`                | ID trenutno generirane narudžbe                |
| `p.proizvod_id`              | ID nasumično odabranog proizvoda               |
| `random_kolicina`            | Nasumično generirana količina proizvoda        |
| `p.cijena`                   | Stvarna cijena proizvoda iz tablice `proizvod` |


&nbsp;


Na kraju petlje koristi se `SET j = j + 1` što povećava brojač unutarnje petlje i omogućuje prelazak na generiranje sljedeće stavke narudžbe. Kada vrijednost `j` postane veća od 3, unutarnja `WHILE` petlja završava i procedura nastavlja s generiranjem sljedeće narudžbe.


&nbsp;


```sql
CALL generiraj_narudzbe();
```

Nakon što je procedura definirana i spremljena u bazu podataka, može se pokrenuti pomoću naredbe `CALL`. Naredba poziva pohranjenu proceduru `generiraj_narudzbe()` i izvršava sve SQL naredbe koje se nalaze unutar nje.


&nbsp;


### 5.7 Popuna relacije placanje

```sql
INSERT INTO placanje (narudzba_id, nacin_placanja, status_placanja, datum_placanja)
SELECT 
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal'),
    'placeno',
    datum_narudzbe + INTERVAL FLOOR(RAND()*2) DAY
FROM narudzba;
```

Popuna podataka u relaciji **placanje** vrši se pomoću naredbe `INSERT INTO ... SELECT`. Za razliku od prethodnih relacija gdje su vrijednosti unesene ručno, ovdje se podaci automatski generiraju na temelju postojećih podataka iz relacije `narudzba`. Svako plaćanje povezano je s jednom narudžbom pomoću atributa `narudzba_id`.

Atributi relacije imaju sljedeću svrhu:

- **narudzba_id** - označava kojoj narudžbi pripada plaćanj

- **nacin_placanja** - način kojim je kupac izvršio plaćanje

- **status_placanja** - status izvršenog plaćanja

- **datum_placanja** - datum kada je plaćanje izvršeno

Za generiranje nasumičnog načina plaćanja koristi se funkcija:

```sql
ELT(FLOOR(1 + RAND()*3), 'Kartica', 'Pouzećem', 'PayPal')
```

Funkcija `RAND()` generira slučajni broj, dok `ELT()` na temelju tog broja odabire jednu od ponuđenih vrijednosti. Datum plaćanja generira se dodavanjem 0–1 dana na datum narudžbe kako bi podaci realistično prikazivali proces online kupovine.


&nbsp;


### 5.8 Popuna relacije dostava

```sql
INSERT INTO dostava (narudzba_id, kurirska_sluzba, broj_posiljke, status_dostave, procijenjeni_datum, stvarni_datum)
SELECT
    narudzba_id,
    ELT(FLOOR(1 + RAND()*3), 'DHL', 'GLS', 'HP'),
    CONCAT('HR', FLOOR(100000 + RAND()*900000)),
    'dostavljeno',
    DATE(datum_narudzbe + INTERVAL 3 DAY),
    DATE(datum_narudzbe + INTERVAL 2 + FLOOR(RAND()*2) DAY)
FROM narudzba;
```

Popuna relacije **dostava** također koristi `INSERT INTO ... SELECT` pristup kojim se podaci generiraju na temelju postojećih narudžbi. Ova relacija sadrži informacije o dostavi svake narudžbe. Atributi relacije imaju sljedeću svrhu:

- **narudzba_id** - označava kojoj narudžbi pripada dostava

- **kurirska_sluzba** - naziv dostavne službe

- **broj_posiljke** - jedinstveni broj pošiljke

- **status_dostave** - trenutno stanje dostave

- **procijenjeni_datum** - očekivani datum dostave

- **stvarni_datum** - datum kada je pošiljka stvarno dostavljena

Kurirska služba bira se nasumično pomoću funkcije `ELT()`, dok se broj pošiljke generira pomoću `CONCAT()` funkcije koja spaja prefiks `"HR"` i slučajno generirani broj.  Procijenjeni datum dostave postavljen je tri dana nakon datuma narudžbe, dok stvarni datum dostave može odstupati za jedan dan kako bi podaci izgledali realističnije.


&nbsp;


### 5.9 Popuna relacije nabava

```sql
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
```

Relacija **nabava** sadrži podatke o nabavi proizvoda od dobavljača. Svaka nabava predstavlja jednu zaprimljenu pošiljku robe.

Atributi relacije imaju sljedeću svrhu:

- **nabava_id** - jedinstveni identifikator nabave

- **dobavljac_id** - označava od kojeg dobavljača dolazi nabava

- **datum_nabave** - datum kada je nabava izvršena

- **status_nabave** - stanje nabave


Datumi nabave generirani su pomoću `NOW()` funkcije i vremenskih intervala kako bi podaci predstavljali nabave izvršene u prošlosti.


&nbsp;


### 5.11 Popuna relacije stavka_nabave

```sql
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
```

Relacija **stavka_nabave** predstavlja pojedinačne proizvode koji pripadaju određenoj nabavi. Ova relacija ostvaruje vezu između tablica `nabava` i `proizvod`.

Atributi relacije imaju sljedeću svrhu:

- **nabava_id** - označava kojoj nabavi pripada stavka

- **proizvod_id** - označava koji je proizvod nabavljen

- **kolicina** - količina nabavljenog proizvoda

- **nabavna_cijena** - cijena po kojoj je proizvod nabavljen

Podaci su uneseni ručno kako bi se simulirala stvarna nabava različitih proizvoda od različitih dobavljača.


&nbsp;


### 5.12 Popuna relacije recenzija

```sql
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
```

Relacija **recenzija** sadrži korisničke recenzije i ocjene proizvoda. Ova relacija omogućuje prikaz povratnih informacija kupaca i analizu zadovoljstva proizvodima. Svaka recenzija povezana je s jednim kupcem i jednim proizvodom pomoću stranih ključeva `kupac_id` i `proizvod_id`. Atributi relacije imaju sljedeću svrhu:

- **kupac_id** - označava autora recenzije

- **proizvod_id** - označava proizvod koji se recenzira

- **ocjena** - brojčana ocjena proizvoda

- **komentar** - tekstualni komentar kupca

- **datum_recenzije** - datum i vrijeme recenzije

Prilikom popune korištene su različite ocjene i komentari kako bi podaci djelovali realističnije i omogućili kvalitetnije testiranje agregacijskih SQL funkcija poput `AVG()`, `COUNT()` i filtriranja recenzija po proizvodima.


&nbsp;


## 6. Upiti (Andrej Pucović i Danijel Margić)

SQL upiti *(eng. queries)* predstavljaju naredbe kojima se dohvaćaju, filtriraju, grupiraju i prikazuju podaci iz baze podataka. Najčešće se zadaju pomoću naredbe `SELECT`, kojom se određuje koji atributi i podaci će biti prikazani iz jedne ili više tablica. Upiti mogu uključivati različite operacije poput filtriranja podataka pomoću `WHERE`, sortiranja pomoću `ORDER BY`, grupiranja pomoću `GROUP BY` te povezivanja više tablica korištenjem JOIN operacija. Također omogućavaju izvođenje računskih operacija nad podacima, poput zbrajanja, oduzimanja, množenja i dijeljenja vrijednosti atributa. SQL je deklarativni jezik, što znači da korisnik definira koje podatke želi dohvatiti, dok način i proceduru dohvaćanja podataka određuje sam DBMS *(DataBase Management System)*, odnosno sustav za upravljanje bazom podataka. Za razliku od relacijske algebre, gdje se mora definirati redoslijed operacija za dobivanje rezultata, kod SQL-a korisnik navodi samo željeni rezultat, dok je za izvršavanje upita zaslužan DBMS, konkretno u našem slučaju MySQL. Upiti omogućavaju jednostavan i učinkovit dohvat relevantnih informacija iz baze podataka.

Općenita sintaksa za kreiranje SQL upita je:

```sql
SELECT A1, A2, ...
FROM r1, r2, ...
WHERE P;
```

pri čemu `A1, A2` predstavljaju atribute (stupce), `r1, r2` relacije (tablice), a `P` predikat selekcije.

&nbsp;

### 6.1 Upit: Ukupan broj narudžbi i potrošnja po kupcu (Andrej Pucović)

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

Ovaj upit prikazuje ukupan broj narudžbi, ukupnu potrošnju i prosječnu vrijednost narudžbe za svakog kupca. Povezuju se relacije `kupac` i `narudzba`, a podaci se grupiraju prema kupcu korištenjem naredbe `GROUP BY`. Agregacijske funkcije `COUNT`, `SUM` i `AVG` koriste se za izračun broja narudžbi, ukupne potrošnje i prosječne vrijednosti narudžbe. Uvjet `HAVING` koristi se za prikaz samo kupaca koji imaju barem jednu narudžbu. Upit je koristan za analizu kupaca i prepoznavanje najaktivnijih kupaca trgovine.


&nbsp;


### 6.2 Upit: Najprodavaniji proizvodi po količini i prihodu (Andrej Pucović)

```sql
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
```

Ovaj upit prikazuje proizvode koji su ostvarili najveću prodaju prema količini prodanih proizvoda i ukupnom prihodu. Povezuju se relacije `proizvod`, `kategorija` i `stavka_narudzbe`, a podaci se grupiraju prema proizvodu i kategoriji. Agregacijska funkcija `SUM` koristi se za izračun ukupno prodane količine i ukupnog prihoda proizvoda. Rezultati su sortirani prema količini prodaje i prihodu, dok se pomoću `LIMIT` prikazuje samo prvih pet proizvoda. Upit je koristan za analizu najuspješnijih proizvoda u trgovini.


&nbsp;


### 6.3 Upit: Proizvodi koji nisu prodani (Andrej Pucović)

```sql
SELECT 
    p.proizvod_id,
    p.naziv,
    p.cijena,
    p.kolicina_na_skladistu
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
WHERE sn.proizvod_id IS NULL
ORDER BY p.naziv;
```

Ovaj upit prikazuje proizvode koji se ne pojavljuju ni u jednoj narudžbi kupaca. Koristi se `LEFT JOIN` između relacija `proizvod` i `stavka_narudzbe`, dok uvjet `IS NULL` služi za pronalazak proizvoda bez povezanih zapisa u stavkama narudžbe. Rezultati se sortiraju prema nazivu proizvoda. Upit je koristan za prepoznavanje proizvoda koji se ne prodaju te može pomoći pri analizi ponude i upravljanju skladištem.


&nbsp;


### 6.4 Upit: Kupci čija je potrošnja veća od prosjeka (Andrej Pucović)

```sql
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
```

Ovaj upit prikazuje kupce čija je ukupna potrošnja veća od prosječne potrošnje svih kupaca. U unutarnjem upitu računa se ukupna potrošnja po kupcu, a zatim se u vanjskom upitu prikazuju samo oni kupci čija je potrošnja veća od prosječne vrijednosti. Koriste se ugniježđeni podupiti, agregacijska funkcija `SUM`, funkcija `AVG` te grupiranje podataka po kupcu. Upit je koristan za prepoznavanje kupaca koji ostvaruju iznadprosječnu vrijednost kupovine.


&nbsp;


### 6.5 Upit: Mjesečni prihod trgovine (Andrej Pucović)

```sql
SELECT 
    YEAR(datum_narudzbe) AS godina,
    MONTH(datum_narudzbe) AS mjesec,
    COUNT(*) AS broj_narudzbi,
    ROUND(SUM(ukupan_iznos), 2) AS mjesecni_prihod,
    ROUND(AVG(ukupan_iznos), 2) AS prosjecna_narudzba
FROM narudzba
GROUP BY YEAR(datum_narudzbe), MONTH(datum_narudzbe)
ORDER BY godina, mjesec;
```

Ovaj upit prikazuje broj narudžbi, ukupni prihod i prosječnu vrijednost narudžbe po mjesecima. Podaci se dohvaćaju iz relacije `narudzba`, a funkcije `YEAR` i `MONTH` koriste se za grupiranje podataka prema godini i mjesecu narudžbe. Agregacijske funkcije `COUNT`, `SUM` i `AVG` omogućavaju analizu prodaje kroz određena vremenska razdoblja. Upit je koristan za praćenje poslovanja trgovine i analizu mjesečnih prihoda.


&nbsp;


### 6.6 Upit : Usporedba prodajne cijene i zadnje nabavne cijene po komadu (Danijel Margić)

```sql
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
```
#### rezultat Upit a:
![Moja slika](slike/slikaRezUpit a1.png)

Ovaj upit služi za procjenu profitabilnosti proizvoda tako što uspoređuje njihovu prodajnu cijenu s prosječnom nabavnom cijenom. Podaci se preuzimaju iz tablice `proizvod`, a zatim se pomoću `INNER JOIN` spajaju sa zapisima iz tablice `stavka_nabave`, pri čemu se spajanje vrši preko relacije `p.proizvod_id = sn.proizvod_id`. Na taj način u analizu ulaze samo proizvodi koji imaju evidentirane nabave. Nad stupcem `sn.nabavna_cijena` primjenjuje se agregatna funkcija `AVG` kako bi se izračunala prosječna nabavna cijena za svaki proizvod. Nakon toga određuje se profit po komadu kao razlika između prodajne cijene iz tablice proizvod i izračunate prosječne nabavne cijene. Iz istih vrijednosti računa se i marža u postotku, koja pokazuje koliki dio prodajne cijene predstavlja zarada. Budući da se koriste agregatne funkcije, podaci se grupiraju prema identifikatoru, nazivu i prodajnoj cijeni proizvoda, što omogućuje da svaki proizvod bude prikazan kao jedan agregirani zapis. Rezultati se zatim sortiraju tako da se proizvodi s najvećom maržom nalaze na vrhu, čime upit omogućuje brzi uvid u najprofitabilnije artikle i potencijalne prilike za optimizaciju cijena ili nabavne strategije.


&nbsp;


### 6.7 Upit: Ukupna zarada, broj narudžbi i prosječna vrijednost košarice po kategorijama (Danijel Margić)

```sql
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
```
#### Rezultat upita:
![Rezultat upita 2](slike/slikaRezUpita2.png)

Ovaj upit služi za identifikaciju najprofitabilnijih segmenata asortimana kroz analizu prodajnih rezultata na razini kategorija proizvoda. Podaci se povezuju iz triju različitih relacija pomoću višestruke operacije `INNER JOIN`. Prvo se spajaju relacije `kategorija` i `proizvod` preko zajedničkog identifikatora kategorije, a zatim se rezultat povezuje s relacijom `stavka_narudzbe` preko surogatnog ključa proizvoda. Time se osigurava referencijski integritet i obuhvaćaju samo oni artikli koji su zapravo prodani. 

Nad atributom `sn.narudzba_id` primjenjuje se funkcija `COUNT(DISTINCT)` koja prebrojava unikatne n-torke narudžbi unutar multiskupa i eliminira duplikate nastale zbog više stavki u istoj košarici. Agregacijska funkcija `SUM` koristi se nad domenom atributa količine i ukupne cijene stavki kako bi izračunala ukupan volumen prodaje i ukupni ostvareni prihod. Istovremeno, funkcija `AVG` računa srednju vrijednost pojedinačnih stavki u narudžbi, zaokruženu funkcijom `ROUND` na dvije decimale. Svi prikupljeni transakcijski podaci grupiraju se (`GROUP BY`) prema nazivu i identifikatoru kategorije, što omogućuje sažeti prikaz performansi svake skupine proizvoda. Rezultati se sortiraju silazno prema ukupnom prihodu (`ORDER BY ... DESC`), uvid u to koje kategorije čokolada generiraju najveći promet na platformi.


&nbsp;


### 6.8 Upit: Kontrola kvalitete asortimana kroz najbolje ocijenjene proizvode (Danijel Margić)

```sql
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
```

#### Rezultat upita:
![Rezultat upita 3](slike/slikaRezUpita3.png)

Ovaj upit služi za kontrolu kvalitete asortimana i izdvajanje artikala s najvišim povjerenjem kupaca, što omogućuje prepoznavanje "bestsellera". Podaci se preuzimaju iz referencirane relacije `proizvod` i povezuju pomoću operacije `INNER JOIN` s n-torkama iz referencirajuće relacije `recenzija`, pri čemu se spajanje vrši preko zajedničkog surogatnog ključa `p.proizvod_id = r.proizvod_id`. Na taj način u analizu ulaze samo oni artikli koji su dobili povratne informacije od klijenata. 

Nad domenom atributa `r.ocjena` primjenjuje se agregatna funkcija `AVG` kako bi se izračunala prosječna ocjena za svaki proizvod, zaokružena funkcijom `ROUND` na dvije decimale radi preciznosti. Istovremeno, funkcija `COUNT` prebrojava unikatne n-torke unutar atributa `r.recenzija_id` radi utvrđivanja ukupnog broja ocjena. Budući da se koriste agregatne funkcije nad multiskupovima, podaci se grupiraju (`GROUP BY`) prema identifikatoru, nazivu i cijeni proizvoda. Ključni dio upita je primjena klauzule `HAVING` koja vrši restrikciju skupina i propušta samo proizvode s barem dvije zaprimljene recenzije, čime se eliminiraju artikli s nerealno visokim ocjenama na temelju samo jednog glasa. Rezultati se sortiraju primarno prema prosječnoj ocjeni silazno (`DESC`), a sekundarno prema broju recenzija, pružajući jasan uvid u najkvalitetnije i najpopularnije proizvode na platformi.


&nbsp;


### 6.9 Upit: Upravljanje skladištem i identifikacija kritičnih zaliha popularnih artikala (Danijel Margić)

```sql
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
```

#### Rezultat upita:
![Rezultat upita 4](slike/slikaRezUpita4.png)

Ovaj upit služi za upravljanje skladištem i pravovremenu identifikaciju artikala koji su traženi na tržištu, ali su im zalihe kritično niske u usporedbi s prosjekom trgovine. Podaci se polazno povlače iz referencirane relacije `proizvod` i povezuju preko operacije `INNER JOIN` s n-torkama iz referencirajuće relacije `stavka_narudzbe` pomoću surogatnog ključa `p.proizvod_id = sn.proizvod_id`. Time se osigurava da se u analizu uključe isključivo proizvodi koji imaju ostvarenu prodaju. 

Ključni dio upita nalazi se u klauzuli `WHERE` koja vrši restrikciju na razini n-torki pomoću ugniježđenog skalarnog podupita. Taj podupit izračunava srednju vrijednost domene atributa `kolicina_na_skladistu` za sve aktivne artikle pomoću funkcije `AVG`. Glavni upit potom kroz operaciju selekcije propušta samo one proizvode čija je pojedinačna zaliha strogo manja od tog izračunatog prosjeka. Agregacijska funkcija `SUM` zbraja količine unutar multiskupa atributa `sn.kolicina` kako bi prikazala ukupan broj prodanih komada. Podaci se grupiraju (`GROUP BY`) prema identifikatoru, nazivu i stanju zaliha proizvoda, što omogućuje čisti pregled po svakom artiklu. Rezultati se sortiraju uzlazno (`ASC`) prema količini na skladištu, postavljajući najugroženije proizvode s kritičnim zalihama na sam vrh liste kako bi voditelj nabave odmah znao što treba ponovno naručiti od dobavljača.


&nbsp;


### 6.10 Upit: Analiza prometa asortimana (Danijel Margić)

```sql
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
```

#### Rezultat upita:
![Rezultat upita 5](slike/slikaRezUpita5.png)

Ovaj upit služi za  analizu prometa asortimana s ciljem identifikacije proizvoda koji slabije rotiraju ili se uopće ne prodaju, kako bi se donijele odluke o popustima ili povlačenju robe. Za razliku od standardnog spajanja, ovaj upit polazi od relacije `proizvod` i povezuje se s n-torkama iz relacije `stavka_narudzbe` pomoću operacije lijevog vanjskog spajanja (**`LEFT JOIN`**). Svrha ove operacije je očuvanje svih n-torki iz lijeve relacije (`proizvod`), čak i ako za njih ne postoji niti jedan zapis o prodaji u desnoj relaciji. Za takve neprodane artikle, sustav privremeno inicijalizira vrijednosti kao `null`.

U fazi projekcije nad multiskupovima, funkcija `SUM` zbraja količine i ukupne prihode. Ključni element je primjena funkcije `COALESCE`, koja provodi generaliziranu projekciju i automatski zamjenjuje nastale `null` vrijednosti s konstantom `0` za sve proizvode bez realiziranog prometa. Podaci se grupiraju (`GROUP BY`) prema identifikatoru, unikatnom prirodnom ključu `SKU` i nazivu artikla. Rezultati se sortiraju uzlazno (`ORDER BY ... ASC`) prema broju prodanih komada. Na taj način, upit na samom vrhu tablice  prikazuje čokolade koje nitko nije kupio.


&nbsp;


## 7. Pogledi (Luka Wrana, Andrej Pucović, Danijel Margić)

Pogledi *(eng. views)* u SQL-u predstavljaju virtualne tablice koje su stvorene na temelju rezultata nekog `SELECT` upita. Pogled ne pohranjuje podatke zasebno, već prikazuje podatke koji se dohvaćaju iz jedne ili više tablica baze podataka. Stvaraju se pomoću naredbe `CREATE VIEW`, pri čemu se definira upit koji će pogled predstavljati. Pogledi se često koriste za pojednostavljenje složenih upita koji uključuju JOIN operacije, agregacije i filtriranje podataka. Pogledi se mogu promatrati kao spremljeni SELECT upiti koji omogućavaju ponovno korištenje često korištenih i složenih upita bez potrebe njihovog ponovnog pisanja. Također omogućavaju ograničavanje pristupa podacima jer se korisnicima mogu prikazati samo određeni stupci tablice, bez prikazivanja osjetljivih podataka (npr. lozinke, OIB, email adrese, broj računa i osobni podaci korisnika). Nakon stvaranja, pogled se može koristiti u `SELECT` naredbama kao obična tablica.

Općenita sintaksa za kreiranje SQL pogleda je:

```sql
CREATE VIEW view_name AS
SELECT A1, A2, ...
FROM r1, r2, ...
WHERE P;
```

pri čemu `view_name` predstavlja naziv pogleda, `A1, A2` atribute koji će biti prikazani, `r1, r2` relacije (tablice), a `P` predikat selekcije.


&nbsp;


### 7.1 Pogled: Proizvodi po ukupnom prihodu (Luka Wrana)

```sql
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
```

Ovaj pogled služi za analizu prihoda koje je svaki proizvod ostvario tijekom posljednjih mjesec dana. Podaci se dohvaćaju iz relacija `proizvod`, `stavka_narudzbe` i `narudzba`, koje se povezuju pomoću `JOIN` naredbi kako bi se svaki proizvod povezao s pripadajućim stavkama narudžbi i informacijama o narudžbama.

Ukupan prihod računa se množenjem količine proizvoda s cijenom po komadu za svaku stavku narudžbe, nakon čega se sve vrijednosti zbrajaju pomoću funkcije `SUM()`. Rezultati se grupiraju po proizvodu kako bi svaki proizvod imao svoj ukupni ostvareni prihod.

Pogled uključuje samo narudžbe iz posljednjih mjesec dana te omogućuje prikaz proizvoda sortiranih od najvećeg prema najmanjem prihodu. Takva analiza korisna je za prepoznavanje najprofitabilnijih proizvoda, praćenje prodajnih trendova i donošenje poslovnih odluka vezanih uz cijene, promocije i nabavu.


&nbsp;


### 7.2 Pogled: Popularnost proizvoda po ukupnoj količini narudžba (Luka Wrana)

```sql
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
```

Ovaj pogled koristi se za analizu popularnosti proizvoda na temelju ukupne prodane količine tijekom posljednjih mjesec dana. Za razliku od prethodnog pogleda koji je fokusiran na financijski prihod, ovdje je naglasak na količini prodanih proizvoda.

Pogled povezuje relacije `proizvod`, `stavka_narudzbe` i `narudzba`, a ukupna količina svakog proizvoda računa se zbrajanjem svih prodanih jedinica pomoću funkcije `SUM()`. Rezultati se grupiraju po proizvodu kako bi bilo moguće prikazati ukupnu prodanu količinu za svaki pojedini proizvod.

Analiza uključuje samo novije narudžbe iz posljednjih mjesec dana, a rezultati se sortiraju prema najvećoj prodanoj količini. Takav pogled koristan je za planiranje zaliha, optimizaciju skladišta i prepoznavanje proizvoda s najvećom potražnjom.


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
JOIN stavka_narudzbe sn 
    ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n 
    ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM koeficijent_kolicine_po_proizvodu
ORDER BY prosjecna_kolicina_po_narudzbi DESC;
```

Ovaj pogled služi za analizu prosječne količine proizvoda po narudžbi, odnosno za prepoznavanje proizvoda koji se najčešće kupuju u većim količinama. Cilj pogleda je identificirati proizvode koji imaju najveći potencijal za bulk-prodaju.

Pogled koristi podatke iz `relacija proizvod`, `stavka_narudzbe` i `narudzba`. Za svaki proizvod računa se ukupna prodana količina te broj različitih narudžbi u kojima se proizvod pojavljuje. Na temelju tih vrijednosti izračunava se prosječna količina proizvoda po jednoj narudžbi.

Rezultati se sortiraju prema najvećoj prosječnoj količini po narudžbi, što omogućuje jednostavno prepoznavanje proizvoda koje kupci često naručuju u većim količinama. Takva analiza korisna je za planiranje promotivnih paketa, optimizaciju skladišta i donošenje poslovnih odluka vezanih uz bulk-prodaju.


&nbsp;


### 7.4 Pogled: Aktivni kupci s osnovnim podacima (Andrej Pucović)

```sql
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
```

Ovaj pogled prikazuje osnovne informacije o aktivnim kupcima unutar sustava. Podaci se dohvaćaju iz relacije `kupac`, pri čemu se pomoću uvjeta `WHERE` prikazuju samo kupci koji su označeni kao aktivni. Pogled ne prikazuje lozinku kupca, čime se ograničava prikaz osjetljivih podataka.


&nbsp;


### 7.6 Pogled: Proizvodi i njihove kategorije (Andrej Pucović)

```sql
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
```

Ovaj pogled prikazuje proizvode zajedno s pripadajućim kategorijama. Koristi se `RIGHT JOIN` kako bi se prikazale i kategorije koje trenutno možda nemaju nijedan proizvod. Na taj način pogled nije ograničen samo na postojeće proizvode, nego daje širi pregled kategorija i povezanih proizvoda.


&nbsp;


### 7.7 Pogled: Detalji narudžbi (Andrej Pucović)

```sql
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
```

Ovaj pogled prikazuje informacije o narudžbama, kupcima i adresama dostave. Povezuju se relacije `narudzba`, `kupac` i `adresa`, čime se dobiva pregled važnih podataka vezanih uz narudžbu. Pogled ne prikazuje osjetljive podatke poput lozinke kupca.


&nbsp;


### 7.8 Pogled: Stavke narudžbi (Andrej Pucović)

```sql
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
```

Ovaj pogled prikazuje stavke narudžbi zajedno s nazivom proizvoda. Koristi se `JOIN` s dodatnim uvjetom usporedbe, odnosno theta join uvjetom, gdje se prikazuju samo stavke čija je ukupna cijena veća od cijene po komadu. Time se izdvajaju stavke kod kojih je naručena količina veća od jednog komada.


&nbsp;


### 7.9 Pogled: Plaćanja narudžbi (Andrej Pucović)

```sql
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
```

Ovaj pogled prikazuje plaćanja zajedno s osnovnim podacima o narudžbi i kupcu. Povezuju se relacije `placanje`, `narudzba` i `kupac`, čime se dobiva korisniji pregled od samog prikaza relacije `placanje`. Pogled je koristan za praćenje načina plaćanja, statusa plaćanja i kupca koji je vezan uz narudžbu.


&nbsp;


### 7.10 Pogled: Prikaz ukupne potrošnje i aktivnosti po kupcima (Danijel Margić)

```sql
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
```

```sql
-- Pozivanje pogleda uz sortiranje po ukupnoj potrošnji silazno
SELECT * FROM v_pregled_potrosnje_kupaca 
ORDER BY ukupno_potroseno DESC;
```
#### Rezultat pogleda:
![Rezultat upita 5](slike/slikaRezPogled1.png)

Ovaj pogled sluzi da se brzo vidi potrošačke navike i vjernost kupaca bez stalnog pisanja složenih upita. Podaci se povlače iz bazne relacije `kupac` i povezuju s n-torkama iz transakcijske relacije `narudzba`. U upitu se koristi operacija lijevog vanjskog spajanja (**`LEFT JOIN`**), čime se osigurava da u rezultirajuću izvedenu relaciju uđu svi registrirani kupci, uključujući i one pasivne koji još nemaju niti jednu realiziranu transakciju. Za takve korisnike sustav privremeno inicijalizira vrijednosti kao `null`.

U sklopu generalizirane projekcije primjenjuje se funkcija `CONCAT` koja spaja tekstualne atribute imena i prezimena u jedno polje. Nad multiskupom atributa `n.narudzba_id` izvršava se agregatna funkcija `COUNT` radi dobivanja ukupnog broja kupnji. Istovremeno, funkcija `SUM` zbraja iznose unutar domene atributa `n.ukupan_iznos`. Ključni element unutar projekcije je funkcija `COALESCE` koja presreće `null` vrijednosti nastale kod pasivnih kupaca i automatski ih pretvara u konstantu `0`. Svi transakcijski pokazatelji grupiraju se (`GROUP BY`) prema surogatnom ključu kupca, njegovom e-mailu i punom imenu. Pozivanjem ovog pogleda uz završnu naredbu `ORDER BY ... DESC`, sustav prikazuje kupce sortirane tako da se oni koji su najviše potrošili nalaze na samom vrhu liste.


&nbsp;


### 7.11 Pogled: Pregled aktivnosti i troškova opskrbnog lanca (Danijel Margić)

```sql
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
```

#### Rezultat pogleda:
![Rezultat pogleda 2](slike/slikaRezPogled2.png)

Ovaj pogled pomaže kako bi se brzo provjerilo koliko često surađujemo s kojim dobavljačem i koliko smo im novca ukupno isplatili. Podaci se povezuju iz transakcijske relacije `nabava` i bazne relacije `dobavljac` pomoću operacije desnog vanjskog spajanja (**`RIGHT JOIN`**). Svrha ove operacije je da u konačnom pogledu sačuvamo apsolutno sve dobavljače iz baze podataka, čak i ako od nekoga još nismo napravili niti jednu narudžbu, pri čemu će sustav njihove prazne transakcijske podatke privremeno označiti kao `null`.

U fazi projekcije, funkcija `COUNT` prebrojava unikatne n-torke realiziranih nabava iz popisa transakcija. Agregacijska funkcija `SUM` zbraja sve izdatke unutar domene atributa `n.ukupan_iznos`. Kako se kod novih ili neaktivnih dobavljača u pogledu ne bi prikazivala prazna polja, funkcija `COALESCE` uspješno presreće nastale `null` vrijednosti i pretvara ih u jasnu konstantu `0`. Svi podaci se logički strukturiraju i grupiraju (`GROUP BY`) prema surogatnom ključu i nazivu dobavljača. Pozivanjem ovog pogleda uz završnu naredbu `ORDER BY ... DESC`, pogled na samom vrhu prikazuje partnere s kojima ostvarujemo najveći financijski promet, dok se na dnu nalze dobavljači s nula realiziranih narudžbi.


&nbsp;


### 7.12 Pogled: Prikaz volumena prodaje (Danijel Margić)

```sql
CREATE OR REPLACE VIEW v_analiza_popularnosti_proizvoda AS
SELECT 
    p.proizvod_id,
    p.naziv AS proizvod_naziv,
    COALESCE(SUM(sn.kolicina), 0) AS ukupno_prodanih_komada,
    COALESCE(SUM(sn.ukupna_cijena), 0) AS ukupni_ostvareni_prihod
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
GROUP BY p.proizvod_id, p.naziv;

-- Pozivanje pogleda uz sortiranje po prodanim komadima silazno
SELECT * FROM v_analiza_popularnosti_proizvoda 
ORDER BY ukupno_prodanih_komada DESC;
```

#### Rezultat pogleda:
![Rezultat pogleda 3](slike/slikaRezPogled3.png)

Ovaj pogledom se identificiraju najprodavaniji proizvodi u trgovini. Podaci se povlače iz bazne relacije `proizvod` i povezuju s n-torkama iz transakcijske relacije `stavka_narudzbe` pomoću operacije lijevog vanjskog spajanja (**`LEFT JOIN`**). Korištenje ovog spajanja jamči da će u konačnom rezulatu ostati sačuvani svi proizvodi iz kataloga, pa čak i oni novi artikli koji još nemaju niti jednu realiziranu prodaju, pri čemu će sustav njihove prazne podatke privremeno označiti kao `null`.

U fazi projekcije, agregacijska funkcija `SUM` koristi se nad domenom atributa `sn.kolicina` i `sn.ukupna_cijena` kako bi izračunala ukupan volumen prodaje i ukupni ostvareni prihod za svaku pojedinu čokoladu. Kako se kod neprodanih artikala u tablici ne bi prikazivala prazna polja, funkcija `COALESCE` uspješno presreće nastale `null` vrijednosti i pretvara ih u jasnu konstantu `0`. Svi transakcijski podaci grupiraju se (`GROUP BY`) prema surogatnom ključu i nazivu proizvoda. Pozivanjem ovog pogleda uz završnu naredbu `ORDER BY ... DESC`, sustav na samom vrhu tablice prikazuje najpopularnije artikle s najvećim prometom, pružajući uvid u uspješnost prodaje pojednog artikla.


&nbsp;


### 7.13 Pogled: Konsolidirani prikaz javnih recenzija i ocjena (Danijel Margić)

```sql
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

-- Pozivanje pogleda uz sortiranje po ocjenama uzlazno
SELECT * FROM v_javne_recenzije_proizvoda 
ORDER BY ocjena ASC;
```

#### Rezultat pogleda:
![Rezultat pogleda 4](slike/slikaRezPogled4.png)

Ovaj pogled da se na jednom mjestu brzo pregleda sve povratne informacije kupaca. Podaci se povezuju iz triju različitih relacija pomoću višestruke operacije `INNER JOIN`. Spajaju se n-torke iz relacije `recenzija` s relacijama `proizvod` i `kupac` preko pripadajućih primarnih i stranih ključeva, čime se jamči očuvanje referencijskog integriteta i točno povezuje tekstualni komentar s artiklom i autorom.

U sklopu generalizirane projekcije primjenjuje se funkcija `CONCAT` koja spaja tekstualne atribute imena i prezimena u jedinstveni izvedeni atribut `kupac_autor`. Pogled izravno propušta atribute surogatnog ključa recenzije, ocjene, komentara i datuma. Pozivanjem ovog pogleda uz završnu naredbu `ORDER BY ocjena ASC`, sustav na samom vrhu tablice prikazuje najslabije ocijenjene proizvode. To omogućuje trenutačnu identifikaciju kritičnih prigovora kupaca (poput otopljene čokolade ili neodgovarajućih okusa) i brzu reakciju radi poboljšanja usluge.


&nbsp;


### 7.14 Pogled: Operativni manifest za kurirske službe (Danijel Margić)

```sql
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
```

#### Rezultat pogleda:
![Rezultat pogleda 5](slike/slikaRezPogled5.png)

Ovaj pogled pomaže pakirnoj službi i kuririma da na jednom mjestu vide sve podatke za isporuku paketa. Podaci se konsolidiraju iz cetiri različite relacije pomoću višestruke operacije `INNER JOIN`. Spajaju se n-torke iz relacija `dostava`, `narudzba`, `kupac` i `adresa` preko njihovih odgovarajućih primarnih i stranih ključeva. Time se strogo poštuje referencijski integritet i povezuje logistički broj pošiljke s točnim imenom i lokacijom kupca.

Unutar operacije generalizirane projekcije dvaput se koristi funkcija `CONCAT` za spajanje znakovnih nizova. Prva spaja atribute imena i prezimena u izvedeni atribut `primatelj`, dok druga spaja ulica, poštanski broj i grad u jedinstveni izvedeni atribut `adresa_dostave`. Pogled izravno prikazuje i atribute surogatnog ključa dostave, kurirske službe te statusa isporuke. Pozivanjem ovog pogleda uz završnu naredbu `WHERE`, logistički tim može jednim klikom filtrirati samo aktivne pakete koji su trenutno na putu prema kupcima.


&nbsp;


###  8.1 Okidač: trg_stavka_narudzbe_kontrola (Objedinjena kontrola stavki narudžbe) (Danijel Margić)

```sql
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
```

#### Pokretanje okidača (Uspješan unos):
```sql
-- Unosimo stavku bez kolone 'ukupna_cijena' jer je triger sam računa
INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (1, 1, 2, 3.50);

-- Provjera automatskog izračuna ukupne cijene (7.00)
SELECT * FROM stavka_narudzbe WHERE narudzba_id = 1 AND proizvod_id = 1;
```
![Rezultat uspješnog unosa](slike/trigerSlika1_ok.png)

#### Demonstracija greške (Zabrana unosa):
```sql
-- Pokušaj narudžbe prevelike količine (500 komada)
INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (1, 1, 500, 3.50);
```
![Rezultat blokade trigera](slike/trigerSlika1_error.png)

Ovaj okidač služi za automatsko očuvanje integriteta skladišta i sprječavanje ljudskih pogrešaka prilikom kreiranja narudžbi. Pokreće se nad relacijom `stavka_narudzbe` prije nego što se nova n-torka trajno zapiše u bazu podataka (**`BEFORE INSERT`**). Njegova prva uloga je da pomoću lokalne varijable dohvati trenutnu vrijednost iz domene zaliha u relaciji `proizvod`. Ako predikat utvrdi da kupac pokušava naručiti količinu koja je veća od dostupne, okidač pomoću naredbe `SIGNAL SQLSTATE '45000'` fizički prekida transakciju i izbacuje jasnu poruku o grešci, čime se sprječava prodaja nepostojećih čokolada. Ako na skladištu ima dovoljno robe, okidač uspješno prolazi provjeru te kroz operaciju generalizirane projekcije samostalno računa i popunjava atribut `ukupna_cijena` množenjem količine i cijene po komadu, eliminirajući potrebu da vanjska aplikacija obavlja taj izračun.


&nbsp;


### 8.2 Okidač: trg_azuriraj_zalihe_nakon_prodaje (Automatsko ažuriranje zaliha nakon kupnje) (Danijel Margić)

```sql
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
```

#### Pokretanje i provjera rada okidača:
```sql
-- 1. Provjera stanja zaliha prije nego što kupac obavi kupnju
SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 3;
```
![Stanje zaliha prije kupnje](slike/trigerSlika2_prije.png)

```sql
-- 2. Pokretanje okidača: Kupac kroz stavku narudžbe kupuje 5 komada proizvoda broj 3
INSERT INTO stavka_narudzbe (narudzba_id, proizvod_id, kolicina, cijena_po_komadu) 
VALUES (2, 3, 5, 4.00);

-- 3. Provjera stanja nakon unosa n-torke: Količina na skladištu je automatski smanjena za 5 komada
SELECT kolicina_na_skladistu FROM proizvod WHERE proizvod_id = 3;
```
![Stanje zaliha nakon kupnje](slike/trigerSlika2_poslije.png)

Ovaj okidač služi za automatizirano usklađivanje fizičkog stanja skladišta s realiziranom prodajom u stvarnom vremenu. Pokreće se nad relacijom `stavka_narudzbe` neposredno nakon što se nova n-torka uspješno zapiše u bazu podataka (**`AFTER INSERT`**). Njegova operativna svrha je automatsko očuvanje integriteta zaliha i sprječavanje problema prekoračenja prodaje. 

Kada kupac potvrdi kupnju i podaci prođu početne provjere, ovaj okidač presreće novu n-torku te pomoću ključne riječi `NEW` uzima vrijednost iz domene njezinog atributa `kolicina`. Potom u istom transakcijskom bloku izvršava DML naredbu `UPDATE` nad referenciranom relacijom `proizvod`. Triger pronalazi odgovarajući artikl prema surogatnom ključu `proizvod_id` i aritmetičkom operacijom oduzimanja smanjuje njegov atribut `kolicina_na_skladistu`. Zahvaljujući ovom okidaču, podaci o dostupnosti čokolada na webshopu uvijek su sto posto točni i ažurni bez ikakve potrebe za ručnim intervencijama operatera.
