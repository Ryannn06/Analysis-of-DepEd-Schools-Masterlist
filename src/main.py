import pandas as pd
import os 
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

from extract.extractor import extract_pdf_to_csv
from database.create_database import create_database
from database.upload_data import load_to_database
from transform.transform_data import transform
from config.env import username, password, db_name, file_path, file_name, pdf_path

class Database:
    def __init__(self, username, password, db_name):
        self._username = username
        self._password = password
        self._db_name = db_name

    def conn_string(self) -> str:
        connection_string = f'postgresql://{self._username}:{self._password}@localhost/{self._db_name}'
        return connection_string
    
    def create_schema(self):
        conn_string = self.conn_string()

        res = create_database(conn_string, self._db_name)
        print(res)
       

class File:
    def __init__(self, file_path, file_name):
        self._file_path = file_path
        self._file_name = file_name

    def get_file(self) -> pd.DataFrame:
        try:
            data = pd.read_csv(os.path.join(self._file_path, self._file_name))
            return data
        except FileNotFoundError as e:
            print(e)


class Process(Database, File):
    def __init__(self):
        Database.__init__(self, username=username, password=password, db_name=db_name)
        File.__init__(self, file_path=file_path, file_name=file_name)
        self._pdf_path = pdf_path

    def extract(self):
        try:
            data = extract_pdf_to_csv(self._pdf_path)

        except Exception as e:
            print(e)
    
    def transform(self) -> tuple[pd.DataFrame, pd.DataFrame]:
        try:
            res = transform(self.get_file())
            return res
        
        except Exception as e:
            print(e)
        
    def load(self):
        try:
            data, region_table = self.transform()
            conn_string = self.conn_string()

            load_to_database(data, region_table, conn_string)

        except Exception as e:
            print(e)


call_etl = Process()
#call_etl.create_schema()
#call_etl.extract()
call_etl.load()