with 
    categories as (
        select
            category_id
            , category_name
        from {{ref('stg_categories')}}
    )
    , brands as (
        select
            brand_id
            , brand_name
        from {{ref('stg_brands')}}
    )
    , products as (
        select
            product_id
            , product_name
            , brand_id
            , category_id
            , model_year
            , list_price
        from {{ref('stg_products')}}
    )
    , cte_products as (
        select
            p.product_id
            , p.product_name
            , b.brand_name
            , c.category_name
            , p.model_year
            , p.list_price
        from products p
        join brands b on p.brand_id = b.brand_id
        join categories c on p.category_id = c.category_id
    )
    , dim_products as (
        select 
            {{dbt_utils.generate_surrogate_key(['product_id', 'product_name'])}} as sk_product
            , *
        from cte_products
    )

select *
from dim_products