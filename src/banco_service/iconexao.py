from abc import ABC, abstractmethod
from typing import Generic, TypeVar

T = TypeVar('T')


class IConexao(ABC, Generic[T]):

    @abstractmethod
    def obter_conexao(self) -> T:
        pass
