from typing import Dict, Any, Tuple, Callable
import mysql.connector as mysql_con
from src.config.config import Config

from src.banco_service.conexao.idb_config import IDBConfig


class DbConfigMySqlLOG(IDBConfig):

    def obter_conexao_string(self) -> Tuple[Tuple[Any, ...], Dict[str, Any]]:
        """
        Conexão string
        :return: Nada ou conexão
        :rtype: Tuple[Tuple[Any, ...], Dict[str, Any]]
        """
        return ((), {
            'host': Config.SERVER_LOG,
            'port': Config.PORTA_LOG,
            'user': Config.USERSQL_LOG,
            'password': Config.USERSQL_LOG,
            "database": Config.DATABASE_LOG
        })

    def obter_driver(self) -> Callable[..., Any]:
        """
        Método para obter o driver de qualquer banco
        :return: driver do mysql
        :rtype: Callable[..., Any]
        """
        return mysql_con.connect


