with categories as (
    select 
        category_id
        , category_name
    from {{ source('raw_data', 'categories') }}
)
select *
from categories