with stocks as (
    select
        store_id
        , product_id
        , quantity
    from {{ source('raw_data', 'stocks') }}
)
select *
from stocks