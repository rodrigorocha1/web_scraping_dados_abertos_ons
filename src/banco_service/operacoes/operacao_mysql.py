from typing import Tuple, Any, List
from mysql.connector.connection import MySQLConnection
from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.banco_service.operacoes.i_operacao import IOperacao
from src.utlis.llog_factory import logger


class OperacaoMysql(IOperacao):

    def __init__(self, conexao: IConexaoBanco[MySQLConnection]):
        self.__conexao = conexao

    def salvar_consulta(self, sql: str, param: Tuple[Any, ...]):
        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.execute(sql, param)
                consulta = cursor.statement
                conn.commit()

        except Exception as e:
            logger.warning(
                'Erro ao executar a consulta',
                extra={
                    'requisicao': consulta,
                    'mensagem_de_excecao_tecnica': str(e)
                }
            )

    def salvar_em_lote(self, sql: str, param: List[Tuple[Any, ...]]):
        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.executemany(sql, param)
                consulta = cursor.statement
                conn.commit()
        except Exception as e:
            logger.warning(
                'Erro ao executar a consulta',
                extra={
                    'requisicao': consulta,
                    'mensagem_de_excecao_tecnica': str(e)
                }
            )
