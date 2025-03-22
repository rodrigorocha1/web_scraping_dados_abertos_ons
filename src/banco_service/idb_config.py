from abc import ABC, abstractmethod


class DBConfig(ABC):
    @abstractmethod
    def obter_conexao_string(self) -> str:
        """
        Método para obter a string de conexão do banco
        Returns:
            str: string de conexão

        """
        pass
