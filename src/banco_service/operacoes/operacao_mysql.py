from mysql.connector.connection import MySQLConnection
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL
from src.banco_service.conexao.iconexao import IConexao
from src.banco_service.operacoes.i_operacao import IOperacao


class OperacaoMysql(IOperacao):

    def __init__(self, conexao: IConexao[MySQLConnection]):
        self.__conexao = conexao

    def checar_conexao(self) -> bool:
        return True

    def salvar_consulta(self):

        try:
            with self.__conexao as conn:
                cursor = conn.cursor()
                cursor.execute("SELECT 1")
                resultado = cursor.fetchall()
                print("Resultado:", resultado)
        except Exception as e:
            print(f"Erro ao executar consulta: {e}")


if __name__ == '__main__':
    c = OperacaoMysql(conexao=ConexaoBanco[MySQLConnection](config=DbConfigMySQL()))
    c.salvar_consulta()
