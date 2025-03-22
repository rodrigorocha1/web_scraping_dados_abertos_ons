from abc import ABC, abstractmethod

class IConexao(ABC):

    @abstractmethod
    def obter_conexao(self):
        pass