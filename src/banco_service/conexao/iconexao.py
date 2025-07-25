from abc import ABC, abstractmethod
from typing import Generic, TypeVar, Type, Optional, Any

from src.banco_service.conexao.idb_config import IDBConfig

T = TypeVar('T')


class IConexao(ABC, Generic[T]):

    @abstractmethod
    def obter_conexao(self) -> T:
        pass

    @abstractmethod
    def conectar(self) -> None:
        """
        Método de classe abstrato para conectar no banco
        """
        pass

    @abstractmethod
    def checar_conexao_banco(self) -> bool:
        pass

    @abstractmethod
    def __enter__(self) -> T:
        """
        Método chamado ao entrar no gerenciador de contexto
        :return: a conexão do banco de dados
        """
        pass

    @abstractmethod
    def __exit__(self, exc_type: Optional[Type[BaseException]],
                 exc_value: Optional[BaseException],
                 traceback: Optional[Any]) -> Optional[bool]:
        """
        Método chamado ao sair do gerenciador de contexto
        :param exc_type: Tipo da exceção (se ocorreu)
        :param exc_value: Valor da exceção (se ocorreu)
        :param traceback: Traceback da exceção (se ocorreu)
        :return: Opcionalmente, True para suprimir exceções
        """
        pass
