import pyodbc
from src.banco_service.idb_config import IDBConfig
from src.banco_service.dbconfigsqlserver import DbConfigSQLServer

class ConexaoBanco:
    _instancia = None

    def __new__(cls, config: IDBConfig, *args, **kwargs, ):
        if cls._instancia is None:
            cls._instancia = super(ConexaoBanco, cls).__new__(cls)
            cls._instancia.conexao = pyodbc.connect(config.obter_conexao_string())
        return cls._instancia
    def obter_conexao(self):
        return self.conexao


if __name__ == "__main__":
    a = ConexaoBanco(DbConfigSQLServer()).obter_conexao()
    print(a.cursor())