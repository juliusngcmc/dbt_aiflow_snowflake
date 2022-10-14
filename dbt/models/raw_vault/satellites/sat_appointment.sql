{{ config(  materialized='vault_insert_by_period',
            schema='raw_vault',
            timestamp_field='LOAD_DATE', period='day',
            start_date='2022-09-19',
            stop_date='2022-09-23'
        )
}}


{% set source_model = "appointment_stage" %}

{% set src_pk = "APPOINTMENT_PK" %}
{% set src_hashdiff = "APPOINTMENT_HASHDIFF" %}
{% set src_eff = "EFFECTIVE_FROM" %}
{% set src_ldts = "LOAD_DATE" %}
{% set src_source = "SOURCE_SYSTEM_ID" %}

{{ dbtvault.sat(
        src_pk=src_pk,
        src_hashdiff=src_hashdiff,
        src_payload=src_payload,
        src_eff=src_eff,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model)
}}
