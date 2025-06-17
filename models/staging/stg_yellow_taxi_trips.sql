with 

source as (

select * 
from {{ source('yellow_tripdata', 'yellow_tripdata_2024_01') }}

),

transformed as (

select 
vendorid as vendor_id
,{{ids_to_values_case(
    'vendorid'
    ,[1,2,6,7]
    ,['Creative Mobile Technologies LLC', 'Curb Mobility, LLC', 'Myle Technologies Inc', 'Helix']
)}} as vendor
,tpep_pickup_datetime as pickup_datetime
,tpep_dropoff_datetime as dropoff_datetime
,passenger_count
,trip_distance as trip_distance_miles
,ratecodeid as rate_code_id
,{{ids_to_values_case(
    'ratecodeid'
    ,[1,2,3,4,5,6,99]
    ,['Standard rate', 'JFK', 'Newark', 'Nassau or Westchester','Negotiated fare','Group ride','Null/unknown']
)}} as rate
,store_and_fwd_flag
,pulocationid as pickup_location_id 
,dolocationid as dropoff_location_id
,payment_type as payment_type_id
,{{ids_to_values_case(
    'payment_type'
    ,[0,1,2,3,4,5,6]
    ,['Flex Fare trip', 'Credit card', 'Cash', 'No charge','Dispute','Unknown','Voided trip']
)}} as payment
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