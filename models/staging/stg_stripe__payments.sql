    select
        ID
        ,ORDERID
        ,PAYMENTMETHOD
        ,STATUS
        ,AMOUNT/100.0 as amount
        ,CREATED
    from default.stripe_payments

