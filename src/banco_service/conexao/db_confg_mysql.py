from typing import Dict, Any, Tuple, Callable
import mysql.connector as mysql_con
from src.config.config import Config

from src.banco_service.conexao.idb_config import IDBConfig


class DbConfigMySQL(IDBConfig):

    def obter_conexao_string(self) -> Tuple[Tuple[Any, ...], Dict[str, Any]]:
        """
        Conexão string
        :return: Nada ou conexão
        :rtype: Tuple[Tuple[Any, ...], Dict[str, Any]]
        """
        return ((), {
            'host': Config.SERVER,
            'port': Config.PORTA,
            'user': Config.USERSQL,
            'password': Config.PASSWORD,
            "database": Config.DATABASE
        })

    def obter_driver(self) -> Callable[..., Any]:
        """
        Método para obter o driver do mysql
        :return: driver do mysql
        :rtype: Callable[..., Any]
        """
        return mysql_con.connect


if __name__ == '__main__':
    db_mysql = DbConfigMySQL()
    print(db_mysql.obter_driver())


    def soma_(a, b):
        return a + b


    dic = {'a': 1, 'b': 2}

    print(soma_(**dic))
