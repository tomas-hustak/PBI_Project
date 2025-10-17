-- Power BI Projekt (ENGETO - Datová akademie 5.3.2025)

--SQL skript pro načtení tabulky "Potraviny_Kosik_CR" do Power BI z databázové tabulky 'czechia_price'
--(jako pomocné tabulky s výpočtem meziročních rozdílů nákupních košíků)

SELECT 
	year::text AS rok, --přetypován na text pro snadnější přetypování na datum v Power Query 
	avg(year_sum_of_avg_prices_czk) AS kosik_cr_prum_cena, 
	COALESCE(round(avg(year_sum_of_avg_prices_czk) - 
		LAG(avg(year_sum_of_avg_prices_czk)) OVER(ORDER BY year) 
		,2) 
	,0) AS kosik_cr_mezirocni_rozdil, 
	COALESCE(round(avg(year_sum_of_avg_prices_czk) / 
		LAG(avg(year_sum_of_avg_prices_czk)) OVER(ORDER BY year) -1 
		,4) 
	,0) AS kosik_cr_mezirocni_rozdil_procent 
FROM (  --vnořený select pro výpočet součtů průměrných cen potravin (nákupních košíků) v jednotlivých letech 
	SELECT 
		date_part('YEAR', date_from) AS year, 
		category_code, 
		round(avg(value)::numeric,2) AS year_avg_price_czk, 
		sum(round(avg(value)::numeric,2)) OVER (PARTITION BY date_part('YEAR', date_from)) AS year_sum_of_avg_prices_czk 
	FROM 
		czechia_price 
	WHERE 
		region_code IS NULL --celorepublikový průměr z regionu NULL 
	GROUP BY 
		date_part('YEAR', date_from), 
		category_code 
	ORDER BY 
		date_part('YEAR', date_from), 
		category_code 
) 
GROUP BY 
	year 
ORDER BY 
	year 
;