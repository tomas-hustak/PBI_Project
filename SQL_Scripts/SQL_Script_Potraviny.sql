-- Power BI Projekt (ENGETO - Datová akademie 5.3.2025)

--SQL skript pro načtení tabulky "Potraviny" do Power BI z databázové tabulky 'czechia_price'

SELECT 
	category_code AS kod_kategorie, 
	COALESCE(region_code,'CZ000') AS kod_kraje, 
	date_part('YEAR',date_from)::text AS rok, --přetypován na text pro snadnější přetypování na datum v Power Query 
	round(avg(value)::numeric,2) AS prum_cena, 
	COALESCE( round(avg(value)::numeric,2) - 
		LAG(round(avg(value)::numeric,2)) 
		OVER(PARTITION BY category_code, region_code 
		ORDER BY category_code, region_code, date_part('YEAR',date_from) )
	,0) AS prum_cena_mezirocni_rozdil, 
	round( COALESCE( round(avg(value)::numeric,2) / 
		LAG(round(avg(value)::numeric,2)) 
		OVER(PARTITION BY category_code, region_code 
		ORDER BY category_code, region_code, date_part('YEAR',date_from) ) -1 
		,0)
	::numeric,4) AS prum_cena_mezirocni_rozdil_procent 
FROM 
	czechia_price 
GROUP BY 
	category_code, 
	region_code, 
	date_part('YEAR',date_from) 
ORDER BY 
	category_code ASC, 
	region_code ASC, 
	date_part('YEAR',date_from) ASC 
;