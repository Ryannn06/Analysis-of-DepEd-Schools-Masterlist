from sqlalchemy import create_engine, text
import pandas as pd

def load_to_database(data, region_table, conn_string):
    try:
        dict = {
            'region': region_table,
            'masterlist': data
        }
        db_engine = create_engine(conn_string) 

        with db_engine.connect() as connection:
            for table_name, df in dict.items():
                df.to_sql(table_name, con=connection, if_exists='append', index=False)

        print("Data loaded into the database successfully.")

    except Exception as e:
        print(f"An error occurred during data loading: {e}")