with staffs as (
    select
        staff_id
        , first_name
        , last_name
        , active
        , store_id
        , manager_id
    from {{ source('raw_data', 'staffs') }}
)
select *
from staffs