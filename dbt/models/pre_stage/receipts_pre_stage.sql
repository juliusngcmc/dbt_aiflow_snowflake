{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','receipts'),
    name_of_table = "'receipts'",
    etl_source_version = "'1'"
)
}}