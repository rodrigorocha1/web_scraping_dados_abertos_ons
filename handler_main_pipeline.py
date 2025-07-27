from src.banco_service.operacoes.operacao_mysql import OperacaoMysql
from src.handler_pipeline.checar_conexao_banco_handler import ChecarConexaoBancoHandler
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.utlis.llog_db import LlogDb
from src.web_scraping_service.webscrapingbs4service import WebScrapingBS4Service
from mysql.connector.connection import MySQLConnection
from src.contexto.contexto_pipeiine import ContextoPipeline
from collections import deque
from src.handler_pipeline.checar_conexao_url_ons import ChecarConexaoUrlOns

url_ons = 'https://dados.ons.org.br/'
config_banco = DbConfigMySQL()
conexao_banco = ConexaoBanco[MySQLConnection]()
conexao_banco.set_config(config=config_banco)

with conexao_banco:
    operacao_banco = OperacaoMysql(conexao=conexao_banco)


    contexto = ContextoPipeline(pilha=deque())
    p1 = ChecarConexaoBancoHandler(conexao_banco=conexao_banco)


    p1.handler(context=contexto)
