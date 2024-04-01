with 
    stores as (
        select
            store_id
            , store_name
            , store_street
            , store_city
            , store_state
            , store_zip_code
        from {{ref('stg_stores')}}
    )
    , dim_stores as (
        select
            {{dbt_utils.generate_surrogate_key(['store_id', 'store_name'])}} as sk_store
            , *
            from stores
    )

select *
from dim_stores