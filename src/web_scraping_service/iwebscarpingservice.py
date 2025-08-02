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
        """
        Método para conectar na URL
        :return: Tupla com verdadeiro se a conexão for feita com sucesso, falso caso contrário e os dados do site, ou falso se a url cair
        :rtype:  Union[Tuple[bool, T], bool]
        """
        pass

    @abstractmethod
    def obter_lista_sites(self, dados_site: T) -> Generator[str, None, None]:
        """
        Método para obter os sites da ons
        :param dados_site: dados do SITE
        :type dados_site: T
        :return: GERADOR com as urls
        :rtype:Generator[str, None, None]
        """
        pass

    @abstractmethod
    def obter_links_csv(self, dados_site: T, flag_carga_completa: bool = True) -> List[str]:
        """
        Método para obter os links csv
        :param dados_site: dados do site
        :type dados_site: T
        :param flag_carga_completa: flag de carga completa, true se a carga for completa, falso caso contrário
        :type flag_carga_completa: bool
        :return: Lista das urls
        :rtype: List[str]
        """
        pass

    @abstractmethod
    def checar_conexao_url(self) -> bool:
        pass
