from itertools import chain
from typing import TypeVar, List

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
            lista_sites = list(self.__servico_web_scraping.obter_lista_sites(dados_site=dados_site))

            def processar_site(url: str) -> List[str]:
                self.__servico_web_scraping.url = url
                resultado_site = self.__servico_web_scraping.conectar_url()
                if isinstance(resultado_site, tuple):
                    _, dados_site_processado = resultado_site
                    return self.__servico_web_scraping.obter_links_csv(
                        dados_site=dados_site_processado,
                        flag_carga_completa=self.__flag_carga_completa
                    )
                return []
            lista_links = list(map(processar_site, lista_sites))
            links_csv = list(chain.from_iterable(lista_links))
            links_csv = links_csv[0:5]
            contexto.lista_sites_csv = links_csv


            return True
        return False
