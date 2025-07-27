from abc import ABC, abstractmethod
from typing import Optional
import logging
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.utlis.llog_db import LlogDb

FORMATO = '%(asctime)s %(filename)s %(funcName)s  - %(message)s'
db_handler = LlogDb(nome_pacote='Handler', formato_log=FORMATO, debug=logging.DEBUG)
logger = db_handler.loger


class Handler(ABC):
    def __init__(self):
        self._next_handler: Optional["Handler"] = None


    def set_next(self, handler: "Handler"):
        self._next_handler = handler
        return handler

    def handler(self, context: ContextoPipeline):
        if self.executar_processo(context):
            logger.info(f'{self.__class__.__name__} -> Sucesso ao executar')
            if self._next_handler:
                self._next_handler.handler(context)
            else:
                pass
                logger.info(f'{self.__class__.__name__} ->  Último handler da cadeia')
        else:
            pass

            logger.warning(f'{self.__class__.__name__} -> Falha, pipeline interrompido')

    @abstractmethod
    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        pass
