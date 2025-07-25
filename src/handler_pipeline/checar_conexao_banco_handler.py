from src.contexto.contexto_pipeiine import ConextoPipeline
from src.handler_pipeline.handler import Handler
from typing import TypeVar, Generic

from src.banco_service.conexao.iconexao import IConexao

T = TypeVar('T')


class ChecarConexaoBancoHandler(Handler, Generic[T]):

    def __init__(self, conexao_banco: IConexao[T]):
        super().__init__()
        self.__conexao_banco = conexao_banco

    def executar_processo(self, contexto: ConextoPipeline):
        if self.__conexao_banco.checar_conexao_banco():
            return True
        return False
