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