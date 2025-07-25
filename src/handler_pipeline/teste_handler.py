from typing import Generic, TypeVar

from src.banco_service.conexao.iconexao import IConexao

from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler


T = TypeVar('T')


class TesteHandler(Handler):
    def __init__(self,conexao: IConexao[T]):
        super().__init__()

        self.__conexao = conexao



    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        # ConexaoBanco[T].conectar()
        self.__conexao.conectar()

        return True