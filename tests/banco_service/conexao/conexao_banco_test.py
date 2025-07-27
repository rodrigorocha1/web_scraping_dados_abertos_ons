import pytest
from unittest.mock import MagicMock
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import DbConfigMySQL

@pytest.fixture
def mock_driver(mocker) -> MagicMock:
    mock_connection = MagicMock()
    mock_driver = MagicMock(return_value=mock_connection)
    # Aqui você mocka o método obter_driver para retornar seu mock_driver
    mocker.patch('src.banco_service.conexao.db_confg_mysql.mysql_con.connect', mock_driver)
    return mock_connection

@pytest.mark.unit
def test_obter_driver():
    config = DbConfigMySQL()
    driver = config.obter_driver()
    assert callable(driver)

@pytest.mark.unit
def test_classmethod_mesma_instancia(mock_driver: MagicMock):
    # Define a configuração antes de conectar
    config = DbConfigMySQL()
    ConexaoBanco.set_config(config)

    # Conecta antes de obter conexão
    ConexaoBanco.conectar()
    conexao1 = ConexaoBanco.obter_conexao()
    conexao2 = ConexaoBanco.obter_conexao()

    assert conexao1 is conexao2

@pytest.mark.unit
def test_diferentes_instancia_mesma_conexao(mock_driver: MagicMock):
    config = DbConfigMySQL()
    ConexaoBanco.set_config(config)

    ConexaoBanco.conectar()
    conexao1 = ConexaoBanco.obter_conexao()
    conexao2 = ConexaoBanco.obter_conexao()
    assert conexao1 is conexao2
