import os
from dotenv import load_dotenv

load_dotenv()


class Config:
    SERVER = os.environ['SERVER']
    PORTA = os.environ['PORTA']
    USERSQL = os.environ['USERSQL']
    PASSWORD = os.environ['SENHA']
    DATABASE = os.environ['DATABASE']

    SERVER_LOG = os.environ['SERVER_LOG']
    PORTA_LOG = os.environ['PORTA_LOG']
    USERSQL_LOG = os.environ['USERSQL_LOG']
    PASSWORD_LOG = os.environ['PASSWORD_LOG']
    DATABASE_LOG = os.environ['DATABASE_LOG']
