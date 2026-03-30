CREATE OR REPLACE VIEW popularnost_proizvoda AS
SELECT 
    p.proizvod_id,
    p.naziv,
    SUM(sn.kolicina) AS ukupna_kolicina,
    SUM(sn.kolicina * sn.cijena_po_komadu) AS prihod,
    (SUM(sn.kolicina) * 0.6 + SUM(sn.kolicina * sn.cijena_po_komadu) * 0.4) AS popularnost_score
FROM proizvod p
JOIN stavka_narudzbe sn ON p.proizvod_id = sn.proizvod_id
JOIN narudzba n ON n.narudzba_id = sn.narudzba_id
WHERE n.datum_narudzbe >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY p.proizvod_id, p.naziv;

SELECT *
FROM popularnost_proizvoda
ORDER BY popularnost_score DESC;