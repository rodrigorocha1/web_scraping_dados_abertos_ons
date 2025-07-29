from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler


class GuardaDadosBancoHandler(Handler):

    def __init__(self):
        pass

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        for url_csv in contexto.lista_sites_csv:
            print(url_csv)
        return True
