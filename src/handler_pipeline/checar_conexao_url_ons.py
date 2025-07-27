from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService
from typing import TypeVar, Generic

T = TypeVar('T')


class ChecarConexaoUrlOns(Handler):

    def __init__(self, servico_web_scraping: IWebScrapingService[T]):
        super().__init__()
        self.__servico_web_scraping = servico_web_scraping

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        if self.__servico_web_scraping.checar_conexao_url():
            return True
        return False
