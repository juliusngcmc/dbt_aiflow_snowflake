from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import datetime
from airflow.utils.dates import timedelta

default_args = {
    'owner': 'julius',
    'depends_on_past': False,
    'start_date': datetime(2020, 12, 23),
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

with DAG(
        dag_id='dbt_snow_dag_test',
        default_args=default_args,
        start_date=datetime(2022, 10, 13),
        schedule_interval='*/5 * * * *',
        description='An Airflow DAG to invoke simple dbt commands'
) as dag:
    DBT_COMPILE = BashOperator(
        task_id='DBT_COMPILE',
        bash_command='cd /opt/airflow/dbt && dbt compile --profiles-dir .',
        env={
            'dbt_user': '{{ var.value.dbt_user }}',
            'dbt_password': '{{ var.value.dbt_password }}'
        },
        append_env=True,
        dag=dag
    )

    PRE_STAGE = BashOperator(
        task_id='PRE_STAGE',
        bash_command='cd /opt/airflow/dbt && dbt run --models pre_stage --profiles-dir .',
        env={
            'dbt_user': '{{ var.value.dbt_user }}',
            'dbt_password': '{{ var.value.dbt_password }}'
        },
        append_env=True,
        dag=dag
    )

    STAGE = BashOperator(
        task_id='STAGE',
        bash_command='cd /opt/airflow/dbt && dbt run --models stage --profiles-dir .',
        env={
            'dbt_user': '{{ var.value.dbt_user }}',
            'dbt_password': '{{ var.value.dbt_password }}'
        },
        append_env=True,
        dag=dag
    )

    RAW_VAULT = BashOperator(
        task_id='RAW_VAULT',
        bash_command='cd /opt/airflow/dbt && dbt run --models raw_vault --profiles-dir .',
        env={
            'dbt_user': '{{ var.value.dbt_user }}',
            'dbt_password': '{{ var.value.dbt_password }}'
        },
        append_env=True,
        dag=dag
    )

    DBT_COMPILE >> PRE_STAGE >> STAGE >> RAW_VAULT
