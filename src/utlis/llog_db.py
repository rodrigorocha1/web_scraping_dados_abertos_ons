import logging
from colorama import Fore, Style, init
from typing import Literal, TypeVar
from datetime import datetime

from mysql.connector import MySQLConnection

from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.banco_service.conexao.iconexaobanco import IConexaoBanco
from src.banco_service.operacoes.i_operacao import IOperacao
from src.banco_service.operacoes.operacao_mysql import OperacaoMysql

LogLevel = Literal[0, 10, 20, 30, 40, 50]


class ColorFormatter(logging.Formatter):
    COLORS = {
        logging.DEBUG: Fore.CYAN,
        logging.INFO: Fore.BLUE,
        logging.WARNING: Fore.YELLOW,
        logging.ERROR: Fore.RED,
        logging.CRITICAL: Fore.MAGENTA + Style.BRIGHT
    }

    def format(self, record):
        log_color = self.COLORS.get(record.levelno, "")
        message = super().format(record)
        return f"{log_color}{message}{Style.RESET_ALL}"


R = TypeVar('R')


class LlogDb(logging.Handler):
    def __init__(
            self,
            debug: LogLevel,
            conexao: IConexaoBanco[R],

            operacao_banco: IOperacao,
            nome_pacote: str = None,
            formato_log: str = None

    ):
        super().__init__()

        self.__operacao_banco = operacao_banco
        self.loger = logging.getLogger(nome_pacote)
        self.__FORMATO_LOG = formato_log
        self.__formater = logging.Formatter(self.__FORMATO_LOG)
        self.setFormatter(self.__FORMATO_LOG)
        self.loger.addHandler(self)
        self.loger.setLevel(debug)

    def emit(self, record):
        timestamp = datetime.fromtimestamp(record.created).strftime("%Y-%m-%d %H:%M:%S")
        status_code = getattr(record, 'status_code', None)
        mensagem_de_excecao_tecnica = getattr(record, 'mensagem_de_excecao_tecnica', None)
        requisicao = getattr(record, 'requisicao', None)
        url = getattr(record, 'url', None)
        log_entry = self.format(record)
        sql = 'INSERT INTO logs VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        params = (
            timestamp,
            record.levelname,
            record.msg,

            record.name,
            record.filename,
            record.funcName,

            record.lineno,
            url,
            mensagem_de_excecao_tecnica,
            requisicao,
            status_code
        )
        self.__operacao_banco.salvar_consulta(sql=sql, param=params)


log = LlogDb()
