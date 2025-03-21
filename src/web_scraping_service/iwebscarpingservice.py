from abc import ABC, abstractmethod
from typing import TypeVar, Generic, Generator

T = TypeVar('T')


class IWebScrapingService(ABC, Generic[T]):
    @abstractmethod
    def conectar_url(self, url) -> T:
        pass

    @abstractmethod
    def obter_lista_sites(self) -> Generator[str, None, None]:
        pass
