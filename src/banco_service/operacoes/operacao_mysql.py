from typing import Tuple, Any, List, cast
from mysql.connector.connection import MySQLConnection
from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.banco_service.operacoes.i_operacao import IOperacao
from src.config.config import Config


class OperacaoMysql(IOperacao):

    def __init__(self, conexao: IConexaoBanco[MySQLConnection]):
        self.__conexao = conexao

    def executar_consulta_simples(self, sql: str, param: Tuple[Any, ...] = ()) -> Any:
        """
        Método para executar consulta simples
        :param sql: Script sql select
        :type sql: str
        :param param: parametros
        :type param: param: Tuple[Any, ...] = ()
        :return: Resultado
        :rtype: Any
        """
        from src.utlis.llog_factory import logger

        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.execute(sql, param)
                resultado = cursor.fetchone()
                if resultado:
                    return resultado
                return None
        except Exception as e:
            logger.warning(
                'Erro ao executar consulta simples',
                extra={
                    'requisicao': str(sql) + str(param),
                    'mensagem_de_excecao_tecnica': str(e)
                }
            )
            return None

    def salvar_consulta(self, sql: str, param: Tuple[Any, ...]):
        """
         Método para salvar a consulta
        :param sql: Insert sql
        :type sql: str
        :param param: Qualquer coinsa
        :type param: Any
        :return:
        :rtype:
        """
        from src.utlis.llog_factory import logger
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
                    'requisicao': None,
                    'mensagem_de_excecao_tecnica': str(e)
                }
            )

    def recuperar_lista_tabelas(self) -> List[str]:
        sql = f"""
            select t.TABLE_NAME
            FROM information_schema.TABLES t 
            where t.TABLE_SCHEMA = '{Config.DATABASE}' 
        """
        with self.__conexao as conn:
            cursor = conn.cursor()
            cursor.execute(sql)
            resultado = cursor.fetchall()
            tabelas: List[str] = [cast(str, linha[0]) for linha in resultado]
        return tabelas

    def salvar_em_lote(self, sql: str, param: List[Tuple[Any, ...]]):
        """
        Método para salvar em lote
        :param sql: Insert sql
        :type sql: str
        :param param: parametros do script
        :type param: List[Tuple[Any, ...]]
        :return:
        :rtype:
        """
        from src.utlis.llog_factory import logger

        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.executemany(sql, param)

                conn.commit()

        except Exception as e:
            logger.warning(
                'Erro ao executar a consulta',
                extra={
                    'requisicao': str(sql) + str(param),
                    'mensagem_de_excecao_tecnica': str(e)
                }
            )
