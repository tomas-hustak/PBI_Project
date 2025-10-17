-- Power BI Projekt (ENGETO - Datová akademie 5.3.2025)

--SQL skript pro načtení tabulky "Potraviny_Kraje" do Power BI z databázové tabulky 'czechia_region'

SELECT 
	code AS kod_kraje, 
	name AS nazev_kraje 
FROM 
	czechia_region 
UNION SELECT 
	'CZ000', 
	'Celorepublikový průměr' 
ORDER BY 
	kod_kraje
;