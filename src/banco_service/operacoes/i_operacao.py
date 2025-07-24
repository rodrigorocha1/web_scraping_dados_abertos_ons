from abc import ABC, abstractmethod


class IOperacao(ABC):


    @abstractmethod
    def salvar_consulta(self):
        pass
