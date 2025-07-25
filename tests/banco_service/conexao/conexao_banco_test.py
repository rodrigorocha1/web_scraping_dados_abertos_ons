from typing import Any

import pytest
from unittest.mock import MagicMock
from src.banco_service.conexao.conexao_banco import ConexaoBanco
from src.banco_service.conexao.db_confg_mysql import IDBConfig, DbConfigMySQL


@pytest.fixture
def mock_driver(mocker: Any) -> MagicMock:
    mock_com = MagicMock()
    mock_driver = MagicMock(return_value=mock_com)
    mocker.patch('src.banco_service.conexao.db_confg_mysql.mysql_con.connect', mock_driver)
    return mock_com


@pytest.mark.unit
def test_obter_diver():
    config = DbConfigMySQL()
    driver = config.obter_driver()
    assert callable(driver)


@pytest.mark.unit
def test_classmethod_mesma_instancia(mock_driver: MagicMock) -> None:
    config: DbConfigMySQL = DbConfigMySQL()
    ConexaoBanco.conectar(config)
    conexao1: MagicMock = ConexaoBanco.obter_conexao()

    ConexaoBanco.conexao(config)
    conexao2: MagicMock = ConexaoBanco.obter_conexao()

    assert conexao1 is conexao2


@pytest.mark.unit
def teste_diferentes_instancia_mesma_conexao(mock_driver: MagicMock):
    config = DbConfigMySQL()
    ConexaoBanco.conectar(config=config)
    conexao1 = ConexaoBanco().obter_conexao()
    conexao2 = ConexaoBanco().obter_conexao()
    assert conexao1 is conexao2
