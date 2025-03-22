import pyodbc
from dotenv import load_dotenv
import os

load_dotenv()

SERVER = os.environ['SERVER']
DATABASE = os.environ['DATABASE']
USERNAME = os.environ['USERSQL']
PASSWORD = os.environ['PASSWORD']

connectionString = (
    f"DRIVER={{ODBC Driver 18 for SQL Server}};"
    f"SERVER={SERVER};DATABASE={DATABASE};"
    f"UID={USERNAME};PWD={PASSWORD};"
    f"TrustServerCertificate=yes"
)

conn = pyodbc.connect(connectionString)
print("Conexão bem-sucedida!", conn)

with conn.cursor() as cursor:
    cursor.execute("""
        SELECT GETDATE();
    """)

    result = cursor.fetchone()
    print(result)
    print("Data e hora do servidor:", result[0])

