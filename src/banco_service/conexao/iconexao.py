from abc import ABC, abstractmethod
from typing import Generic, TypeVar, Type, Optional, Any

T = TypeVar('T')


class IConexao(ABC, Generic[T]):

    @abstractmethod
    def obter_conexao(self) -> T:
        """
        Método para obter a conexão
        :return: a conexão do banco de dados
        :rtype: T
        """
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
