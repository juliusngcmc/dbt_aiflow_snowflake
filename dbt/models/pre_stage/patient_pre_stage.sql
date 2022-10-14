{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','patient'),
    name_of_table = "'patient'",
    etl_source_version = "'1'"
)
}}