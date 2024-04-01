with orders as (
  select
    order_id
    , customer_id
    , order_status
    , order_date
    , required_date
    , store_id
    , staff_id
  from {{ source('raw_data', 'orders') }}
)
select *
from orders