{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','invoice'),
    name_of_table = "'invoice'",
    etl_source_version = "'1'"
)
}}