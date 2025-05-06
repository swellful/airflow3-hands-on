from airflow.sdk import DAG
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime
from assets import example_asset


def consume_fn(**context):
    print("📥 Consuming asset1")


with DAG(dag_id="dag_b", start_date=datetime(2024, 1, 1), schedule=None, catchup=False):
    PythonOperator(
        task_id="consume_asset1",
        python_callable=consume_fn,
        inlets=[example_asset],  # Consuming
    )