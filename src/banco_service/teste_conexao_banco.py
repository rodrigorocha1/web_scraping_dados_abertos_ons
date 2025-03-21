from src.banco_service.conexao_banco import ConexaoBanco

def teste_conexao():
    print(ConexaoBanco.conexao)
    assert ConexaoBanco.conexao is None
    ConexaoBanco.conectar_banco()
    print(ConexaoBanco.conexao)
    assert ConexaoBanco.conexao is not None