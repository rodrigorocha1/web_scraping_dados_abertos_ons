import pyodbc
import os
from dotenv import load_dotenv

load_dotenv()


class ConexaoBanco:
    conexao = None

    @classmethod
    def conectar_banco(cls):
        connection_string = (
            f"DRIVER={{ODBC Driver 18 for SQL Server}};"
            f"SERVER={os.environ['SERVER']};"
            f"DATABASE={os.environ['DATABASE']};"
            f"UID={os.environ['USERSQL']};"
            f"PWD={os.environ['PASSWORD']};"
            f"TrustServerCertificate=yes"
        )
        db_conexao = pyodbc.connect(connection_string)
        cls.conexao = db_conexao
