{% macro pre_stage_load(model_name, name_of_table, etl_source_version) %}
with round_number as(
--     1. put round_number for every record partition by ID and order by _FIVETRAN_START
        SELECT *, row_number() OVER (PARTITION BY ID ORDER BY _FIVETRAN_START DESC) AS round_num
        FROM {{ model_name }}
)
    ,existed as (
--     2. check if ID existed the day before
      select *,
             case
                 when exists(
                         select *
                         from {{ model_name }}
                         where ID = round_number.ID
                             and to_date(_FIVETRAN_START) < to_date(round_number._FIVETRAN_START)
                     )
                 then 1
                 else 0
                 end as existed
      from round_number
    )
    ,lasted_record as(
--      3. take the lasted record for each ID
        select * from existed
             where round_num = 1
    )
    ,operation as(
--      4. identify as DELETE or INSERT OR UPDATE
        select *,
               case
                   when _FIVETRAN_ACTIVE = 'TRUE' and existed = 1 then 'UPDATE'
                   when _FIVETRAN_ACTIVE = 'TRUE' and existed = 0 then 'INSERT'
                   else 'DELETED'
               end as OPERATION
        from lasted_record
    )
    , source_info as (
--      5. Join the operation with FIVETRAN_AUDIT to take ETL information
--         filter with condition: _FIVETRAN_SYNCED < DONE
        select
             operation.*
--               operation.ID
--              ,operation._FIVETRAN_SYNCED
             ,to_date(operation._FIVETRAN_START)                 as LOAD_DATE
             ,operation._FIVETRAN_START                          as SOURCE_MODIFIED
             ,t."START"
             ,t.DONE
             ,t.ID                                               as ETL_BATCH_ID
             ,t.SCHEMA                                           as SOURCE_SYSTEM_ID
             ,t.UPDATE_STARTED                                   as ETL_LOADED
             , case when true then 'FIVETRAN' end                as ETL_SOURCE
             , case when true then {{ etl_source_version }} end  as ETL_SOURCE_VERSION
        from operation
        inner join {{ source('trial_landing_db','fivetran_audit') }} t
        on t."TABLE" = {{ name_of_table }}
        where
        operation._FIVETRAN_SYNCED < t.DONE
        order by ID desc
    )
    , time as (
--      6. Take record where _FIVETRAN_SYNCED and START are nearest
        SELECT *, row_number() OVER (PARTITION BY ID ORDER BY "START") AS round_number
        FROM source_info
        order by ID desc
    )
--      7. Take record where round_number = 1
    ,finish as (
        select * from time
        where round_number = 1
    )

-- select * from operation
-- select * from source_info
select * from finish


{% endmacro %}