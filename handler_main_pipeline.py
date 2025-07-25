from mysql.connector.connection import MySQLConnection

from src.handler_pipeline.checar_conexao_banco_handler import ChecarConexaoBancoHandler
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL

config_banco = DbConfigMySQL()
ConexaoBanco[MySQLConnection].conectar(config=config_banco)
p1 = ChecarConexaoBancoHandler[ConexaoBanco[MySQLConnection]]