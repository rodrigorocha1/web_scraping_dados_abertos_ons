from typing import TypeVar, Optional
import socket
from xml.sax.handler import property_interning_dict

from config.config import Config
from src.banco_service.conexao.idb_config import IDBConfig
from src.banco_service.conexao.iconexao import IConexao

T = TypeVar('T')


class ConexaoBanco(IConexao[T]):
    """
    Classe para conectar no banco
    """

    conexao: Optional[T] = None

    @classmethod
    def conectar(cls, config: IDBConfig):
        obter_driver = config.obter_driver()
        args, kwargs = config.obter_conexao_string()
        cls.conexao = obter_driver(*args, **kwargs)

    @classmethod
    def obter_conexao(cls) -> T:
        if cls.conexao:
            return cls.conexao
        raise RuntimeError('ERRO DE Conexão')

    @classmethod
    def checar_conexao_banco(cls) -> bool:
        try:
            with socket.create_connection((Config.SERVER, int(Config.PORTA)), timeout=10):
                return True
        except(socket.timeout, socket.error):
            return False

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

    from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL

    f = ConexaoBanco[MySQLConnection].checar_conexao_banco()
    print(f)
    config = DbConfigMySQL()

    ConexaoBanco[MySQLConnection].conectar(config)
    with ConexaoBanco[MySQLConnection].obter_conexao() as conexao:
        cursor = conexao.cursor()
        cursor.execute('Select 1')
        print(cursor.fetchall())
