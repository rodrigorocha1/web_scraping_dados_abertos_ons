from abc import ABC, abstractmethod
from collections.abc import Callable
from typing import Any


class IDBConfig(ABC):

    @abstractmethod
    def obter_driver(self) -> Callable[..., Any]:
        """
        Método para obter o driver do banco
        :return: driver de conexão
        :rtype: Callable[..., Any]
        """
        pass

    @abstractmethod
    def obter_conexao_string(self) -> Any:
        """
        Método para criar a string de conexão
        :return: retorna a string de conexão
        :rtype: Any
        """
        pass
