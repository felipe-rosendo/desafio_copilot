with order_items as (
  select
    order_id
    , item_id
    , product_id
    , quantity
    , list_price
    , discount
  from {{ source('raw_data', 'order_items') }}
)
select *
from order_items