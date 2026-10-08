# Install dependencies as needed:
# pip install kagglehub[pandas-datasets]
import kagglehub
from kagglehub import KaggleDatasetAdapter
from sqlalchemy import create_engine


# Set the path to the file you'd like to load
file_path = ["olist_customers_dataset.csv",
"olist_geolocation_dataset.csv",
"olist_order_items_dataset.csv",
"olist_order_payments_dataset.csv",
"olist_order_reviews_dataset.csv",
"olist_orders_dataset.csv",
"olist_products_dataset.csv",
"olist_sellers_dataset.csv",
"product_category_name_translation.csv"]

alchemy_engine = create_engine('postgresql+psycopg://postgres:postgres@postgres:5432/warehouse')

# Create raw schema
with alchemy_engine.begin() as connection:
    connection.exec_driver_sql(
        "CREATE SCHEMA IF NOT EXISTS raw"
    )

for file in file_path:
# Load the latest version
    df = kagglehub.dataset_load(
    KaggleDatasetAdapter.PANDAS,
    "olistbr/brazilian-ecommerce",
    file,
    # Provide any additional arguments like 
    # sql_query or pandas_kwargs. See the 
    # documenation for more information:
    # https://github.com/Kaggle/kagglehub/blob/main/README.md#kaggledatasetadapterpandas
    )

    table_name = file.replace(".csv", "")

    df.to_sql(
        table_name, 
        con=alchemy_engine, 
        schema="raw",
        if_exists="replace",
        index=False
    )
    print(f"Loaded {file} → raw.{table_name}")

   

