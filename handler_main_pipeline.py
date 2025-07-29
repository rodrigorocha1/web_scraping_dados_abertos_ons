from src.banco_service.operacoes.operacao_mysql import OperacaoMysql
from src.handler_pipeline.checar_conexao_banco_handler import ChecarConexaoBancoHandler
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from mysql.connector.connection import MySQLConnection
from src.contexto.contexto_pipeiine import ContextoPipeline
from src.handler_pipeline.checar_conexao_url_ons import ChecarConexaoUrlOns
from src.handler_pipeline.coletar_links_csv_handler import ColetarLinksCSVHander
from src.handler_pipeline.guardar_dados_banco_handler import GuardaDadosBancoHandler
from src.web_scraping_service.webscrapingbs4service import WebScrapingBS4Service

url_ons = 'https://dados.ons.org.br/'
config_banco = DbConfigMySQL()
conexao_banco = ConexaoBanco[MySQLConnection](config=config_banco)

with conexao_banco:
    operacao_banco = OperacaoMysql(conexao=conexao_banco)
    servico_web_scraping_ons = WebScrapingBS4Service(url=url_ons)
    contexto = ContextoPipeline(lista_sites_csv=[])

    p1 = ChecarConexaoBancoHandler(
        conexao_banco=conexao_banco)
    p2 = ChecarConexaoUrlOns(servico_web_scraping=servico_web_scraping_ons)
    p3 = ColetarLinksCSVHander(servico_web_scraping=servico_web_scraping_ons, flag_carga_completa=True)
    p4 = GuardaDadosBancoHandler()
    p1.set_next(p2).set_next(p3).set_next(p4)
    p1.handler(context=contexto)
