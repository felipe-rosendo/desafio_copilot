with stores as (
    select
        store_id
        , store_name
        , street as store_street
        , city as store_city
        , state as store_state
        , zip_code as store_zip_code
  from {{ source('raw_data', 'stores') }}
)
select *
from stores