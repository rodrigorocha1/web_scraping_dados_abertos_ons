from time import sleep
from typing import cast, Union, List, Tuple
from datetime import datetime
from src.utlis.llog_factory import logger
from src.banco_service.operacoes.i_operacao import IOperacao
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler
import pandas as pd


class GuardaDadosBancoHandler(Handler, ):

    def __init__(self, operacao_banco: IOperacao, carga_completa: bool):
        super().__init__()
        self.__carga_completa = carga_completa
        self.__operacao_banco = operacao_banco
        self.__data_atual = datetime.now().date()

    def __obter_dataframe_filtrado(self, tabela: str, dataframe_csv: pd.DataFrame) -> pd.DataFrame:

        if not self.__carga_completa:
            sql = """
                   select *
                   FROM param_id_max pim
                   where pim.NOME_TABELA = %s
               """
            param = (tabela,)

            _, id_param_banco, flag_url_sem_data, data_atualizacao = self.__operacao_banco.executar_consulta_simples(
                sql=sql,
                param=param
            )

            id_param_banco = cast(int, id_param_banco)
            flag_url_sem_data = cast(bool, flag_url_sem_data)
            data_atualizacao = cast(datetime, data_atualizacao)

            dataframe_csv = dataframe_csv[dataframe_csv['id_param'] > id_param_banco] \
                if flag_url_sem_data \
                else (
                dataframe_csv[dataframe_csv['id_param'] > id_param_banco]
                if self.__data_atual == data_atualizacao.date()
                else
                dataframe_csv
            )
        return dataframe_csv

    def __gravar_dados_dataframe(
            self,
            tabela: str,
            colunas_sql: str,
            placeholders: str,
            url_csv: str,
            dataframe_csv: pd.DataFrame
    ):
        sql = f"""
               INSERT INTO `{tabela}` ({colunas_sql})
               VALUES ({placeholders})
           """

        logger.info(
            f'Inserindo dados na tabela {tabela}',
            extra={
                'url': url_csv
            }
        )
        dataframe_csv = dataframe_csv.where(pd.notnull(dataframe_csv), None)
        valores = list(dataframe_csv.itertuples(index=False, name=None))
        self.__operacao_banco.salvar_em_lote(sql=sql, param=valores)

    def __gravar_id(self, dataframe_csv: pd.DataFrame, tabela: str):
        id_max = int(dataframe_csv['id_param'].max())
        sql = """

                                   UPDATE param_id_max
                                   SET id_max = %s
                                   WHERE NOME_TABELA = %s

                               """
        params = (id_max, tabela)
        self.__operacao_banco.salvar_consulta(sql, params)

    def __obter_parametros(self, url_csv: str) -> Tuple[str, pd.DataFrame, str, str]:
        tabela = url_csv.split('/')[-2].replace('-', '_')
        sleep(3)
        dataframe_csv = pd.read_csv(url_csv, sep=';', encoding='utf-8')
        dataframe_csv = dataframe_csv.reset_index()
        dataframe_csv = dataframe_csv.rename(
            columns={
                'index': 'id_param'
            }
        )

        colunas = list(dataframe_csv.columns)
        colunas_sql = ', '.join(colunas)
        placeholders = ', '.join(['%s'] * len(colunas))
        return tabela, dataframe_csv, colunas_sql, placeholders

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        urls_csv = contexto.lista_sites_csv
        for url_csv in urls_csv:
            tabela, dataframe_csv, colunas_sql, placeholders = self.__obter_parametros(url_csv=url_csv)
            dataframe_filtrado = self.__obter_dataframe_filtrado(tabela=tabela, dataframe_csv=dataframe_csv)
            self.__gravar_dados_dataframe(
                tabela=tabela,
                dataframe_csv=dataframe_filtrado,
                colunas_sql=colunas_sql,
                placeholders=placeholders,
                url_csv=url_csv,
            )
            self.__gravar_id(dataframe_csv=dataframe_filtrado, tabela=tabela)
            placeholders = ''
        return True
