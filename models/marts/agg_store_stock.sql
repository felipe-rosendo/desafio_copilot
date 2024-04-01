with 
    stores as (
        select
            sk_store
            , store_id
        from {{ ref('dim_stores') }}
    )
    , stocks as (
        select
            store_id
            , product_id
            , sum(quantity) as total_stock
        from {{ ref('stg_stocks') }}
        group by store_id, product_id
    )

    , store_stock as (
        select 
            s.sk_store as fk_store
            , st.product_id
            , st.total_stock
        from stores s
        join stocks st on s.store_id = st.store_id
    )

select
    {{dbt_utils.generate_surrogate_key(['fk_store', 'product_id', 'total_stock'])}} as sk_store_stock
    , *
from store_Stock