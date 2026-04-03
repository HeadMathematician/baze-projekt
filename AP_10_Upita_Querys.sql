
# 1. Ukupan broj narudžbi i potrošnja po kupcu
#	Svrha: pronaći najvrjednije kupce.
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

#2. Top 5 najprodavanijih proizvoda
#	Svrha: analiza prodaje i planiranje zaliha.
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

# 3. Proizvodi koji nikada nisu naručeni
#	Svrha: otkriti artikle koji se ne prodaju.
SELECT 
    p.proizvod_id,
    p.naziv,
    p.cijena,
    p.kolicina_na_skladistu
FROM proizvod p
LEFT JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
WHERE sn.proizvod_id IS NULL
ORDER BY p.naziv;

# 4. Kupci koji su potrošili više od prosjeka svih kupaca
#	Svrha: segmentacija premium kupaca.
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

# 5. Mjesečni prihod i broj narudžbi
#	Svrha: praćenje poslovanja po mjesecima.
SELECT 
    YEAR(datum_narudzbe) AS godina,
    MONTH(datum_narudzbe) AS mjesec,
    COUNT(*) AS broj_narudzbi,
    ROUND(SUM(ukupan_iznos), 2) AS mjesecni_prihod,
    ROUND(AVG(ukupan_iznos), 2) AS prosjecna_narudzba
FROM narudzba
GROUP BY YEAR(datum_narudzbe), MONTH(datum_narudzbe)
ORDER BY godina, mjesec;

# 6. Prosječna ocjena i broj recenzija po proizvodu
#	Svrha: identifikacija najbolje ocijenjenih proizvoda.
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

# 7. Kupci koji imaju više od jedne adrese
#	Svrha: analiza kupaca s više lokacija dostave.
SELECT 
    k.kupac_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    COUNT(a.adresa_id) AS broj_adresa
FROM kupac k
JOIN adresa a ON k.kupac_id = a.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime
HAVING COUNT(a.adresa_id) > 1
ORDER BY broj_adresa DESC, kupac;

# 8. Proizvodi sa zalihom ispod prosjeka skladišta
#	Svrha: rano uočavanje artikala koje treba nabaviti.
SELECT 
    proizvod_id,
    naziv,
    kolicina_na_skladistu
FROM proizvod
WHERE kolicina_na_skladistu < (
    SELECT AVG(kolicina_na_skladistu)
    FROM proizvod
)
ORDER BY kolicina_na_skladistu ASC;

# 9. Rangiranje kupaca po potrošnji
#	Svrha: napredna analiza uz prozorske funkcije.
SELECT 
    k.kupac_id,
    CONCAT(k.ime, ' ', k.prezime) AS kupac,
    ROUND(SUM(n.ukupan_iznos), 2) AS ukupna_potrosnja,
    RANK() OVER (ORDER BY SUM(n.ukupan_iznos) DESC) AS rang_kupca
FROM kupac k
JOIN narudzba n ON k.kupac_id = n.kupac_id
GROUP BY k.kupac_id, k.ime, k.prezime
ORDER BY rang_kupca;

# 10. Detekcija kašnjenja dostave
#	Svrha: praćenje kvalitete dostavne službe.
SELECT 
    d.dostava_id,
    d.kurirska_sluzba,
    d.broj_posiljke,
    d.procijenjeni_datum,
    d.stvarni_datum,
    DATEDIFF(d.stvarni_datum, d.procijenjeni_datum) AS broj_dana_kasnjenja,
    CASE
        WHEN d.stvarni_datum > d.procijenjeni_datum THEN 'Kasni'
        WHEN d.stvarni_datum = d.procijenjeni_datum THEN 'Na vrijeme'
        ELSE 'Ranije isporučeno'
    END AS status_isporuke
FROM dostava d
ORDER BY broj_dana_kasnjenja DESC;