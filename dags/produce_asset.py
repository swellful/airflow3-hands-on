from airflow.sdk import DAG
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime
from assets import example_asset

def produce_fn(**context):
    print("📦 Producing example_asset")

with DAG(dag_id="dag_a", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    PythonOperator(
        task_id="produce_asset1",
        python_callable=produce_fn,
        outlets=[example_asset],  # Producing
    )