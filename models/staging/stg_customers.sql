with customers as (
  select
    customer_id
    , first_name
    , last_name
    , phone
    , email
    , street as customer_street
    , city as customer_city
    , state as customers_state
    , zip_code as customer_zip_code
  from {{ source('raw_data', 'customers') }}
)
select *
from customers