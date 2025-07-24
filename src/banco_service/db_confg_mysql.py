from typing import Dict, Any, Tuple, Callable
import os
from dotenv import load_dotenv
import mysql.connector as mysql_con

load_dotenv()

from src.banco_service.idb_config import IDBConfig


class DbConfigMySQL(IDBConfig):

    def obter_conexao_string(self) -> Tuple[Tuple[Any, ...], Dict[str, Any]]:
        return ((), {
            'host': os.environ['SERVER'],
            'user': os.environ['USERSQL'],
            'password': os.environ['SENHA'],
            "database": os.environ['DATABASE']
        })

    def obter_driver(self) -> Callable[..., Any]:

        return mysql_con.connect


if __name__ == '__main__':
    db_mysql = DbConfigMySQL()
    print(db_mysql.obter_driver())


    def soma_(a, b):
        return a + b


    dic = {'a': 1, 'b': 2}

    print(soma_(**dic))
