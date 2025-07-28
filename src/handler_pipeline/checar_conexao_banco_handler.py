from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
from typing import TypeVar, Generic
from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.utlis.llog_factory import logger

T = TypeVar('T')


class ChecarConexaoBancoHandler(Handler, Generic[T]):

    def __init__(self, conexao_banco: IConexaoBanco[T]):
        super().__init__()
        self.__conexao_banco = conexao_banco

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        logger.info('Iniciando pipeline')
        logger.info('Iniciando da checagem de conexão do banco')
        if self.__conexao_banco.checar_conexao_banco():
            logger.info(
                'Sucesso ao conectar no banco',
                extra={
                    'requisicao': 'Sucesso'
                }
            )
            return True
        logger.error('Erro ao conectar no banco, telnet retornou fora')
        return False
