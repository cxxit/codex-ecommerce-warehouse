FROM python:3.12-slim

WORKDIR /app

RUN pip install --no-cache-dir \
    sqlalchemy \
    pandas \
    "psycopg[binary]" \
    "kagglehub[pandas-datasets]"

COPY olist_customer_dataset_ingestion.py .

CMD ["python", "olist_customer_dataset_ingestion.py"]

