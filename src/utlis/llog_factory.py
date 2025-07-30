import logging
from mysql.connector import MySQLConnection

from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql_log import DbConfigMySqlLOG
from src.banco_service.operacoes.operacao_mysql import OperacaoMysql
from src.utlis.llog_db import LlogDb

config_log = DbConfigMySqlLOG()
FORMATO = '%(asctime)s %(filename)s %(funcName)s  - %(message)s'
conexao_banco_log = ConexaoBanco[MySQLConnection](config=config_log)
operacao_mysql_log = OperacaoMysql(conexao=conexao_banco_log)
db_handler = LlogDb(nome_pacote='Handler', formato_log=FORMATO, debug=logging.DEBUG, operacao_banco=operacao_mysql_log)
logger = db_handler.loger
