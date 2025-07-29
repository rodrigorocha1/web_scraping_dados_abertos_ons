from time import sleep
from typing import TypeVar, Generic
import pandas as pd
from src.banco_service.operacoes.i_operacao import IOperacao
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler


class GuardaDadosBancoHandler(Handler):

    def __init__(self, operacao_banco: IOperacao, carga_completa: bool):
        super().__init__()
        self.__carga_completa = carga_completa
        self.__operacao_banco = operacao_banco

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        urls = ['https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/hist_despacho_energia/info2024.csv']
        for url_csv in urls:
            dataframe_csv = pd.read_csv(url_csv, sep=';', encoding='utf-8')
            print(url_csv)
            print(dataframe_csv.head())
            sleep(2)
        return True
