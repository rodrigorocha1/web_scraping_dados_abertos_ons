from src.banco_service.operacoes.i_operacao import IOperacao
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.handler import Handler


class GuardaDadosBancoHandler(Handler, ):

    def __init__(self, operacao_banco: IOperacao, carga_completa: bool):
        super().__init__()
        self.__carga_completa = carga_completa
        self.__operacao_banco = operacao_banco

    def executar_processo(self, contexto: ContextoPipeline) -> bool:
        urls = contexto.lista_sites_csv
        lista_tabelas = self.__operacao_banco.recuperar_lista_tabelas()
        urls.sort()
        print(f'Total Urls  {len(urls)}')
        print(f'Total lista_tabelas  {len(lista_tabelas)}')

        for url, tabela in zip(urls, lista_tabelas):
            print(tabela, '|', url)

        # for url_csv in urls:
        #     dataframe_csv = pd.read_csv(url_csv, sep=';', encoding='utf-8')
        #     colunas = ['id_param'] + list(dataframe_csv.columns)
        #     placeholders = ', '.join(['%s'] * len(colunas))
        #     sql = f"""
        #         INSERT INTO tabela ({colunas})
        #         values({placeholders})
        #     """
        #     valores = list(dataframe_csv.itertuples(index=True, name=None))
        #     self.__operacao_banco.salvar_em_lote(sql=sql, param=valores)
        #     sleep(2)
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
