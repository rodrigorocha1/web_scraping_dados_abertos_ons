from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.banco_service.conexao.idb_config import IDBConfig


class Operacao:

    def __init__(self, conexao: IDBConfig):
        self.__conexao = conexao

    def teste(self):
        return 1


if __name__ == '__main__':
    c = Operacao(conexao=DbConfigMySQL())


