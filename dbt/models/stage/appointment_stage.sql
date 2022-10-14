{{ config(
    schema='stage'
) }}

{% set yaml_metadata %}
source_model: "appointment_pre_stage"
derived_columns:
    EFFECTIVE_FROM: "_FIVETRAN_START"
    START_DATE: "_FIVETRAN_START"
    END_DATE: "_FIVETRAN_END"
hashed_columns:
    APPOINTMENT_PK: "ID"
    PATIENT_PK: "PATIENTID"
    BRANCH_PK: "BRANCH_IDENTIFIER"
    APPOINTMENT_BRANCH_PATIENT_HK:
        - "ID"
        - "BRANCH_IDENTIFIER"
        - "PATIENTID"
    APPOINTMENT_HASHDIFF:
        is_hashdiff: true
        columns:
            - ID
            - IS_REP_APP
            - USER_ADDED
            - TIMESTMP
            - CAPTION
            - IS_BREAK
            - DURATION
            - EVENTTYPE
            - APPOINTMENT_NOTE
            - BRANCH_IDENTIFIER
            - DATE_EDITED
            - USER_IDENTIFIER
            - RECUR_ID
            - "OPTIONS"
            - APPOINTMENT_TYPE
            - ENDDATE
            - SMS_SENT
            - DATE_ADDED
            - RESID
            - LOCK_APP
            - PATIENTID
            - SUPPLIER_REPID
            - SYNC_ID
            - STARTDATE
            - APP_PROGRESS
            - USER_EDITED
            - COMMENTS
            - _FIVETRAN_SYNCED
            - _FIVETRAN_START
            - _FIVETRAN_END
            - _FIVETRAN_ACTIVE
            - OPERATION
            - LOAD_DATE
            - SOURCE_MODIFIED
            - ETL_BATCH_ID
            - SOURCE_SYSTEM_ID
            - ETL_LOADED
            - ETL_SOURCE
            - ETL_SOURCE_VERSION
            - EFFECTIVE_FROM
{% endset %}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}


{{ dbtvault.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns) }}