
# 1. Pogled aktivnih kupaca s osnovnim podacima
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

# 2. Pogled proizvoda s kategorijama
CREATE OR REPLACE VIEW AP_Pogled_proizvodi_kategorije AS
SELECT 
    p.proizvod_id,
    p.naziv AS proizvod,
    k.naziv AS kategorija,
    p.cijena,
    p.kolicina_na_skladistu,
    p.SKU
FROM proizvod p
JOIN kategorija k ON p.kategorija_id = k.kategorija_id;

# 3. Pogled detalja narudžbi
CREATE OR REPLACE VIEW AP_Pogled_detalji_narudzbi AS
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

# 4. Pogled stavki narudžbe s nazivima proizvoda
CREATE OR REPLACE VIEW AP_Pogled_stavke_narudzbe AS
SELECT 
    sn.stavka_id,
    sn.narudzba_id,
    p.naziv AS proizvod,
    sn.kolicina,
    sn.cijena_po_komadu,
    sn.ukupna_cijena
FROM stavka_narudzbe sn
JOIN proizvod p ON sn.proizvod_id = p.proizvod_id;

# 5. Pogled plaćanja po narudžbi
CREATE OR REPLACE VIEW AP_Pogled_placanja_narudzbi AS
SELECT 
    p.placanje_id,
    p.narudzba_id,
    p.nacin_placanja,
    p.iznos,
    p.status_placanja,
    p.datum_placanja
FROM placanje p;

# 6. Pogled dostave po narudžbi
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

# 7. Pogled prosječne ocjene proizvoda
CREATE OR REPLACE VIEW AP_Pogled_ocjene_proizvoda AS
SELECT 
    p.proizvod_id,
    p.naziv,
    COUNT(r.recenzija_id) AS broj_recenzija,
    ROUND(AVG(r.ocjena), 2) AS prosjecna_ocjena
FROM proizvod p
LEFT JOIN recenzija r ON p.proizvod_id = r.proizvod_id
GROUP BY p.proizvod_id, p.naziv;

# 8. Pogled ukupne potrošnje kupaca
CREATE OR REPLACE VIEW AP_Pogled_potrosnja_kupaca AS
SELECT 
    k.kupac_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    COUNT(n.narudzba_id) AS broj_narudzbi,
    ROUND(COALESCE(SUM(n.ukupan_iznos), 0), 2) AS ukupna_potrosnja
FROM kupac k
LEFT JOIN narudzba n ON k.kupac_id = n.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime;

# 9. Pogled zaliha i procjene vrijednosti skladišta
CREATE OR REPLACE VIEW AP_Pogled_stanje_skladista AS
SELECT 
    proizvod_id,
    naziv,
    cijena,
    kolicina_na_skladistu,
    ROUND(cijena * kolicina_na_skladistu, 2) AS vrijednost_na_skladistu
FROM proizvod;

# 10. Pogled nabave s dobavljačima
CREATE OR REPLACE VIEW AP_Pogled_nabava_dobavljaci AS
SELECT 
    n.nabava_id,
    d.naziv AS dobavljac,
    n.datum_nabave,
    n.status,
    n.ukupan_iznos
FROM nabava n
JOIN dobavljac d ON n.dobavljac_id = d.dobavljac_id;