from abc import ABC, abstractmethod


class IEtlRepository(ABC):
    @abstractmethod
    def inserir_tabela(self):
        pass

    @abstractmethod
    def consultar_tabela(self):
        pass
