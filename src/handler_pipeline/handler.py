from abc import ABC, abstractmethod
from typing import Optional

from src.contexto.contexto_pipeiine import ContextoPipeline
from src.utlis.llog_factory import logger


class Handler(ABC):


    def __init__(self) -> None:
        self._next_handler: Optional["Handler"] = None


    def set_next(self, handler: "Handler"):
        self._next_handler = handler
        return handler

    def handler(self, context: ContextoPipeline) -> None:
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
