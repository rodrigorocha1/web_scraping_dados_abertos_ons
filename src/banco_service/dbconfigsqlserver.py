from src.banco_service.idb_config import IDBConfig
import os
from dotenv import load_dotenv

load_dotenv()


class DbConfigSQLServer(IDBConfig):

    def obter_conexao_string(self) -> str:
        """
        Método para criar a string de conexão
        :return: retorna a string de conexão
        :rtype: str
        """
        return (
            f"DRIVER={{ODBC Driver 18 for SQL Server}};"
            f"SERVER={os.environ['SERVER']};"
            f"DATABASE={os.environ['DATABASE']};"
            f"UID={os.environ['USERSQL']};"
            f"PWD={os.environ['PASSWORD']};"
            f"TrustServerCertificate=yes"
        )
