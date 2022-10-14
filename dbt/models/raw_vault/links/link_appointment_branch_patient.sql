{{ config(materialized='incremental', schema='raw_vault') }}

{% set source_model = "appointment_stage" %}

{% set src_pk = "APPOINTMENT_BRANCH_PATIENT_HK" %}
{% set src_fk = ["APPOINTMENT_PK", "PATIENT_PK", "BRANCH_PK"] %}
{% set src_ldts = "LOAD_DATE" %}
{% set src_source = "SOURCE_SYSTEM_ID" %}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
