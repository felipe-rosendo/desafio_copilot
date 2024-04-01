with brands as (
    select
        brand_id
        , brand_name
    from {{ source('raw_data', 'brands') }}
)
select *
from brands