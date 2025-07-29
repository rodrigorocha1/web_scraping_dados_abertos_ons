from typing import TypeVar

from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler

T = TypeVar('T')


class GuardaDadosBancoHandler(Handler):

    def __init__(self, conexao_banco: IConexaoBanco[T]):
        super().__init__()
        self.__conexao_banco = conexao_banco

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        for url_csv in contexto.lista_sites_csv:
            print(url_csv)
        return True
