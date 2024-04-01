with 
    stores as (
        select
            sk_store
        from {{ ref('dim_stores') }}
    )
    , staffs as (
        select
            sk_staff
        from {{ ref('dim_staffs') }}
    )
    , sales as (
        select
            s.sk_store as fk_store
            , st.sk_staff as fk_staff
            , sum(o.total_price) as total_sales
        from {{ ref('fct_order') }} o
        join stores s on o.fk_store = s.sk_store
        join {{ ref('dim_staffs') }} st on o.fk_staff = st.sk_staff
        group by s.store_state, st.full_name
    )

select
    {{dbt_utils.generate_surrogate_key(['fk_store', 'fk_staff'])}} as sk_stock_store
    , *
from store_Stock