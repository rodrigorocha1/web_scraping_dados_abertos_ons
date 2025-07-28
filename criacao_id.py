import mysql.connector
import logging
from src.config.config import Config

# Configuração do logging
logging.basicConfig(
    filename="alter_table.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Configuração da conexão
config = {
    "host": Config.SERVER,
    "user": Config.USERSQL,
    "password": Config.PASSWORD,
    "database": Config.DATABASE
}

# Lista de tabelas
tables = [
    "BALANCO_ENERGIA_DESSEM_GERAL",
    "BALANCO_ENERGIA_SUBSISTEMA",
    "CAPACIDADE_INSTALADA_GERACAO",
    "CAPACIDADE_TRANSFORMACAO_REDE_BASICA",
    "CARGA_ENERGIA_DIARIA",
    "CARGA_ENERGIA_MENSAL",
    "CARGA_GLOBAL_RORAIMA",
    "CMO_SEMANAL",
    "CMO_SEMIHORARIO",
    "CONTORNOS_BACIAS_HIDROGRAFICAS",
    "CVU_USINAS_TERMICAS",
    "DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO",
    "DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA",
    "DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS",
    "DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS",
    "DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO",
    "DADOS_PVP_EOL_SOLA",
    "EAR_DIARIO_POR_BACIA",
    "EAR_DIARIO_POR_SUBSISTEMA",
    "EAR_DIARIO_REE",
    "EAR_DIARIO_RESEVATORIO",
    "ENA_DIARIO_POR_BACIA",
    "ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA",
    "ENA_DIARIO_POR_RESEVATORIO",
    "ENA_DIARIO_POR_SUBSISTEMA",
    "ENERGIA_VERTIDA_TURBINAVEL",
    "EQUIPAMENTOS_CONTROLE_REATIVOS_REDE_OPERACAO",
    "FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR",
    "GERACAO_COMERCIAL_PARA_EXPORTACAO_INTERNACIONAL",
    "GERACAO_TERMICA_MOTIVO_DESPACHO",
    "GERACAO_USINA_BASE_HORARIA",
    "GRANDEZAS_FLUVIOMETRICAS",
    "ICRB-CCAT",
    "ICRB-CIPER",
    "ICRB_DF",
    "IDFT_LT_TRANSF",
    "IDF_TRANS_CONV",
    "IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE",
    "IFT_ECR",
    "IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO",
    "INDICADORES_CONF_REDE_BASICA_ATLS",
    "INDI_CNFIA_REDE_BASICA_TRANS",
    "IND_CONF_RB_SM_SEVERIDADE",
    "IND_DESEMP_FUN_GER_UNID_GER_MENSAL",
    "INTERCAMBIOS_ENTRE_SUBSISTEMAS",
    "INT_SIN_OUT_P",
    "IQERB_DFD_MA",
    "IQERB_DFP",
    "IQE_DFD_EVENTOS",
    "MOUSINA",
    "OFERTAS_DE_PRECO_PARA_IMPORTACAO_OPI",
    "RCOUE",
    "RCU",
    "REDE_BASICA_ENS",
    "REL_GRUPO_USINA",
    "RESERVATORIOS",
    "RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS",
    "TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ",
    "TB_IND_DISP_FUN_GER_SIN_MENSAL",
    "USINAS_EOLICAS_CONSTRAINED_OFF",
    "USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF"
]

try:
    # Conexão com MySQL
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    for table in tables:
        try:
            # Verificar se a coluna "id_param" já existe
            cursor.execute(f"SHOW COLUMNS FROM `{table}` LIKE 'id_param';")
            result = cursor.fetchone()

            if result:
                msg = f"[SKIP] Tabela {table} já possui a coluna 'id_param'."
                print(msg)
                logging.info(msg)
            else:
                alter_sql = f"ALTER TABLE `{table}` ADD COLUMN id_param INT FIRST;"
                cursor.execute(alter_sql)
                conn.commit()
                msg = f"[OK] Coluna 'id_param' adicionada à tabela {table}."
                print(msg)
                logging.info(msg)

        except Exception as e:
            error_msg = f"[ERRO] Não foi possível alterar a tabela {table}: {e}"
            print(error_msg)
            logging.error(error_msg)

    cursor.close()
    conn.close()
    logging.info("Processo concluído.")
    print("Processo concluído.")

except Exception as e:
    error_msg = f"[FATAL] Erro na conexão com o banco: {e}"
    print(error_msg)
    logging.critical(error_msg)
