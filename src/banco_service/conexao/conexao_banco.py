from typing import TypeVar, Optional, Type, Any
import socket
from src.config.config import Config
from src.banco_service.conexao.idb_config import IDBConfig
from src.banco_service.conexao.iconexaobanco import IConexaoBanco

T = TypeVar('T')


class ConexaoBanco(IConexaoBanco[T]):
    conexao: Optional[T] = None

    _config: Optional[IDBConfig] = None

    @classmethod
    def set_config(cls, config: IDBConfig):
        cls._config = config

    @classmethod
    def conectar(cls):
        if cls._config is None:
            raise RuntimeError("Configuração não definida")
        obter_driver = cls._config.obter_driver()
        args, kwargs = cls._config.obter_conexao_string()
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
        except (socket.timeout, socket.error):
            return False

    def __enter__(self) -> T:
        if self.conexao is None:  # Garante que a conexão seja feita ao entrar no contexto
            self.conectar()
        return self.obter_conexao()

    def __exit__(self, exc_type, exc_value, traceback):
        try:
            if self.conexao:
                self.conexao.close()

        except Exception as e:
            print(f"Erro ao fechar a conexão: {e}")
        finally:
            self.conexao = None
