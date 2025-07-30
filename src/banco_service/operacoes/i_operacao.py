from abc import ABC, abstractmethod
from typing import Any


class IOperacao(ABC):

    @abstractmethod
    def salvar_consulta(self, sql: str, param: Any):
        pass

    @abstractmethod
    def salvar_em_lote(self, sql: str, param: Any):
        pass
