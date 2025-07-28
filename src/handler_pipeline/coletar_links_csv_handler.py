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
                dados_site_csv = self.__servico_web_scraping.conectar_url()
                if isinstance(dados_site_csv, tuple):
                    _, dados_csv = dados_site_csv
                    for link_csv in self.__servico_web_scraping.obter_links_csv(
                        dados_site=dados_csv,
                        flag_carga_completa=self.__flag_carga_completa
                    ):
                        print(link_csv)

            return True
        return False
