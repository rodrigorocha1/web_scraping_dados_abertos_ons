from src.handler_pipeline.checar_conexao_banco_handler import ChecarConexaoBancoHandler
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.web_scraping_service.webscrapingbs4service import WebScrapingBS4Service
from mysql.connector.connection import MySQLConnection
from src.contexto.contexto_pipeiine import ContextoPipeline
from collections import deque

from src.handler_pipeline.checar_conexao_url_ons import ChecarConexaoUrlOns

url_ons = 'https://dados.ons.org.br/'
config_banco = DbConfigMySQL()
conexao_banco = ConexaoBanco[MySQLConnection]()
contexto = ContextoPipeline(pilha=deque())
servico_web_scraping_ons = WebScrapingBS4Service(url=url_ons)

p1 = ChecarConexaoBancoHandler(conexao_banco=conexao_banco)
p2 = ChecarConexaoUrlOns(servico_web_scraping=servico_web_scraping_ons)

p1.set_next(p2)
p1.handler(context=contexto)
