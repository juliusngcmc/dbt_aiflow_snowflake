{{ config(
    schema='stage'
) }}

{% set yaml_metadata %}
source_model: "patient_pre_stage"
derived_columns:
    EFFECTIVE_FROM: "_FIVETRAN_START"
    START_DATE: "_FIVETRAN_START"
    END_DATE: "_FIVETRAN_END"
hashed_columns:
    PATIENT_PK: "ID"
    PATIENT_HASHDIFF:
        is_hashdiff: true
        columns:
            - ID
            - ADVISED_OF_PRIVACY_POLICY_DATETIME
            - BADPHONE
            - BSBCODE
            - RESIDENT_STATE
            - GIVEN
            - HICPHONE
            - POSTAL_ADDRESS
            - GENERAL_NOTES
            - BADEMAIL
            - HEALTHFUND_IDENTIFIER
            - HICPCODE
            - HCFWAIVER
            - HCFSTATDATE
            - NOMOBILE
            - HCFLIMITBS
            - CONT_RX_REQUESTED
            - CONVERTED_ID
            - BALANCE
            - DVA_NUMBER
            - USER_ADDED
            - PREF_MARKETING
            - SPEC_RX_REQUESTED_DATETIME
            - APPOINTMENT_NOTE
            - PREMIER_REFERENCE
            - MERGE_ID
            - MOBILE_PHONE
            - TIMESTMP
            - MERGED_FROM
            - HICSUBURB
            - MEDICARE_EXPIRY
            - HCFSIGHT
            - CHARGE_TO_STATE
            - SPEC_RX_REQUESTED
            - HCF_CAN_ACCESS_EXAM
            - HCF_EXAM_DATETIME
            - HCFJOINDATE
            - PREF_RECALLSUB
            - USER_EDITED
            - REFERENCE
            - RESIDENT_SUBURB
            - NATIONALITY
            - POSTAL_STATE
            - HICFIRNAME
            - BIRTHDATE
            - HICADD1
            - LAST_CONS
            - TITLE
            - HCFGRPSEC
            - CHARGE_TO_SALUTATION
            - MAIN_CONTACT
            - GROUP_NUMBER
            - HCFEFFDATE
            - LAST_OVV
            - AVAILASAT
            - REFERRAL_TYPE
            - REFERRER_PROV_NUMBER
            - FEE_LEVEL
            - HCFPF
            - ADVISED_OF_PRIVACY_POLICY
            - INACTIVE_REASON
            - SURNAME
            - CONT_RX_REQUESTED_VIA
            - HEARAID_GUID
            - INACTIVE
            - LAST_INITIAL
            - NOEMAIL
            - CONT_RX_REQUESTED_DATETIME
            - HEALTHFUND_REFNO
            - HICMEDCARD
            - RESIDENT_ADDRESS
            - BADADDRESS
            - LAST_OPV
            - SPEC_RX_REQUESTED_VIA
            - OFFICE_PHONE
            - MEDICARE_NUMBER
            - HICREFNUM
            - HCF_EXAM_USER
            - MIDDLE
            - PREF_ORDERCOLL
            - PREF_TELEPHONE
            - OCCUPATION
            - HICADD2
            - "SOURCE"
            - EMAIL
            - HCFSCALE
            - HICFAMNAME
            - CHARGE_TO_ADDRESS
            - RESIDENT_POSTCODE
            - HOSPCODE
            - HOME_PHONE
            - HCFPM
            - NICKNAME
            - NHI_NUMBER
            - GP_IDENTIFIER
            - AVAILDOLL
            - HCFCRDDATE
            - REFERRER_ISSUE_DATE
            - GENDER
            - NO_HEALTHFUND
            - HCFEN
            - REFERRER_FROM_IDENTIFIER
            - DVA_DETAILS
            - BANKACCOUNTNUM
            - HICBDATE
            - MEMBER_NUMBER
            - LAST_VISIT
            - HCFFINDATE
            - USER_IDENTIFIER
            - HCFTERMDATE
            - POSTAL_POSTCODE
            - SPECIAL_NOTE
            - CHARGE_TO_NAME
            - HCFCARDNO
            - POSTAL_SUBURB
            - REFERRAL_NONSTANDARD_TEXT
            - REFERRER_TO_IDENTIFIER
            - SALUTATION
            - PREF_APPOINTMENTS
            - PATIENT_PICTURE_LOCATION
            - CHARGE_TO_POSTCODE
            - HCFGRPDATE
            - BRANCH_IDENTIFIER
            - PATIENT_SINCE
            - BANKACCOUNTNAME
            - TABLECODE
            - DATE_EDITED
            - PREF_RECALLINT
            - MEDICARE_REFNO
            - ADVISED_OF_PRIVACY_POLICY_USER
            - HCFGRPNUM
            - CHARGE_TO_SUBURB
            - DATE_ADDED
            - HCFGRPUSR
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