/*
next lets build a fact_taxi_ride model 
+id, create a surrogate key based on columns, and lets check if we lose any rows based on that 
*/


with 

final as (

select 
{{ dbt_utils.generate_surrogate_key([
        'pickup_datetime',
        'dropoff_datetime',
        'pickup_location_id',
        'dropoff_location_id'
    ]) }} as trip_key
,*
,dropoff_datetime - pickup_datetime as trip_duration
from {{ ref('stg_yellow_taxi_trips') }} a

)

select * from final