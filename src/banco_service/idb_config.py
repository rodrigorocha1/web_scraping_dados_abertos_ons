from abc import ABC, abstractmethod


class IDBConfig(ABC):
    @abstractmethod
    def obter_conexao_string(self) -> str:
        """
        Método para criar a string de conexão
        :return: retorna a string de conexão
        :rtype: str
        """
        pass
