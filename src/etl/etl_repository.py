from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.etl.ietl_repository import IEtlRepository


class EltRepository(IEtlRepository):
    def __init__(self, conexao_banco: ConexaoBanco):
        self.__conexao_banco = conexao_banco

    def inserir_tabela(self):
        with self.__conexao_banco.obter_conexao() as conn:
            conn.execute()

    def consultar_tabela(self):
        pass


if __name__ == '__main__':
    from src.banco_service.conexao.dbconfigsqlserver import DbConfigSQLServer

    etl = EltRepository(conexao_banco=ConexaoBanco(DbConfigSQLServer()))
