with
    dim_date as (
        {{ dbt_date.get_date_dimension("2016-01-01", "2018-12-31") }}
    )

    select *
    from dim_date