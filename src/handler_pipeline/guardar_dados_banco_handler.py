from time import sleep
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

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        urls_csv = contexto.lista_sites_csv

        print(f'Total Urls  {len(urls_csv)}')


        for url_csv in urls_csv:
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

            if not self.__carga_completa:
                sql = """
                    select pim.id_max as id_param
                    FROM param_id_max pim
                    where pim.NOME_TABELA = %s
                """
                param = (tabela,)
                id_param_banco = self.__operacao_banco.executar_consulta_simples(sql=sql, param=param)
                print('id_param_banco')
                print(id_param_banco)
                dataframe_csv = dataframe_csv[dataframe_csv['id_param'] > id_param_banco]
            # Verificação de dataframe vazio
            print(dataframe_csv)
            if not dataframe_csv.empty:
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
                dataframe_csv = dataframe_csv.fillna(value=pd.NA).astype(object).where(pd.notnull, None)
                valores = list(dataframe_csv.itertuples(index=False, name=None))
                self.__operacao_banco.salvar_em_lote(sql=sql, param=valores)
                colunas.clear()

                id_max = dataframe_csv['id_param'].max()
                sql = """

                    UPDATE param_id_max
                    SET id_max = %s
                    WHERE NOME_TABELA = %s

                """
                params = (id_max, tabela)
                flag = self.__operacao_banco.salvar_consulta(sql, params)
                placeholders = ""
                colunas.clear()
                sleep(2)
            else:
                logger.info(
                    'Dataframe vazio para a url csv',
                    extra={
                        'url': url_csv
                    }
                )

        return True


if __name__ == '__main__':
    from src.web_scraping_service.webscrapingbs4service import WebScrapingBS4Service
    from src.banco_service.operacoes.operacao_mysql import OperacaoMysql
    from mysql.connector import MySQLConnection
    from src.banco_service.conexao.conexao_banco import ConexaoBanco
    from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL

    config_banco = DbConfigMySQL()
    conexao_banco = ConexaoBanco[MySQLConnection](config=config_banco)
    url_ons = 'https://dados.ons.org.br/'
    with conexao_banco:
        operacao_banco = OperacaoMysql(conexao=conexao_banco)
        servico_web_scraping_ons = WebScrapingBS4Service(url=url_ons)
        contexto = ContextoPipeline(lista_sites_csv=[])
        p4 = GuardaDadosBancoHandler(operacao_banco=operacao_banco, carga_completa=False)
        p4.executar_processo(contexto=ContextoPipeline([]))
