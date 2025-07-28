from abc import ABC, abstractmethod
from typing import TypeVar, Generic, Generator, Tuple, Union, List

T = TypeVar('T')


class IWebScrapingService(ABC, Generic[T]):

    @property
    @abstractmethod
    def url(self) -> str:
        pass

    @url.setter
    @abstractmethod
    def url(self, url: str):
        pass

    @abstractmethod
    def conectar_url(self) -> Union[Tuple[bool, T], bool]:
        pass

    @abstractmethod
    def obter_lista_sites(self, dados_site: T) -> Generator[str, None, None]:
        """

        :param dados_site:
        :type dados_site:
        :return:
        :rtype:
        """
        pass

    @abstractmethod
    def obter_links_csv(self, dados_site: T, flag_carga_completa: bool = True) -> List[str]:
        """

        :param dados_site:
        :type dados_site:
        :param flag_carga_completa:
        :type flag_carga_completa:
        :return:
        :rtype:
        """
        pass

    @abstractmethod
    def checar_conexao_url(self) -> bool:
        pass
