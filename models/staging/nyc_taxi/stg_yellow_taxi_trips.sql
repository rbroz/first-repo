/*
taxi trips can be added over time as csv to the main website... think about how to incorporate that
*/

with 

source as (

select * 
from {{ source('yellow_tripdata', 'yellow_tripdata_2024_01') }}

),

transformed as (

select 
vendorid as vendor_id
,case 
when vendorid = 1 then 'Creative Mobile Technologies, LLC'
when vendorid = 2 then 'Curb Mobility, LLC'
when vendorid = 6 then 'Myle Technologies Inc'
when vendorid = 7 then 'Helix' 
end as vendor 
,tpep_pickup_datetime as pickup_datetime
,tpep_dropoff_datetime as dropoff_datetime
,passenger_count
,trip_distance as trip_distance_miles
,ratecodeid as rate_code_id
,case 
when ratecodeid = 1 then 'Standard rate'
when ratecodeid = 2 then 'JFK'
when ratecodeid = 3 then 'Newark'
when ratecodeid = 4 then 'Nassau or Westchester'
when ratecodeid = 5 then 'Negotiated fare'
when ratecodeid = 6 then 'Group ride'
when ratecodeid = 99 then 'Null/unknown'
end as rate_code 
,store_and_fwd_flag
,pulocationid as pickup_location_id 
,dolocationid as dropoff_location_id
,payment_type as payment_type_id
,case 
when payment_type = 0 then 'Flex Fare trip'
when payment_type = 1 then 'Credit card'
when payment_type = 2 then 'Cash'
when payment_type = 3 then 'No charge'
when payment_type = 4 then 'Dispute'
when payment_type = 5 then 'Unknown'
when payment_type = 6 then 'Voided trip'
end as payment_type
,round(fare_amount,2) as fare_amount
,round(extra,2) as extra
,round(mta_tax,2) as mta_tax
,round(tip_amount,2) as tip_amount
,round(tolls_amount,2) as tolls_amount
,round(improvement_surcharge,2) as improvement_surcharge
,round(total_amount,2) as total_amount
,round(congestion_surcharge,2) as congestion_surcharge
,round(airport_fee,2) as airport_fee
from source

)

select * from transformed



