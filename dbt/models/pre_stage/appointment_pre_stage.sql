{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','appointment'),
    name_of_table = "'appointment'",
    etl_source_version = "'1'"
)
}}