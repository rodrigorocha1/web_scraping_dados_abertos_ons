from typing import TypeVar

from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService

T = TypeVar('T')


class ColetarLinksCSVHander(Handler):
    def __init__(self, servico_web_scraping: IWebScrapingService[T], flag_carga_completa: bool):
        super().__init__()
        self.__servico_web_scraping = servico_web_scraping
        self.__flag_carga_completa = flag_carga_completa

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        resultado = self.__servico_web_scraping.conectar_url()

        if isinstance(resultado, tuple):
            _, dados_site = resultado
            for link in self.__servico_web_scraping.obter_lista_sites(dados_site=dados_site):
                self.__servico_web_scraping.url = link

        return True
