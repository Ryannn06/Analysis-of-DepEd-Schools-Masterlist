from dotenv import load_dotenv
import os

load_dotenv()

username = os.getenv('DB_USERNAME')
password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')
file_path = os.getenv('FILE_PATH')
file_name = os.getenv('FILE_NAME')
pdf_path = os.getenv('PDF_PATH')

if not all([username, password, db_name, file_path, file_name, pdf_path]):
    raise ValueError("One or more environment variables are missing")