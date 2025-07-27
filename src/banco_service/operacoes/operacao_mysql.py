from typing import Tuple, Any

from mysql.connector.connection import MySQLConnection
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.banco_service.operacoes.i_operacao import IOperacao


class OperacaoMysql(IOperacao):


    @classmethod
    def salvar_consulta(cls, sql: str, param: Tuple[Any, ...]):
        try:
            with ConexaoBanco[MySQLConnection].obter_conexao() as conn:

                cursor = conn.cursor()

                cursor.execute("SELECT 1")
                resultado = cursor.fetchall()
                print("Resultado:", resultado)
        except Exception as e:
            print(f"Erro ao executar consulta: {e}")
