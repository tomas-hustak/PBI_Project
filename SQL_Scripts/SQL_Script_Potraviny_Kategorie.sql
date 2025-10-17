-- Power BI Projekt (ENGETO - Datová akademie 5.3.2025)

--SQL skript pro načtení tabulky "Potraviny_Kategorie" do Power BI z databázové tabulky 'czechia_price_category'

SELECT 
	code AS kod_kategorie, 
	CONCAT(name,' ',price_value,price_unit) AS nazev_kategorie 
FROM 
	czechia_price_category 
ORDER BY 
	code
;