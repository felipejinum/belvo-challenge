SELECT companies.* except(country)
  , country.nicename as country_name
FROM `belvo-challenge.raw.companies` as companies
LEFT JOIN `belvo-challenge.aux.country` as country
  ON LOWER(companies.country) = LOWER(country.iso) 
  OR LOWER(companies.country) = LOWER(country.iso3)
  OR TRANSLATE(CASE WHEN LOWER(companies.country) = 'brasil' THEN 'brazil' else LOWER(companies.country) end,"ŠŽšžŸÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðñòóôõöùúûüýÿ", "SZszYAAAAAACEEEEIIIIDNOOOOOUUUUYaaaaaaceeeeiiiidnooooouuuuyy") = LOWER(country.nicename)