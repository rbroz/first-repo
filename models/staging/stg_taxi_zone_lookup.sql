with 

source as (

    select * 
    from {{ source('yellow_tripdata', 'taxi_zone_lookup') }}

),

transformed as (

    select
    locationid as location_id 
    ,borough
    ,zone 
    ,service_zone
    from source
)

    select * from transformed