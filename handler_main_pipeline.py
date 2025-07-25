from src.handler_pipeline.checar_conexao_banco_handler import ChecarConexaoBancoHandler
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from mysql.connector.connection import MySQLConnection
from src.contexto.contexto_pipeiine import ContextoPipeline
from collections import deque

config_banco = DbConfigMySQL()
conexao_banco = ConexaoBanco[MySQLConnection]()
contexto = ContextoPipeline(pilha=deque())

p1 = ChecarConexaoBancoHandler(conexao_banco=conexao_banco)


p1.handler(context=contexto)
