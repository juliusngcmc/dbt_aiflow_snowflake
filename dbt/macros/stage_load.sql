{% macro stage_load(model_name) %}
with drop_unwanted_col as(
--     1. drop unwanted column in the pre-stage
    {% set fields_to_transform = ["round_num", "existed", "start", "done", "round_number"] %}
    select
        {{ dbt_utils.star(from= model_name, except=fields_to_transform) }}
    from {{ model_name }}
)
    select * from drop_unwanted_col
)
-- select * from drop_unwanted_col
select * from test

{% endmacro %}