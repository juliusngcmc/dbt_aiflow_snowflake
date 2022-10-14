{{ config(
    schema='pre_stage'
) }}
{{ pre_stage_load(
    model_name = source('trial_landing_db','receipts_items'),
    name_of_table = "'receipts_items'",
    etl_source_version = "'1'"
)
}}