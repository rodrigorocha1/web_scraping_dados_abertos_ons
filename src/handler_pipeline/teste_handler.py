from typing import Generic, TypeVar

from src.banco_service.conexao.idb_config import IDBConfig
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
from src.banco_service.conexao.conexao_banco import ConexaoBanco

T = TypeVar('T')

class TesteHandler(Handler, Generic[T]):
    def __init__(self, config : IDBConfig):
        super().__init__()
        self.__config = config

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        ConexaoBanco[T].conectar(config=self.__config)

        return True