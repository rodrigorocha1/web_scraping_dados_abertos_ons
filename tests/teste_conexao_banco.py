import pytest
from unittest.mock import patch, MagicMock, Mock
import pyodbc
from src.banco_service.conexao_banco import ConexaoBanco
from src.banco_service.conexao_banco import DbConfigSQLServer


@pytest.fixture
def mock_db_config():
    """Mock da configuração do banco de dados"""
    mock = MagicMock()
    mock.obter_conexao_string.return_value = DbConfigSQLServer().obter_conexao_string()
    return mock


@patch('pyodbc.connect')
def teste_conexao_banco_singleton(mock_connect, mock_db_config):
    mock_connect.return_value = MagicMock()

    conexao1 = ConexaoBanco(mock_db_config).obter_conexao()
    conexao2 = ConexaoBanco(mock_db_config).obter_conexao()

    assert conexao1 is conexao2
    mock_connect.assert_called_once()


def test_falha_conexao_banco():
    with patch('pyodbc.connect', side_effect=pyodbc.Error('Falha ao conectar')):
        mensagem_erro = ConexaoBanco(DbConfigSQLServer())
        assert mensagem_erro == "Falha na conexão com o banco de dados: Falha ao conectar"


def test_conexao_sucesso():
    mock_conexao = Mock()
    print(f'Mock Conexão: {mock_conexao}')
    with patch('pyodbc.connect', return_value=mock_conexao):
        conexao_banco = ConexaoBanco(DbConfigSQLServer())
        print('a')
        print(conexao_banco.obter_conexao())
        assert conexao_banco.obter_conexao() == mock_conexao
