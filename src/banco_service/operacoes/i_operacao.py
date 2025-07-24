from abc import ABC, abstractmethod


class IOperacao(ABC):

    @abstractmethod
    def checar_conexao(self) -> bool:
        pass

    @abstractmethod
    def salvar_consulta(self):
        pass
