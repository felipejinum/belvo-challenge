SELECT contacts.* except(country)
  , country.nicename as country_name
FROM `belvo-challenge.raw.contacts` as contacts
LEFT JOIN `belvo-challenge.aux.country` as country
  ON LOWER(contacts.country) = LOWER(country.iso) 
  OR LOWER(contacts.country) = LOWER(country.iso3)
  OR TRANSLATE(CASE WHEN LOWER(contacts.country) = 'brasil' THEN 'brazil' else LOWER(contacts.country) end,"ŠŽšžŸÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðñòóôõöùúûüýÿ", "SZszYAAAAAACEEEEIIIIDNOOOOOUUUUYaaaaaaceeeeiiiidnooooouuuuyy") = LOWER(country.nicename)