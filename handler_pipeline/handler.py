from abc import ABC, abstractmethod
from typing import Optional

from contexto.contexto_pipeiine import ConextoPipeline


class Handler(ABC):
    def __init__(self):
        self._next_handler: Optional["Handler"] = None

    def set_next(self, handler: "Handler"):
        self._next_handler = handler
        return handler

    def handler(self, context: ConextoPipeline):
        if self.executar_processo(context):

            if self.executar_processo(context):
                # logger.info(f'{self.__class__.__name__} -> Sucesso ao executar')
                if self._next_handler:
                    self._next_handler.handler(context)
                else:
                    pass
                    # logger.info(f'{self.__class__.__name__} ->  Último handler da cadeia')
            else:
                pass

                # logger.warning(f'{self.__class__.__name__} -> Falha, pipeline interrompido')

    @abstractmethod
    def executar_processo(self, contexto: ConextoPipeline) -> bool:
        pass
