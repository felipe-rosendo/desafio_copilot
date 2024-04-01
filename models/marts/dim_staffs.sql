with 
    staff as (
        select
            staff_id
            , first_name
            , last_name
            , concat(first_name, ' ', last_name) as full_name
            , active
            , store_id
            , manager_id
        from {{ref('stg_staffs')}}
    )
    , dim_staffs as (
        select
            {{dbt_utils.generate_surrogate_key(['staff_id', 'full_name'])}} as sk_staff
            , *
            from staff
    )

select *
from dim_staffs