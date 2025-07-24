from typing import  TypeVar
from src.banco_service.conexao.idb_config import IDBConfig
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.banco_service.conexao.iconexao import IConexao

T = TypeVar('T')

class ConexaoBanco(IConexao[T]):
    """
    Classe para conectar no banco
    """
    _instancia = None
    conexao: T

    def __new__(cls, config: IDBConfig, *args, **kwargs, ) -> "ConexaoBanco[T]":
        """

        :param config:
        :type config:
        :param args:
        :type args:
        :param kwargs:
        :type kwargs:
        """

        if cls._instancia is None:
            cls._instancia = super(ConexaoBanco, cls).__new__(cls)
            try:
                obter_driver = config.obter_driver()
                args, kwargs = config.obter_conexao_string()
                cls._instancia.conexao = obter_driver(*args, **kwargs)
            except Exception as e:
                raise ConnectionError(f"Falha na conexão com o banco de dados: {e}")

        return cls._instancia

    def obter_conexao(self) -> T:
        """
            Método pra obter a conexão
        :return: Retorna a conexão
        :rtype: pyodbc.Connection
        """

        return self.conexao  # type: ignore

    def __enter__(self):
        return self.obter_conexao()

    def __exit__(self, exc_type, exc_value, traceback):
        try:
            if self.conexao:
                self.conexao.close()
        except Exception as e:
            print(f"Erro ao fechar a conexão: {e}")


if __name__ == "__main__":
    from mysql.connector.connection import MySQLConnection

    with ConexaoBanco[MySQLConnection](DbConfigMySQL()) as conexao:
        cursor = conexao.cursor()
        cursor.execute('Select 1')


        print('conexão', cursor.fetchall())
