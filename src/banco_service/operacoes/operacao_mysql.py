from typing import Tuple, Any
from mysql.connector.connection import MySQLConnection

from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.banco_service.operacoes.i_operacao import IOperacao


class OperacaoMysql(IOperacao):

    def __init__(self, conexao: IConexaoBanco[MySQLConnection]):
        self.__conexao = conexao

    def salvar_consulta(self, sql: str, param: Tuple[Any, ...]):
        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.execute(sql, param)
                conn.commit()

        except Exception as e:
            print(f"Erro ao executar consulta: {e}")
