from abc import ABC, abstractmethod
from typing import TypeVar, Generic, Generator, Tuple, Union, List

T = TypeVar('T')


class IWebScrapingService(ABC, Generic[T]):

    @abstractmethod
    def conectar_url(self) -> Tuple[bool, Union[T, str]]:
        """
            Método para conectar na url
        :return: Retorna uma flag indicando sucesso ou falha e a conexão junto com alguma mensagem
        :rtype: Tuple[bool, Union[T, str]]
        """
        pass

    @abstractmethod
    def obter_lista_sites(self, dados_site: T) -> Generator[str, None, None]:
        """
            Obtem a lista de sites
        :param dados_site: a conexão obtidas
        :type dados_site: T -> o tipo de conexão
        :return: Um generator com as urls
        :rtype: Generator[str, None, None]
        """
        pass

    @abstractmethod
    def obter_links_csv(self, dados_site: T, flag_carga_completa: bool = True) -> Generator[str, None, None]:
        """
            Método para obter os links de conexão
        :param dados_site: dados da conexão
        :type dados_site: T
        :param flag_carga_completa: Flag para indicar carga completa True para carga completa e falso para alterados
        :type flag_carga_completa: bool
        :return: Um generator com os links csv
        :rtype: Generator[str, None, None]
        """
        pass
