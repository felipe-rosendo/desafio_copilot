with
    validation as(
        select sum(quantity) as sum_qty
        from {{ref ('fct_order')}}
        where order_date between '2017-01-01' and '2017-12-31'
    )

select * from validation where sum_qty != 3099