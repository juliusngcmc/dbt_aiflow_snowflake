FROM apache/airflow:2.3.0
USER airflow
RUN pip install airflow-dbt-python[snowflake,postgres]