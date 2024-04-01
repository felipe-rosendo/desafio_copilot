with products as (
    select
        product_id
        , product_name
        , brand_id
        , category_id
        , model_year
        , list_price
    from {{ source('raw_data', 'products') }}
)
select *
from products