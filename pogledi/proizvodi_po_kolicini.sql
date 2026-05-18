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