from abc import ABC, abstractmethod
from typing import Any, List, Tuple


class IOperacao(ABC):

    @abstractmethod
    def executar_consulta_simples(self, sql: str, param: Tuple[Any, ...] = ()) -> Any:
        pass

    @abstractmethod
    def salvar_consulta(self, sql: str, param: Any):
        pass

    @abstractmethod
    def salvar_em_lote(self, sql: str, param: Any):
        pass

    @abstractmethod
    def recuperar_lista_tabelas(self) -> List[str]:
        pass
