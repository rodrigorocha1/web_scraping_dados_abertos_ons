import logging
from colorama import Fore, Style, init
from typing import Literal

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
    def __init__(self):
        super().__init__()
