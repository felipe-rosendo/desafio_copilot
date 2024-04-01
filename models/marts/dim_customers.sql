with 
    customer as (
        select
            customer_id
            , first_name
            , last_name
            , concat(first_name, ' ', last_name) as full_name
            , phone
            , email
            , customer_street
            , customer_city
            , customers_state
            , customer_zip_code
        from {{ref('stg_customers')}}
    )
    , dim_customers as (
        select
            {{dbt_utils.generate_surrogate_key(['customer_id', 'full_name'])}} as sk_customer
            , *
            from customer
    )

select *
from dim_customers