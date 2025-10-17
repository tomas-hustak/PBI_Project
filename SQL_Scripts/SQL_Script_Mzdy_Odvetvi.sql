-- Power BI Projekt (ENGETO - Datová akademie 5.3.2025)

--SQL skript pro načtení tabulky "Mzdy_Odvetvi" do Power BI z databázové tabulky 'czechia_payroll_industry_branch'

SELECT 
	code AS kod_odvetvi, 
	name AS nazev_odvetvi 
FROM 
	czechia_payroll_industry_branch 
UNION SELECT 
	'0', 
	'Absolutní úhrn za všechna odvětví' 
ORDER BY 
	kod_odvetvi 
;