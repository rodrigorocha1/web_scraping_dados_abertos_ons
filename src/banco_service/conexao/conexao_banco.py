from typing import TypeVar, Optional, Type, Any
import socket
from src.config.config import Config
from src.banco_service.conexao.idb_config import IDBConfig
from src.banco_service.conexao.iconexaobanco import IConexaoBanco

T = TypeVar('T')


class ConexaoBanco(IConexaoBanco[T]):


    def __init__(self, config: IDBConfig):
        self.__conexao: Optional[T] = None
        self.__config: Optional[IDBConfig] = config



    def conectar(self):
        if self.__config is None:
            raise RuntimeError("Configuração não definida")
        obter_driver = self.__config.obter_driver()
        args, kwargs = self.__config.obter_conexao_string()
        self.__conexao = obter_driver(*args, **kwargs)


    def obter_conexao(self) -> T:
        if self.__conexao:
            return self.__conexao
        raise RuntimeError('ERRO DE Conexão')

    @classmethod
    def checar_conexao_banco(cls) -> bool:
        try:
            with socket.create_connection((Config.SERVER, int(Config.PORTA)), timeout=10):
                return True
        except (socket.timeout, socket.error):
            return False

    def __enter__(self) -> T:
        if self.__conexao is None:  # Garante que a conexão seja feita ao entrar no contexto
            self.conectar()
        return self.obter_conexao()

    def __exit__(self, exc_type, exc_value, traceback):
        try:
            if self.__conexao:
                self.__conexao.close()

        except Exception as e:
            print(f"Erro ao fechar a conexão: {e}")
        finally:
            self.__conexao = None
