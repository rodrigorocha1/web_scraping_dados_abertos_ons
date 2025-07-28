from typing_extensions import TypeVar

from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
from src.utlis.llog_factory import logger
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService

T = TypeVar('T')

class ChecarConexaoUrlOns(Handler):

    def __init__(self, servico_web_scraping: IWebScrapingService[T]):
        super().__init__()
        self.__servico_web_scraping = servico_web_scraping

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        logger.info('Iniciando da checagem de conexão do banco')
        if self.__servico_web_scraping.checar_conexao_url():
            logger.info('Sucesso ao conectar no site da ONS')
            return True
        logger.error('Falha ao conectar no site da ONS')
        return False
