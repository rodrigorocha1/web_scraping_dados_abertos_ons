import os
from dotenv import load_dotenv

load_dotenv()


class Config:
    SERVER = os.environ['SERVER']
    PORTA = os.environ['PORTA']
    USERSQL = os.environ['USERSQL']
    PASSWORD =  os.environ['SENHA']
    DATABASE = os.environ['DATABASE']


