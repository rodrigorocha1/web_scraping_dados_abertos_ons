from src.banco_service.conexao_banco import ConexaoBanco
from src.etl.ietl_repository import IEtlRepository


class EltRepository(IEtlRepository):
    def __init__(self, conexao_banco: ConexaoBanco):
        self.__conexao_banco = conexao_banco
        print(self.__conexao_banco.obter_conexao())



if __name__ == '__main__':
    from src.banco_service.dbconfigsqlserver import DbConfigSQLServer

    etl = EltRepository(conexao_banco=ConexaoBanco(DbConfigSQLServer()))
