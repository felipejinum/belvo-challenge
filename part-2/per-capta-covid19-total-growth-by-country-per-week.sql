with covid19_country_summary as (
select date
,country_region
,sum(confirmed) as confirmed
,sum(deaths) as deaths
from `bigquery-public-data.covid19_jhu_csse.summary`
group by 1,2
order by 2 desc
)
select date_trunc(date,week) as week
, country_region
, round(safe_divide(max(confirmed),max(midyear_population)),6) as confirmed_cases_per_capta
from covid19_country_summary
left join `bigquery-public-data.census_bureau_international.midyear_population`
on country_region = country_name
and extract(YEAR from date_trunc(date,week)) = year
group by 1,2
order by 1,2