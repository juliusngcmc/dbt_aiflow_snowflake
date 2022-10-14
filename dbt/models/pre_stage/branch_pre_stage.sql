{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','branch'),
    name_of_table = "'branch'",
    etl_source_version = "'1'"
)
}}