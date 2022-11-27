WITH companies AS (
  select * from {{ ref('companies')}}
)

, contacts AS (
  select * from {{ ref('contacts')}}
)

, company_deals_assiocations AS (
SELECT CAST(dealid as integer) as dealid
  , companyid
  , name as company_name
  , country_name as company_country_name
FROM `belvo-challenge.raw.companies_deals_associations`, UNNEST(JSON_EXTRACT_ARRAY(dealids)) as dealid
LEFT JOIN companies
  ON companies.id = companyid
)

, contacts_deals_associations AS (
SELECT CAST(dealid as integer) as dealid
  , contactid
  , name as contact_name
  , channel as contact_channel
  , split(job,',')[SAFE_OFFSET(0)] as contact_job
  , split(job,',')[SAFE_OFFSET(1)] as contact_job_detail
  , country_name as contact_country_name
FROM `belvo-challenge.raw.contacts_deals_associations`, UNNEST(JSON_EXTRACT_ARRAY(dealids)) as dealid
LEFT JOIN contacts
  ON contacts.id = contactid
)

SELECT deals.* EXCEPT (created_date, closed_1)
,cast(created_date as timestamp) as created_at
,cast(closed_1 as timestamp) as closed_at
,companyid
,company_name
,company_country_name
,contactid
,contact_name
,contact_channel
,contact_job
,contact_job_detail
,contact_country_name
,owners.name as deal_owner_name
,owners.team as deal_owner_team
,owners.job_position as deal_owner_job_position
FROM `belvo-challenge.raw.deals` as deals
LEFT JOIN company_deals_assiocations
ON company_deals_assiocations.dealid = deals.id
LEFT JOIN contacts_deals_associations
ON contacts_deals_associations.dealid = deals.id
LEFT JOIN `belvo-challenge.raw.owners` as owners
ON deals.ownerid = owners.id