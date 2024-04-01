with
    dim_products as (
        select
            sk_product
            , product_id
        from {{ ref('dim_products') }}
    )
    , dim_customers as (
        select
            sk_customer
            , customer_id
        from {{ ref('dim_customers') }}
    )
    , dim_stores as (
        select
            sk_store
            , store_id
        from {{ ref('dim_stores') }}
    )
    , dim_staffs as (
        select
            sk_staff
            , staff_id
        from {{ ref('dim_staffs') }}
    )
    , order_items as (
        select
            order_id
            , item_id
            , product_id
            , quantity
            , list_price
            , discount
            , (list_price * quantity) - (list_price * quantity * discount) as total_price
        from {{ ref('stg_order_items') }}
    )
    , orders as (
        select
            order_id
            , customer_id
            , order_status
            , order_date
            , required_date
            , store_id
            , staff_id
        from {{ ref('stg_orders') }}
    )
    , cte_orders as (
        select
            o.order_id
            , c.sk_customer as fk_customer
            , o.order_status
            , o.order_date
            , o.required_date
            , s.sk_store as fk_store
            , st.sk_staff as fk_staff
            , oi.item_id
            , p.sk_product as fk_product
            , oi.quantity
            , oi.list_price
            , oi.discount
            , oi.total_price
        from orders o
        join order_items oi on o.order_id = oi.order_id
        join dim_products p on oi.product_id = p.product_id
        join dim_customers c on o.customer_id = c.customer_id
        join dim_stores s on o.store_id = s.store_id
        join dim_staffs st on o.staff_id = st.staff_id
    )
    , fct_order as (
        select
            {{ dbt_utils.generate_surrogate_key(['order_id', 'order_date']) }} as sk_order
            , *
        from cte_orders
    )
select *
from fct_order