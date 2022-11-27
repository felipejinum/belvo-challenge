SELECT  customers.id
,owner_id as owner_id
,owners.name as customer_owner_name
,owners.team as customer_owner_team
,owners.job_position as customer_owner_job_position
,customer_name
,customer_phase
,cast(timestamp_seconds(cast(start_date as integer)) as date) as start_date
,end_date
FROM `belvo-challenge.raw.customers` customers
LEFT JOIN `belvo-challenge.raw.owners` as owners
ON customers.owner_id = owners.id