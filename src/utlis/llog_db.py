import logging
from colorama import Fore, Style, init
from typing import Literal

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


class LlogDb(logging.Handler):
    def __init__(self, nome_pacote: str, debug: LogLevel, formato_log: str = None, ):
        super().__init__()
        self.__operacao_banco = OperacaoMysql()
        self.loger = logging.getLogger(nome_pacote)
        self.__FORMATO_LOG = formato_log
        self.__formater = logging.Formatter(self.__FORMATO_LOG)
        self.setFormatter(self.__FORMATO_LOG)
        self.loger.addHandler(self)
        self.loger.setLevel(debug)

    def emit(self, record):
        pass



