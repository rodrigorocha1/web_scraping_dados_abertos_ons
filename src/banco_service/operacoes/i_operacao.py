from abc import ABC, abstractmethod
from typing import Any, List, Tuple


class IOperacao(ABC):

    @abstractmethod
    def executar_consulta_simples(self, sql: str, param: Tuple[Any, ...] = ()) -> Any:
        """
        Método para executar consulta simples
        :param sql: Script sql select
        :type sql: str
        :param param: parametros
        :type param: param: Tuple[Any, ...] = ()
        :return: Resultado
        :rtype: Any
        """
        pass

    @abstractmethod
    def salvar_consulta(self, sql: str, param: Any):
        """
        Método para salvar a consulta
        :param sql: Insert sql
        :type sql: str
        :param param: Qualquer coinsa
        :type param: Any
        :return:
        :rtype:
        """
        pass

    @abstractmethod
    def salvar_em_lote(self, sql: str, param: Any):
        """
        Método para salvar em lote
        :param sql: Insert sql
        :type sql: str
        :param param: parametros do script
        :type param: Any
        :return:
        :rtype:
        """
        pass

    @abstractmethod
    def recuperar_lista_tabelas(self) -> List[str]:

        pass
