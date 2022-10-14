{{ config(materialized='incremental', schema='raw_vault') }}

{% set source_model = "branch_stage" %}

{% set src_pk = "BRANCH_PK" %}
{% set src_nk = "ID" %}
{% set src_ldts = "LOAD_DATE" %}
{% set src_source = "SOURCE_SYSTEM_ID" %}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}