with orders as ( 
    select * from {{ ref('stg_orders') }}
),

payments as ( 
    select * from {{ ref('stg_stripe__payments') }}
)

select order_id, customer_id, sum(amount) amount
from orders a 
left join payments b on a.order_id = b.ORDERID
and b.status = 'success'
group by 1,2
