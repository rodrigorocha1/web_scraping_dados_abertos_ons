from typing import Any
from src.banco_service.idb_config import IDBConfig
from src.banco_service.db_confg_mysql import DbConfigMySQL
from src.banco_service.iconexao import IConexao


class ConexaoBanco(IConexao):
    """
    Classe para conectar no banco
    """
    _instancia = None
    conexao: Any

    def __new__(cls, config: IDBConfig, *args, **kwargs, ) -> "ConexaoBanco":
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

    def obter_conexao(self) :
        """
            Método pra obter a conexão
        :return: Retorna a conexão
        :rtype: pyodbc.Connection
        """

        return self.conexao  # type: ignore


if __name__ == "__main__":
    a = ConexaoBanco(DbConfigMySQL())
    c = a.obter_conexao()
    print('conexão', c)
