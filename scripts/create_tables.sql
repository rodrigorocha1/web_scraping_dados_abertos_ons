-- Script para a tabela BALANCO_ENERGIA_DESSEM_DETALHADO
CREATE TABLE `BALANCO_ENERGIA_DESSEM_DETALHADO` (
  `id_param` int DEFAULT NULL,
  `din_programacaodia` datetime NOT NULL,
  `num_patamar` smallint NOT NULL,
  `cod_subsistema` varchar(2) NOT NULL,
  `val_demanda` float NOT NULL,
  `val_geracao_hidraulica` float NOT NULL,
  `val_ger_pch` float NOT NULL,
  `val_geracao_termica` float NOT NULL,
  `val_ger_pct` float NOT NULL,
  `val_ger_eolica` float NOT NULL,
  `val_ger_fotovoltaica` float NOT NULL,
  `val_ger_mmgd` float NOT NULL,
  `val_cons_elevatoria` float NOT NULL,
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_1` CHECK ((`num_patamar` > 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_10` CHECK ((`val_cons_elevatoria` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_2` CHECK ((`val_demanda` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_3` CHECK ((`val_geracao_hidraulica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_4` CHECK ((`val_ger_pch` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_5` CHECK ((`val_geracao_termica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_6` CHECK ((`val_ger_pct` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_7` CHECK ((`val_ger_eolica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_8` CHECK ((`val_ger_fotovoltaica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_DETALHADO_chk_9` CHECK ((`val_ger_mmgd` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela BALANCO_ENERGIA_DESSEM_GERAL
CREATE TABLE `BALANCO_ENERGIA_DESSEM_GERAL` (
  `id_param` int DEFAULT NULL,
  `din_programacaodia` datetime NOT NULL,
  `num_patamar` smallint NOT NULL,
  `cod_subsistema` varchar(2) NOT NULL,
  `val_demanda` float NOT NULL,
  `val_geracao_hidraulica` float NOT NULL,
  `val_geracao_termica` float NOT NULL,
  `val_cons_elevatoria` float NOT NULL,
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_GERAL_chk_1` CHECK ((`num_patamar` > 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_GERAL_chk_2` CHECK ((`val_demanda` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_GERAL_chk_3` CHECK ((`val_geracao_hidraulica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_GERAL_chk_4` CHECK ((`val_geracao_termica` >= 0)),
  CONSTRAINT `BALANCO_ENERGIA_DESSEM_GERAL_chk_5` CHECK ((`val_cons_elevatoria` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela BALANCO_ENERGIA_SUBSISTEMA
CREATE TABLE `BALANCO_ENERGIA_SUBSISTEMA` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nome_subsistema` varchar(20) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_gerhidraulica` float DEFAULT NULL,
  `val_gertermica` float DEFAULT NULL,
  `val_gereolica` float DEFAULT NULL,
  `val_gersolar` float DEFAULT NULL,
  `val_carga` float NOT NULL,
  `val_intercambio` float DEFAULT NULL,
  CONSTRAINT `BALANCO_ENERGIA_SUBSISTEMA_chk_1` CHECK (((`val_gerhidraulica` >= 0) or (`val_gerhidraulica` is null))),
  CONSTRAINT `BALANCO_ENERGIA_SUBSISTEMA_chk_2` CHECK (((`val_gertermica` >= 0) or (`val_gertermica` is null))),
  CONSTRAINT `BALANCO_ENERGIA_SUBSISTEMA_chk_3` CHECK (((`val_gereolica` >= 0) or (`val_gereolica` is null))),
  CONSTRAINT `BALANCO_ENERGIA_SUBSISTEMA_chk_4` CHECK (((`val_gersolar` >= 0) or (`val_gersolar` is null))),
  CONSTRAINT `BALANCO_ENERGIA_SUBSISTEMA_chk_5` CHECK ((`val_carga` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CAPACIDADE_INSTALADA_GERACAO
CREATE TABLE `CAPACIDADE_INSTALADA_GERACAO` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `nom_modalidadeoperacao` varchar(20) NOT NULL,
  `nom_agenteproprietario` varchar(30) NOT NULL,
  `nom_agenteoperador` varchar(30) NOT NULL,
  `nom_tipousina` varchar(30) NOT NULL,
  `nom_usina` varchar(60) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `nom_unidadegeradora` varchar(72) NOT NULL,
  `cod_equipamento` varchar(20) NOT NULL,
  `num_unidadegeradora` varchar(6) NOT NULL,
  `nom_combustivel` varchar(30) NOT NULL,
  `dat_entradateste` datetime DEFAULT NULL,
  `dat_entradaoperacao` datetime NOT NULL,
  `dat_desativacao` datetime DEFAULT NULL,
  `val_potenciaefetiva` float NOT NULL,
  CONSTRAINT `CAPACIDADE_INSTALADA_GERACAO_chk_1` CHECK ((`nom_tipousina` in (_utf8mb4'EOLIELÉTRICA',_utf8mb4'FOTOVOLTAICA',_utf8mb4'HIDROELÉTRICA',_utf8mb4'NUCLEAR',_utf8mb4'TÉRMICA'))),
  CONSTRAINT `CAPACIDADE_INSTALADA_GERACAO_chk_2` CHECK ((`val_potenciaefetiva` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CAPACIDADE_TRANSFORMACAO_REDE_BASICA
CREATE TABLE `CAPACIDADE_TRANSFORMACAO_REDE_BASICA` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `nom_tipotransformador` varchar(45) NOT NULL,
  `nom_agenteproprietario` varchar(30) NOT NULL,
  `nom_subestacao` varchar(20) NOT NULL,
  `nom_transformador` varchar(72) NOT NULL,
  `cod_equipamento` varchar(20) NOT NULL,
  `dat_entradaoperacao` date NOT NULL,
  `dat_desativacao` date DEFAULT NULL,
  `val_tensaoprimario_kv` float NOT NULL,
  `val_tensaosecundario_kv` float NOT NULL,
  `val_tensaoterciario_kv` float DEFAULT NULL,
  `val_potencianominal_mva` float NOT NULL,
  `nom_tipoderede` varchar(15) NOT NULL,
  `num_barra_primario` int NOT NULL,
  `num_barra_secundario` int NOT NULL,
  CONSTRAINT `CAPACIDADE_TRANSFORMACAO_REDE_BASICA_chk_1` CHECK ((`val_tensaoprimario_kv` >= 0)),
  CONSTRAINT `CAPACIDADE_TRANSFORMACAO_REDE_BASICA_chk_2` CHECK ((`val_tensaosecundario_kv` >= 0)),
  CONSTRAINT `CAPACIDADE_TRANSFORMACAO_REDE_BASICA_chk_3` CHECK ((`val_tensaoterciario_kv` >= 0)),
  CONSTRAINT `CAPACIDADE_TRANSFORMACAO_REDE_BASICA_chk_4` CHECK ((`val_potencianominal_mva` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CARGA_ENERGIA_DIARIA
CREATE TABLE `CARGA_ENERGIA_DIARIA` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_cargaenergiamwmed` float NOT NULL,
  CONSTRAINT `CARGA_ENERGIA_DIARIA_chk_1` CHECK ((`val_cargaenergiamwmed` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CARGA_ENERGIA_MENSAL
CREATE TABLE `CARGA_ENERGIA_MENSAL` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_cargaenergiamwmed` float NOT NULL,
  CONSTRAINT `CARGA_ENERGIA_MENSAL_chk_1` CHECK ((`val_cargaenergiamwmed` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CARGA_GLOBAL_RORAIMA
CREATE TABLE `CARGA_GLOBAL_RORAIMA` (
  `id_param` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `val_carga_mw` float(10,3) NOT NULL,
  CONSTRAINT `CARGA_GLOBAL_RORAIMA_chk_1` CHECK ((`val_carga_mw` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CMO_SEMANAL
CREATE TABLE `CMO_SEMANAL` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_cmomediasemanal` float NOT NULL,
  `val_cmoleve` float NOT NULL,
  `val_cmomedia` float NOT NULL,
  `val_cmopesada` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CMO_SEMIHORARIO
CREATE TABLE `CMO_SEMIHORARIO` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_cmo` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CONTORNOS_BACIAS_HIDROGRAFICAS  -- TABELA DELETADA NÃO DEVE SER CRIADA
CREATE TABLE `CONTORNOS_BACIAS_HIDROGRAFICAS` (
  `id_param` int DEFAULT NULL,
  `dat_iniciosemana` date NOT NULL,
  `dat_fimsemana` date NOT NULL,
  `ano_referencia` int NOT NULL,
  `mes_referencia` int NOT NULL,
  `num_revisao` int NOT NULL,
  `nom_semanaoperativa` varchar(150) NOT NULL,
  `cod_modelos` int NOT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `nom_usina` varchar(150) NOT NULL,
  `val_cvu` decimal(18,2) NOT NULL,
  CONSTRAINT `CONTORNOS_BACIAS_HIDROGRAFICAS_chk_1` CHECK ((`ano_referencia` > 0)),
  CONSTRAINT `CONTORNOS_BACIAS_HIDROGRAFICAS_chk_2` CHECK (((`mes_referencia` >= 1) and (`mes_referencia` <= 12))),
  CONSTRAINT `CONTORNOS_BACIAS_HIDROGRAFICAS_chk_3` CHECK ((`num_revisao` >= 0)),
  CONSTRAINT `CONTORNOS_BACIAS_HIDROGRAFICAS_chk_4` CHECK ((`cod_modelos` > 0)),
  CONSTRAINT `CONTORNOS_BACIAS_HIDROGRAFICAS_chk_5` CHECK ((`val_cvu` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela CURVA_CARGA_HORARIA

CREATE TABLE CURVA_CARGA_HORARIA (
    id_param int DEFAULT NULL,
    id_subsistema VARCHAR(3),
    nom_subsistema VARCHAR(20),
    din_instante DATETIME,
    val_cargaenergiahomwmed FLOAT

)

-- Script para a tabela CVU_USINAS_TERMICAS
CREATE TABLE `CVU_USINAS_TERMICAS` (
  `id_param` int DEFAULT NULL,
  `dat_iniciosemana` date NOT NULL,
  `dat_fimsemana` date NOT NULL,
  `ano_referencia` int NOT NULL,
  `mes_referencia` int NOT NULL,
  `num_revisao` int NOT NULL,
  `nom_semanaoperativa` varchar(150) NOT NULL,
  `cod_modelos` int NOT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `nom_usina` varchar(150) NOT NULL,
  `val_cvu` decimal(18,2) NOT NULL,
  CONSTRAINT `chk_ano_referencia_not_negative` CHECK ((`ano_referencia` >= 0)),
  CONSTRAINT `chk_ano_referencia_not_zero` CHECK ((`ano_referencia` <> 0)),
  CONSTRAINT `chk_cod_modelos_not_negative` CHECK ((`cod_modelos` >= 0)),
  CONSTRAINT `chk_cod_modelos_not_zero` CHECK ((`cod_modelos` <> 0)),
  CONSTRAINT `chk_mes_referencia_not_negative` CHECK ((`mes_referencia` >= 0)),
  CONSTRAINT `chk_mes_referencia_not_zero` CHECK ((`mes_referencia` <> 0)),
  CONSTRAINT `chk_num_revisao_not_negative` CHECK ((`num_revisao` >= 0)),
  CONSTRAINT `chk_val_cvu_not_negative` CHECK ((`val_cvu` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO
CREATE TABLE `DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO` (
  `id_param` int DEFAULT NULL,
  `din_programacaodia` datetime NOT NULL,
  `num_patamar` int NOT NULL,
  `nom_elementofluxocontrolado` varchar(500) NOT NULL,
  `dsc_elementofluxocontrolado` varchar(500) NOT NULL,
  `tip_terminal` int NOT NULL,
  `cod_submercado` varchar(3) NOT NULL,
  `val_carga` float NOT NULL,
  CONSTRAINT `DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO_chk_1` CHECK ((`num_patamar` > 0)),
  CONSTRAINT `DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO_chk_2` CHECK ((`tip_terminal` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA
CREATE TABLE `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA` (
  `id_param` int DEFAULT NULL,
  `din_programacaodia` datetime NOT NULL,
  `num_patamar` int NOT NULL,
  `cod_exibicaousina` varchar(100) NOT NULL,
  `nom_usina` varchar(250) NOT NULL,
  `tip_geracao` varchar(50) NOT NULL,
  `nom_modalidadeoperacao` varchar(20) DEFAULT NULL,
  `id_subsistema` varchar(3) DEFAULT NULL,
  `nom_subsistema` varchar(60) DEFAULT NULL,
  `id_estado` varchar(2) DEFAULT NULL,
  `nom_estado` varchar(30) DEFAULT NULL,
  `val_geracaoprogramada` float NOT NULL,
  `val_disponibilidade` float DEFAULT NULL,
  `val_ordemmerito` float DEFAULT NULL,
  `val_inflexibilidade` float DEFAULT NULL,
  `val_uc` float DEFAULT NULL,
  `val_razaoeletrica` float DEFAULT NULL,
  `val_geracaoenergetica` float DEFAULT NULL,
  `val_gesubgsub` float DEFAULT NULL,
  `val_exportacao` float DEFAULT NULL,
  `val_reposicaoexportacao` float DEFAULT NULL,
  `val_faltacombustivel` float DEFAULT NULL,
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_1` CHECK ((`num_patamar` <> 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_10` CHECK ((`val_exportacao` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_11` CHECK ((`val_reposicaoexportacao` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_12` CHECK ((`val_faltacombustivel` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_2` CHECK ((`num_patamar` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_3` CHECK ((`val_disponibilidade` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_4` CHECK ((`val_ordemmerito` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_5` CHECK ((`val_inflexibilidade` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_6` CHECK ((`val_uc` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_7` CHECK ((`val_razaoeletrica` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_8` CHECK ((`val_geracaoenergetica` >= 0)),
  CONSTRAINT `DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA_chk_9` CHECK ((`val_gesubgsub` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS
CREATE TABLE `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS` (
  `id_param` int DEFAULT NULL,
  `dat_iniciosemana` date NOT NULL,
  `dat_fimsemana` date NOT NULL,
  `ano_referencia` int NOT NULL,
  `mes_referencia` int NOT NULL,
  `num_revisao` int NOT NULL,
  `nom_semanaoperativa` varchar(150) NOT NULL,
  `cod_modelos` int NOT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `nom_usina` varchar(150) NOT NULL,
  `val_cvu` decimal(18,2) NOT NULL,
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS_chk_1` CHECK ((`ano_referencia` > 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS_chk_2` CHECK (((`mes_referencia` >= 1) and (`mes_referencia` <= 12))),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS_chk_3` CHECK ((`num_revisao` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS_chk_4` CHECK ((`cod_modelos` > 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS_chk_5` CHECK ((`val_cvu` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS
CREATE TABLE `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(40) NOT NULL,
  `tip_reservatorio` varchar(40) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `id_reservatorio` varchar(6) NOT NULL,
  `nom_reservatorio` varchar(20) NOT NULL,
  `cod_usina` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `val_nivelmontante` float NOT NULL,
  `val_niveljusante` float DEFAULT NULL,
  `val_volumeutil` float DEFAULT NULL,
  `val_vazaoafluente` float DEFAULT NULL,
  `val_vazaodefluente` float DEFAULT NULL,
  `val_vazaoturbinada` float DEFAULT NULL,
  `val_vazaovertida` float DEFAULT NULL,
  `val_vazaooutrasestruturas` float DEFAULT NULL,
  `val_vazaotransferida` float DEFAULT NULL,
  `val_vazaovertidanaoturbinavel` float DEFAULT NULL,
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_1` CHECK ((`cod_usina` > 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_2` CHECK ((`val_nivelmontante` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_3` CHECK ((`val_niveljusante` > 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_4` CHECK ((`val_vazaodefluente` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_5` CHECK ((`val_vazaoturbinada` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_6` CHECK ((`val_vazaovertida` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_7` CHECK ((`val_vazaooutrasestruturas` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS_chk_8` CHECK ((`val_vazaovertidanaoturbinavel` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO
CREATE TABLE `DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `tip_reservatorio` varchar(40) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `nom_ree` varchar(20) DEFAULT NULL,
  `id_reservatorio` varchar(6) NOT NULL,
  `nom_reservatorio` varchar(20) NOT NULL,
  `num_ordemcs` int DEFAULT NULL,
  `cod_usina` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `val_volumeespera` float NOT NULL,
  CONSTRAINT `DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO_chk_1` CHECK ((`num_ordemcs` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO_chk_2` CHECK ((`cod_usina` >= 0)),
  CONSTRAINT `DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO_chk_3` CHECK ((`val_volumeespera` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela DADOS_PVP_EOL_SOLA
CREATE TABLE `DADOS_PVP_EOL_SOLA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `dat_programacao` datetime NOT NULL,
  `num_patamar` int NOT NULL,
  `cod_usinapdp` varchar(100) NOT NULL,
  `nom_usinapdp` varchar(250) NOT NULL,
  `val_previsao` float NOT NULL,
  `val_programado` float NOT NULL,
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_1` CHECK ((`dat_programacao` is not null)),
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_2` CHECK (((`num_patamar` is not null) and (`num_patamar` >= 0))),
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_3` CHECK ((`cod_usinapdp` is not null)),
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_4` CHECK ((`nom_usinapdp` is not null)),
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_5` CHECK (((`val_previsao` is not null) and (`val_previsao` >= 0))),
  CONSTRAINT `DADOS_PVP_EOL_SOLA_chk_6` CHECK (((`val_programado` is not null) and (`val_programado` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela EAR_DIARIO_POR_BACIA
CREATE TABLE `EAR_DIARIO_POR_BACIA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_curto` varchar(15) NOT NULL,
  `ear_data` date NOT NULL,
  `ear_max_bacia` float NOT NULL,
  `ear_verif_bacia_mwmes` float NOT NULL,
  `ear_verif_bacia_percentual` float NOT NULL,
  CONSTRAINT `EAR_DIARIO_POR_BACIA_chk_1` CHECK ((`ear_max_bacia` >= 0)),
  CONSTRAINT `EAR_DIARIO_POR_BACIA_chk_2` CHECK ((`ear_verif_bacia_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_POR_BACIA_chk_3` CHECK ((`ear_verif_bacia_percentual` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela EAR_DIARIO_POR_SUBSISTEMA
CREATE TABLE `EAR_DIARIO_POR_SUBSISTEMA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `ear_data` date NOT NULL,
  `ear_max_subsistema` float NOT NULL,
  `ear_verif_subsistema_mwmes` float NOT NULL,
  `ear_verif_subsistema_percentual` float NOT NULL,
  CONSTRAINT `EAR_DIARIO_POR_SUBSISTEMA_chk_1` CHECK ((`ear_max_subsistema` > 0)),
  CONSTRAINT `EAR_DIARIO_POR_SUBSISTEMA_chk_2` CHECK ((`ear_verif_subsistema_mwmes` > 0)),
  CONSTRAINT `EAR_DIARIO_POR_SUBSISTEMA_chk_3` CHECK ((`ear_verif_subsistema_percentual` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela EAR_DIARIO_REE
CREATE TABLE `EAR_DIARIO_REE` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_ree` varchar(20) NOT NULL,
  `ear_data` datetime NOT NULL,
  `ear_max_ree` float NOT NULL,
  `ear_verif_ree_mwmes` float NOT NULL,
  `ear_verif_ree_percentual` float NOT NULL,
  CONSTRAINT `EAR_DIARIO_REE_chk_1` CHECK ((`ear_max_ree` > 0)),
  CONSTRAINT `EAR_DIARIO_REE_chk_2` CHECK ((`ear_verif_ree_mwmes` <> 0)),
  CONSTRAINT `EAR_DIARIO_REE_chk_3` CHECK ((`ear_verif_ree_percentual` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela EAR_DIARIO_RESEVATORIO
CREATE TABLE `EAR_DIARIO_RESEVATORIO` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_reservatorio` varchar(20) NOT NULL,
  `cod_resplanejamento` int NOT NULL,
  `tip_reservatorio` varchar(40) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `nom_ree` varchar(20) DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `id_subsistema_jusante` varchar(2) NOT NULL,
  `nom_subsistema_jusante` varchar(20) NOT NULL,
  `ear_data` datetime NOT NULL,
  `ear_reservatorio_subsistema_proprio_mwmes` float NOT NULL,
  `ear_reservatorio_subsistema_jusante_mwmes` float NOT NULL,
  `earmax_reservatorio_subsistema_proprio_mwmes` float NOT NULL,
  `earmax_reservatorio_subsistema_jusante_mwmes` float NOT NULL,
  `ear_reservatorio_percentual` float NOT NULL,
  `ear_total_mwmes` float NOT NULL,
  `ear_maxima_total_mwmes` float NOT NULL,
  `val_contribearbacia` float NOT NULL,
  `val_contribearmaxbacia` float NOT NULL,
  `val_contribearsubsistema` float NOT NULL,
  `val_contribearmaxsubsistema` float NOT NULL,
  `val_contribearsubsistemajusante` float NOT NULL,
  `val_contribearmaxsubsistemajusante` float NOT NULL,
  `val_contribearsin` float NOT NULL,
  `val_contribearmaxsin` float NOT NULL,
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_1` CHECK ((`cod_resplanejamento` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_10` CHECK ((`val_contribearmaxbacia` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_11` CHECK ((`val_contribearsubsistema` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_12` CHECK ((`val_contribearmaxsubsistema` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_13` CHECK ((`val_contribearsubsistemajusante` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_14` CHECK ((`val_contribearmaxsubsistemajusante` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_15` CHECK ((`val_contribearsin` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_16` CHECK ((`val_contribearmaxsin` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_2` CHECK ((`ear_reservatorio_subsistema_proprio_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_3` CHECK ((`ear_reservatorio_subsistema_jusante_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_4` CHECK ((`earmax_reservatorio_subsistema_proprio_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_5` CHECK ((`earmax_reservatorio_subsistema_jusante_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_6` CHECK ((`ear_reservatorio_percentual` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_7` CHECK ((`ear_total_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_8` CHECK ((`ear_maxima_total_mwmes` >= 0)),
  CONSTRAINT `EAR_DIARIO_RESEVATORIO_chk_9` CHECK ((`val_contribearbacia` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ENA_DIARIO_POR_BACIA
CREATE TABLE `ENA_DIARIO_POR_BACIA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `ena_data` date NOT NULL,
  `ena_bruta_bacia_mwmed` float NOT NULL,
  `ena_bruta_bacia_percentualmlt` float NOT NULL,
  `ena_armazenavel_bacia_mwmed` float NOT NULL,
  `ena_armazenavel_bacia_percentualmlt` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA
CREATE TABLE `ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_ree` varchar(20) NOT NULL,
  `ena_data` date NOT NULL,
  `ena_bruta_ree_mwmed` float NOT NULL,
  `ena_bruta_ree_percentualmlt` float NOT NULL,
  `ena_armazenavel_ree_mwmed` float NOT NULL,
  `ena_armazenavel_ree_percentualmlt` float NOT NULL,
  CONSTRAINT `ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA_chk_1` CHECK ((`ena_bruta_ree_mwmed` > 0)),
  CONSTRAINT `ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA_chk_2` CHECK ((`ena_bruta_ree_percentualmlt` > 0)),
  CONSTRAINT `ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA_chk_3` CHECK ((`ena_armazenavel_ree_mwmed` <> 0)),
  CONSTRAINT `ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA_chk_4` CHECK ((`ena_armazenavel_ree_percentualmlt` <> 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ENA_DIARIO_POR_RESEVATORIO
CREATE TABLE `ENA_DIARIO_POR_RESEVATORIO` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nome_reservatorio` varchar(20) NOT NULL,
  `cod_replanejamento` int NOT NULL,
  `tip_reservatorio` varchar(40) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `nom_ree` varchar(20) DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `ena_data` date NOT NULL,
  `ena_bruta_res_mwmed` float NOT NULL,
  `ena_bruta_res_percentualmlt` float NOT NULL,
  `ena_armazenavel_res_mwmed` float NOT NULL,
  `ena_armazenavel_res_percentualmlt` float NOT NULL,
  `ena_queda_bruta` float NOT NULL,
  `mlt_ena` float NOT NULL,
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_1` CHECK ((`ena_bruta_res_mwmed` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_2` CHECK ((`ena_bruta_res_percentualmlt` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_3` CHECK ((`ena_armazenavel_res_mwmed` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_4` CHECK ((`ena_armazenavel_res_percentualmlt` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_5` CHECK ((`ena_queda_bruta` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_RESEVATORIO_chk_6` CHECK ((`mlt_ena` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ENA_DIARIO_POR_SUBSISTEMA
CREATE TABLE `ENA_DIARIO_POR_SUBSISTEMA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `ena_data` date NOT NULL,
  `ena_bruta_regiao_mwmed` float NOT NULL,
  `ena_bruta_regiao_percentualmlt` float NOT NULL,
  `ena_armazenavel_regiao_mwmed` float NOT NULL,
  `ena_armazenavel_regiao_percentualmlt` float NOT NULL,
  CONSTRAINT `ENA_DIARIO_POR_SUBSISTEMA_chk_1` CHECK ((`ena_bruta_regiao_mwmed` <> 0)),
  CONSTRAINT `ENA_DIARIO_POR_SUBSISTEMA_chk_2` CHECK ((`ena_bruta_regiao_mwmed` >= 0)),
  CONSTRAINT `ENA_DIARIO_POR_SUBSISTEMA_chk_3` CHECK ((`ena_bruta_regiao_percentualmlt` <> 0)),
  CONSTRAINT `ENA_DIARIO_POR_SUBSISTEMA_chk_4` CHECK ((`ena_armazenavel_regiao_mwmed` <> 0)),
  CONSTRAINT `ENA_DIARIO_POR_SUBSISTEMA_chk_5` CHECK ((`ena_armazenavel_regiao_percentualmlt` <> 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ENERGIA_VERTIDA_TURBINAVEL
CREATE TABLE `ENERGIA_VERTIDA_TURBINAVEL` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(40) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `nom_rio` varchar(15) NOT NULL,
  `nom_agente` varchar(30) NOT NULL,
  `nom_reservatorio` varchar(20) NOT NULL,
  `cod_usina` int NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_geracao` float NOT NULL,
  `val_disponibilidade` float NOT NULL,
  `val_vazaoturbinada` float NOT NULL,
  `val_vazaovertida` float NOT NULL,
  `val_vazaovertidanoturbinavel` float NOT NULL,
  `val_produtividade` float NOT NULL,
  `val_folgadeGeracao` float NOT NULL,
  `val_energiavertida` float NOT NULL,
  `val_vazaovertidaturbinavel` float NOT NULL,
  `val_energiavertidaturbinavel` float NOT NULL,
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_1` CHECK ((`val_geracao` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_10` CHECK ((`val_energiavertidaturbinavel` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_2` CHECK ((`val_disponibilidade` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_3` CHECK ((`val_vazaoturbinada` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_4` CHECK ((`val_vazaovertida` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_5` CHECK ((`val_vazaovertidanoturbinavel` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_6` CHECK ((`val_produtividade` > 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_7` CHECK ((`val_folgadeGeracao` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_8` CHECK ((`val_energiavertida` >= 0)),
  CONSTRAINT `ENERGIA_VERTIDA_TURBINAVEL_chk_9` CHECK ((`val_vazaovertidaturbinavel` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela EQUIPAMENTOS_CONTROLE_REATIVOS_REDE_OPERACAO
CREATE TABLE `EQUIPAMENTOS_CONTROLE_REATIVOS_REDE_OPERACAO` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `nom_subestacao` varchar(20) NOT NULL,
  `nom_agente_proprietario` varchar(30) NOT NULL,
  `nom_tipoderede` varchar(15) NOT NULL,
  `nom_tipoequipamento` varchar(45) NOT NULL,
  `nom_equipamento` varchar(72) NOT NULL,
  `val_potreativanominal_mvar` float DEFAULT NULL,
  `val_limiteinferior_mvar` float DEFAULT NULL,
  `val_limitesuperior_mvar` float DEFAULT NULL,
  `dat_entradaoperacao` datetime NOT NULL,
  `dat_desativacao` datetime DEFAULT NULL,
  `cod_equipamento` varchar(20) NOT NULL,
  CONSTRAINT `EQUIPAMENTOS_CONTROLE_REATIVOS_REDE_OPERACAO_chk_1` CHECK (((`val_limitesuperior_mvar` <> 0) and (`val_limitesuperior_mvar` > 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR
CREATE TABLE `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `cod_pontoconexao` varchar(11) DEFAULT NULL,
  `nom_pontoconexao` varchar(45) DEFAULT NULL,
  `nom_localizacao` varchar(20) DEFAULT NULL,
  `val_latitudesecoletora` float DEFAULT NULL,
  `val_longitudesecoletora` float DEFAULT NULL,
  `val_latitudepontoconexao` float DEFAULT NULL,
  `val_longitudepontoconexao` float DEFAULT NULL,
  `nom_modalidadeoperacao` varchar(20) NOT NULL,
  `nom_tipousina` varchar(30) NOT NULL,
  `nom_usina_conjunto` varchar(60) NOT NULL,
  `din_instante` datetime NOT NULL,
  `id_ons` varchar(6) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `val_geracaoprogramada` float NOT NULL,
  `val_geracaoverificada` float NOT NULL,
  `val_capacidadeinstalada` float NOT NULL,
  `val_fatorcapacidade` float NOT NULL,
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_1` CHECK ((`val_latitudesecoletora` <> 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_2` CHECK ((`val_longitudesecoletora` <> 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_3` CHECK ((`val_latitudepontoconexao` <> 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_4` CHECK ((`val_longitudepontoconexao` <> 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_5` CHECK ((`val_geracaoprogramada` >= 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_6` CHECK ((`val_geracaoverificada` >= 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_7` CHECK ((`val_capacidadeinstalada` >= 0)),
  CONSTRAINT `FATOR_CAPACIDADE_GERACAO_EOLICA_SOLAR_chk_8` CHECK ((`val_fatorcapacidade` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela GERACAO_COMERCIAL_PARA_EXPORTACAO_INTERNACIONAL
CREATE TABLE `GERACAO_COMERCIAL_PARA_EXPORTACAO_INTERNACIONAL` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_conversora` varchar(20) DEFAULT NULL,
  `din_instante` datetime DEFAULT NULL,
  `val_modalidadecontratual` float DEFAULT NULL,
  `val_modalidadeemergencial` float DEFAULT NULL,
  `val_modalidadeoportunidade` float DEFAULT NULL,
  `val_modalidadeteste` float DEFAULT NULL,
  `val_modalidadeexcepcional` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela GERACAO_TERMICA_MOTIVO_DESPACHO
CREATE TABLE `GERACAO_TERMICA_MOTIVO_DESPACHO` (
  `id_param` datetime NOT NULL,
  `din_instante` datetime NOT NULL,
  `nom_tipopatamar` varchar(8) NOT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `nom_usina` varchar(60) NOT NULL,
  `cod_usinaplanejamento` int NOT NULL,
  `ceg` varchar(30) DEFAULT NULL,
  `val_proggeracao` float NOT NULL,
  `val_progordemmerito` float NOT NULL,
  `val_progordemdemeritoref` float NOT NULL,
  `val_progordemdemeritoacimadainflex` float DEFAULT NULL,
  `val_proginflexibilidade` float NOT NULL,
  `val_proginflexembutmerito` float DEFAULT NULL,
  `val_proginflexpura` float DEFAULT NULL,
  `val_prograzaoeletrica` float NOT NULL,
  `val_proggarantiaenergetica` float NOT NULL,
  `val_proggfom` float NOT NULL,
  `val_progreposicaoperdas` float NOT NULL,
  `val_progexportacao` float NOT NULL,
  `val_progreservapotencia` float DEFAULT NULL,
  `val_proggsub` float NOT NULL,
  `val_progunitcommitment` float DEFAULT NULL,
  `val_progconstrainedoff` float DEFAULT NULL,
  `val_proginflexibilidadedessem` float DEFAULT NULL,
  `val_verifgeracao` float NOT NULL,
  `val_verifordemmerito` float NOT NULL,
  `val_verifordemdemeritoacimadainflex` float DEFAULT NULL,
  `val_verifinflexibilidade` float NOT NULL,
  `val_verifinflexembutmerito` float DEFAULT NULL,
  `val_verifinflexpura` float DEFAULT NULL,
  `val_verifrazaoeletrica` float NOT NULL,
  `val_verifgarantiaenergetica` float NOT NULL,
  `val_verifgfom` float NOT NULL,
  `val_verifreposicaoperdas` float NOT NULL,
  `val_verifexportacao` float NOT NULL,
  `val_fdexp` float NOT NULL,
  `val_verifreservapotencia` float DEFAULT NULL,
  `val_atendsatisfatoriorpo` int DEFAULT NULL,
  `val_verifgsub` float NOT NULL,
  `val_verifunitcommitment` float DEFAULT NULL,
  `val_verifconstrainedoff` float NOT NULL,
  `tip_restricaoeletrica` int DEFAULT NULL,
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_1` CHECK ((`din_instante` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_10` CHECK ((`val_prograzaoeletrica` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_11` CHECK ((`val_proggarantiaenergetica` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_12` CHECK ((`val_proggfom` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_13` CHECK ((`val_progreposicaoperdas` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_14` CHECK ((`val_progexportacao` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_15` CHECK ((`val_progreservapotencia` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_16` CHECK ((`val_proggsub` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_17` CHECK ((`val_progunitcommitment` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_18` CHECK ((`val_progconstrainedoff` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_19` CHECK ((`val_proginflexibilidadedessem` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_2` CHECK ((`cod_usinaplanejamento` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_20` CHECK ((`val_verifgeracao` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_21` CHECK ((`val_verifordemmerito` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_22` CHECK ((`val_verifordemdemeritoacimadainflex` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_23` CHECK ((`val_verifinflexibilidade` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_24` CHECK ((`val_verifinflexembutmerito` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_25` CHECK ((`val_verifinflexpura` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_26` CHECK ((`val_verifrazaoeletrica` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_27` CHECK ((`val_verifgarantiaenergetica` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_28` CHECK ((`val_verifgfom` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_29` CHECK ((`val_verifreposicaoperdas` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_3` CHECK ((`val_proggeracao` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_30` CHECK ((`val_verifexportacao` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_31` CHECK ((`val_fdexp` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_32` CHECK ((`val_verifreservapotencia` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_33` CHECK ((`val_atendsatisfatoriorpo` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_34` CHECK ((`val_verifgsub` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_35` CHECK ((`val_verifunitcommitment` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_36` CHECK ((`val_verifconstrainedoff` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_37` CHECK ((`tip_restricaoeletrica` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_4` CHECK ((`val_progordemmerito` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_5` CHECK ((`val_progordemdemeritoref` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_6` CHECK ((`val_progordemdemeritoacimadainflex` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_7` CHECK ((`val_proginflexibilidade` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_8` CHECK ((`val_proginflexembutmerito` >= 0)),
  CONSTRAINT `GERACAO_TERMICA_MOTIVO_DESPACHO_chk_9` CHECK ((`val_proginflexpura` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela GERACAO_USINA_BASE_HORARIA
CREATE TABLE `GERACAO_USINA_BASE_HORARIA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `cod_modalidadeoperacao` varchar(20) DEFAULT NULL,
  `nom_tipousina` varchar(30) NOT NULL,
  `nom_tipocombustivel` varchar(50) NOT NULL,
  `nom_usina` varchar(60) NOT NULL,
  `id_ons` varchar(32) NOT NULL,
  `ceg` varchar(30) DEFAULT NULL,
  `val_geracao` float DEFAULT NULL,
  CONSTRAINT `check_val_geracao_non_negative` CHECK ((`val_geracao` >= 0)),
  CONSTRAINT `check_val_geracao_zero_allowed` CHECK ((`val_geracao` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela GRANDEZAS_FLUVIOMETRICAS
CREATE TABLE `GRANDEZAS_FLUVIOMETRICAS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_postofluviometrico` varchar(8) NOT NULL COMMENT 'Identificador do Posto Fluviométrico conforme cadastro da Agência Nacional das Águas',
  `nome_postofluviometrico` varchar(80) NOT NULL COMMENT 'Nome do Posto Fluviométrico',
  `val_latitude` float DEFAULT NULL COMMENT 'Latitude da localização do Posto Fluviométrico',
  `val_longitude` float DEFAULT NULL COMMENT 'Longitude da localização do Posto Fluviométrico',
  `nom_rio` varchar(60) DEFAULT NULL COMMENT 'Nome do rio onde está localizado Posto Fluviométrico',
  `nom_bacia` varchar(60) DEFAULT NULL COMMENT 'Nome Curto da Bacia Hidro Energética',
  `din_medicao` date DEFAULT NULL COMMENT 'Dia da medida',
  `val_vazaomedia` float DEFAULT NULL COMMENT 'Vazão Média do Posto Fluviométrico medido em m3/s',
  `val_vazaomediaincr` float DEFAULT NULL COMMENT 'Vazão Incremental entre Postos Fluviométricos medido em m3/s',
  CONSTRAINT `GRANDEZAS_FLUVIOMETRICAS_chk_1` CHECK ((`val_vazaomedia` >= 0)),
  CONSTRAINT `GRANDEZAS_FLUVIOMETRICAS_chk_2` CHECK ((`val_vazaomediaincr` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ICRB-CCAT
CREATE TABLE `ICRB-CCAT` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_tipoagregacao` tinytext NOT NULL,
  `id_periodicidade` tinytext NOT NULL,
  `num_agregacao` tinytext NOT NULL,
  `din_referencia` datetime NOT NULL,
  `num_transformadoresoperacao` int NOT NULL,
  `num_transformadoresviolados` int NOT NULL,
  `val_ccat` float NOT NULL,
  CONSTRAINT `ICRB-CCAT_chk_1` CHECK ((`num_transformadoresoperacao` >= 0)),
  CONSTRAINT `ICRB-CCAT_chk_2` CHECK ((`num_transformadoresviolados` >= 0)),
  CONSTRAINT `ICRB-CCAT_chk_3` CHECK ((`val_ccat` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ICRB-CIPER
CREATE TABLE `ICRB-CIPER` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `dsc_agregacao` varchar(200) NOT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dsc_caracteristica` varchar(200) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_ciper1` float NOT NULL,
  `val_ciper2` float NOT NULL,
  `val_ciper3` float NOT NULL,
  `val_ciper4` float NOT NULL,
  `val_ciper5` float NOT NULL,
  CONSTRAINT `ICRB-CIPER_chk_1` CHECK ((`dsc_agregacao` is not null)),
  CONSTRAINT `ICRB-CIPER_chk_10` CHECK ((`val_ciper5` >= 0)),
  CONSTRAINT `ICRB-CIPER_chk_2` CHECK ((`cod_caracteristica` is not null)),
  CONSTRAINT `ICRB-CIPER_chk_3` CHECK ((`dsc_caracteristica` is not null)),
  CONSTRAINT `ICRB-CIPER_chk_4` CHECK ((`id_periodicidade` is not null)),
  CONSTRAINT `ICRB-CIPER_chk_5` CHECK ((`din_referencia` is not null)),
  CONSTRAINT `ICRB-CIPER_chk_6` CHECK ((`val_ciper1` >= 0)),
  CONSTRAINT `ICRB-CIPER_chk_7` CHECK ((`val_ciper2` >= 0)),
  CONSTRAINT `ICRB-CIPER_chk_8` CHECK ((`val_ciper3` >= 0)),
  CONSTRAINT `ICRB-CIPER_chk_9` CHECK ((`val_ciper4` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela ICRB_DF
CREATE TABLE `ICRB_DF` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `dsc_agregacao` varchar(200) NOT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dsc_caracteristica` varchar(200) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_dreq` float NOT NULL,
  `val_freq` float NOT NULL,
  CONSTRAINT `ICRB_DF_chk_1` CHECK ((`val_dreq` >= 0)),
  CONSTRAINT `ICRB_DF_chk_2` CHECK ((`val_freq` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IDFT_LT_TRANSF
CREATE TABLE `IDFT_LT_TRANSF` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dat_referencia` date NOT NULL,
  `val_disp` float NOT NULL,
  `val_indisppf` float NOT NULL,
  `val_indispff` float NOT NULL,
  CONSTRAINT `IDFT_LT_TRANSF_chk_1` CHECK ((`val_disp` >= 0)),
  CONSTRAINT `IDFT_LT_TRANSF_chk_2` CHECK ((`val_indisppf` >= 0)),
  CONSTRAINT `IDFT_LT_TRANSF_chk_3` CHECK ((`val_indispff` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IDF_TRANS_CONV
CREATE TABLE `IDF_TRANS_CONV` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_caracteristica` varchar(100) NOT NULL COMMENT 'Código da Característica do Indicador',
  `dat_referencia` date NOT NULL COMMENT 'Data de Referência',
  `val_dispftconv` float NOT NULL COMMENT 'Indicador de Disponibilidade das Funções Transmissão Conversora (DISPFTConv)',
  CONSTRAINT `CHK_val_dispftconv_zero` CHECK ((`val_dispftconv` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE
CREATE TABLE `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_conversora` varchar(20) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_modalidadecontratual` float NOT NULL,
  `val_modalidadeemergencial` float NOT NULL,
  `val_modalidadeoportunidade` float NOT NULL,
  `val_modalidadeteste` float NOT NULL,
  `val_modalidadeexcepcional` float NOT NULL,
  CONSTRAINT `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE_chk_1` CHECK ((`val_modalidadecontratual` >= 0)),
  CONSTRAINT `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE_chk_2` CHECK ((`val_modalidadeemergencial` >= 0)),
  CONSTRAINT `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE_chk_3` CHECK ((`val_modalidadeoportunidade` >= 0)),
  CONSTRAINT `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE_chk_4` CHECK ((`val_modalidadeteste` >= 0)),
  CONSTRAINT `IEMP_INTERCAMBIO_ENERGIA_POR_MODALIDADE_chk_5` CHECK ((`val_modalidadeexcepcional` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IFT_ECR
CREATE TABLE `IFT_ECR` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dat_referencia` date NOT NULL,
  `val_disp` float NOT NULL,
  CONSTRAINT `IFT_ECR_chk_1` CHECK ((`val_disp` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO
CREATE TABLE `IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_pais` varchar(30) NOT NULL,
  `nom_agente` varchar(30) NOT NULL,
  `nom_bloco` varchar(70) NOT NULL,
  `cod_bloco` varchar(20) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_importacaoprogramada` float NOT NULL,
  `val_importacaodespachada` float NOT NULL,
  `val_importacaoverificada` float NOT NULL,
  `val_preco` float DEFAULT NULL,
  CONSTRAINT `IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO_chk_1` CHECK ((`val_importacaoprogramada` >= 0)),
  CONSTRAINT `IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO_chk_2` CHECK ((`val_importacaodespachada` >= 0)),
  CONSTRAINT `IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO_chk_3` CHECK ((`val_importacaoverificada` >= 0)),
  CONSTRAINT `IMPORTACAO_ENERGIA_MODALIDADE_COMERCIAL_BLOCO_chk_4` CHECK ((`val_preco` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela INDICADORES_CONF_REDE_BASICA_ATLS
CREATE TABLE `INDICADORES_CONF_REDE_BASICA_ATLS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_fluxo` varchar(8) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_atls` float NOT NULL,
  `num_horasviolacao` int NOT NULL,
  CONSTRAINT `INDICADORES_CONF_REDE_BASICA_ATLS_chk_1` CHECK ((`id_periodicidade` in (_utf8mb4'AN',_utf8mb4'ME'))),
  CONSTRAINT `INDICADORES_CONF_REDE_BASICA_ATLS_chk_2` CHECK ((`val_atls` >= 0)),
  CONSTRAINT `INDICADORES_CONF_REDE_BASICA_ATLS_chk_3` CHECK ((`num_horasviolacao` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela INDI_CNFIA_REDE_BASICA_TRANS
CREATE TABLE `INDI_CNFIA_REDE_BASICA_TRANS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_tipoagregacao` varchar(6) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `nom_agregacao` varchar(30) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `num_linhasoperacao` int NOT NULL,
  `num_linhasvioladas` int NOT NULL,
  `val_ccal` float NOT NULL,
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_1` CHECK ((`cod_tipoagregacao` is not null)),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_2` CHECK ((`id_periodicidade` is not null)),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_3` CHECK ((`nom_agregacao` is not null)),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_4` CHECK ((`din_referencia` is not null)),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_5` CHECK (((`num_linhasoperacao` is not null) and (`num_linhasoperacao` >= 0))),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_6` CHECK (((`num_linhasvioladas` is not null) and (`num_linhasvioladas` >= 0))),
  CONSTRAINT `INDI_CNFIA_REDE_BASICA_TRANS_chk_7` CHECK (((`val_ccal` is not null) and (`val_ccal` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IND_CONF_RB_SM_SEVERIDADE
CREATE TABLE `IND_CONF_RB_SM_SEVERIDADE` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `dsc_agregacao` varchar(200) NOT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dsc_caracteristica` varchar(200) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_sm1` float NOT NULL,
  `val_sm2` float NOT NULL,
  `val_sm3` float NOT NULL,
  `val_sm4` float NOT NULL,
  `val_sm5` float NOT NULL,
  CONSTRAINT `IND_CONF_RB_SM_SEVERIDADE_chk_1` CHECK ((`val_sm1` >= 0)),
  CONSTRAINT `IND_CONF_RB_SM_SEVERIDADE_chk_2` CHECK ((`val_sm2` >= 0)),
  CONSTRAINT `IND_CONF_RB_SM_SEVERIDADE_chk_3` CHECK ((`val_sm3` >= 0)),
  CONSTRAINT `IND_CONF_RB_SM_SEVERIDADE_chk_4` CHECK ((`val_sm4` >= 0)),
  CONSTRAINT `IND_CONF_RB_SM_SEVERIDADE_chk_5` CHECK ((`val_sm5` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IND_DESEMP_FUN_GER_UNID_GER_MENSAL
CREATE TABLE `IND_DESEMP_FUN_GER_UNID_GER_MENSAL` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(60) NOT NULL,
  `nom_modalidadeoperacao` varchar(100) NOT NULL,
  `nom_agenteproprietario` varchar(30) NOT NULL,
  `id_tipousina` varchar(3) NOT NULL,
  `id_usina` varchar(6) NOT NULL,
  `nom_usina` varchar(60) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `cod_equipamento` varchar(20) NOT NULL,
  `num_unidadegeradora` varchar(6) NOT NULL,
  `nom_unidadegeradora` varchar(72) NOT NULL,
  `val_potencia` float NOT NULL,
  `dat_mesreferencia` date NOT NULL,
  `val_dispf` float NOT NULL,
  `val_indisppf` float NOT NULL,
  `val_indispff` float NOT NULL,
  `val_dmdff` float NOT NULL,
  `val_fdff` float NOT NULL,
  `val_tdff` float NOT NULL,
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_1` CHECK ((`val_potencia` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_2` CHECK ((`val_dispf` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_3` CHECK ((`val_indisppf` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_4` CHECK ((`val_indispff` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_5` CHECK ((`val_dmdff` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_6` CHECK ((`val_fdff` >= 0)),
  CONSTRAINT `IND_DESEMP_FUN_GER_UNID_GER_MENSAL_chk_7` CHECK ((`val_tdff` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela INTERCAMBIOS_ENTRE_SUBSISTEMAS
CREATE TABLE `INTERCAMBIOS_ENTRE_SUBSISTEMAS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `id_subsistema_origem` char(3) NOT NULL,
  `nom_subsistema_origem` varchar(20) NOT NULL,
  `id_subsistema_destino` char(3) NOT NULL,
  `nom_subsistema_destino` varchar(20) NOT NULL,
  `val_intercambiomwmed` float NOT NULL,
  CONSTRAINT `INTERCAMBIOS_ENTRE_SUBSISTEMAS_chk_1` CHECK ((year(`din_instante`) between 1900 and 2100)),
  CONSTRAINT `INTERCAMBIOS_ENTRE_SUBSISTEMAS_chk_2` CHECK (((`val_intercambiomwmed` >= 0) or (`val_intercambiomwmed` < 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Intercâmbios Entre Subsistemas (IES)';

-- Script para a tabela INT_SIN_OUT_P
CREATE TABLE `INT_SIN_OUT_P` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `din_instante` datetime NOT NULL,
  `nom_paisdestino` varchar(30) NOT NULL,
  `val_intercambiomwmed` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IQERB_DFD_MA
CREATE TABLE `IQERB_DFD_MA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_periodicidade` varchar(2) NOT NULL COMMENT 'Periodicidade do indicador. Valores possíveis: 12 (janela dos últimos 12 meses), ME (Mensal)',
  `din_referencia` datetime NOT NULL COMMENT 'Mês do indicador',
  `id_faixafrequencia` varchar(3) NOT NULL COMMENT 'Identificador da faixa de frequência',
  `nom_faixafrequencia` varchar(50) NOT NULL COMMENT 'Faixa de frequência',
  `val_dfd` float NOT NULL COMMENT 'Valor do indicador, representando o tempo, em segundos, em que a frequência permaneceu na faixa correspondente',
  CONSTRAINT `IQERB_DFD_MA_chk_1` CHECK ((`val_dfd` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IQERB_DFP
CREATE TABLE `IQERB_DFP` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_periodicidade` char(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `num_desvio_perm_sobre` int NOT NULL,
  `num_desvio_perm_sub` int NOT NULL,
  `num_desvio_dist_sobre` int NOT NULL,
  `num_desvio_dist_sub` int NOT NULL,
  `num_minutos` int NOT NULL,
  `num_violadodis` int NOT NULL,
  `num_violadoperm` int NOT NULL,
  `val_dfp` float NOT NULL,
  CONSTRAINT `IQERB_DFP_chk_1` CHECK ((`num_desvio_perm_sobre` >= 0)),
  CONSTRAINT `IQERB_DFP_chk_2` CHECK ((`num_desvio_perm_sub` >= 0)),
  CONSTRAINT `IQERB_DFP_chk_3` CHECK ((`num_desvio_dist_sobre` >= 0)),
  CONSTRAINT `IQERB_DFP_chk_4` CHECK ((`num_desvio_dist_sub` >= 0)),
  CONSTRAINT `IQERB_DFP_chk_5` CHECK ((`num_minutos` > 0)),
  CONSTRAINT `IQERB_DFP_chk_6` CHECK ((`num_violadodis` > 0)),
  CONSTRAINT `IQERB_DFP_chk_7` CHECK ((`num_violadoperm` >= 0)),
  CONSTRAINT `IQERB_DFP_chk_8` CHECK ((`val_dfp` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela IQE_DFD_EVENTOS
CREATE TABLE `IQE_DFD_EVENTOS` (
  `id_param` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `din_referencia` datetime NOT NULL,
  `din_iniciosviofreq` datetime NOT NULL,
  `din_fimdesviofreq` datetime NOT NULL,
  `id_faixafrequencia` varchar(3) NOT NULL,
  `nom_faixafrequencia` varchar(50) NOT NULL,
  `val_dfd` int NOT NULL,
  `val_freqmaxmin` float NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `IQE_DFD_EVENTOS_chk_1` CHECK ((`val_dfd` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Indicadores de Qualidade de Energia da Rede Básica: DFD – Desempenho da Frequência em Distúrbios por Evento';

-- Script para a tabela MOUSINA
CREATE TABLE `MOUSINA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nome_usina` varchar(255) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `nom_modalidadeoperacao` varchar(20) NOT NULL,
  `val_potenciaautorizada` float NOT NULL,
  `sgl_centrooperacao` varchar(2) NOT NULL,
  `nom_pontoconexao` varchar(255) DEFAULT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `sts_aneel` varchar(1) DEFAULT NULL,
  CONSTRAINT `MOUSINA_chk_1` CHECK ((`val_potenciaautorizada` >= 0)),
  CONSTRAINT `MOUSINA_chk_2` CHECK (((`sts_aneel` in (_utf8mb4'A',_utf8mb4'I',_utf8mb4'P',_utf8mb4'C',_utf8mb4'O')) or (`sts_aneel` is null)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela OFERTAS_DE_PRECO_PARA_IMPORTACAO_OPI
CREATE TABLE `OFERTAS_DE_PRECO_PARA_IMPORTACAO_OPI` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_pais` varchar(30) NOT NULL,
  `nom_agente` varchar(30) NOT NULL,
  `nom_bloco` varchar(70) NOT NULL,
  `dat_iniciovalidade` datetime NOT NULL,
  `dat_fimvalidade` datetime NOT NULL,
  `val_preco` float NOT NULL,
  CONSTRAINT `OFERTAS_DE_PRECO_PARA_IMPORTACAO_OPI_chk_1` CHECK ((`val_preco` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela RCOUE
CREATE TABLE `RCOUE` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `nom_usina` varchar(60) DEFAULT NULL,
  `id_ons` varchar(6) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_geracao` float NOT NULL,
  `val_geracaolimitada` float DEFAULT NULL,
  `val_disponibilidade` float DEFAULT NULL,
  `val_geracaoreferencia` float DEFAULT NULL,
  `val_geracaoreferenciafinal` float DEFAULT NULL,
  `cod_razaorestricao` varchar(3) DEFAULT NULL,
  `cod_origemrestricao` varchar(3) DEFAULT NULL,
  CONSTRAINT `RCOUE_chk_1` CHECK ((`val_geracao` >= 0)),
  CONSTRAINT `RCOUE_chk_2` CHECK ((`val_geracaolimitada` >= 0)),
  CONSTRAINT `RCOUE_chk_3` CHECK ((`val_disponibilidade` >= 0)),
  CONSTRAINT `RCOUE_chk_4` CHECK ((`val_geracaoreferencia` >= 0)),
  CONSTRAINT `RCOUE_chk_5` CHECK ((`val_geracaoreferenciafinal` >= 0)),
  CONSTRAINT `RCOUE_chk_6` CHECK ((`cod_razaorestricao` in (_utf8mb4'REL',_utf8mb4'CNF',_utf8mb4'ENE',_utf8mb4'PAR'))),
  CONSTRAINT `RCOUE_chk_7` CHECK ((`cod_origemrestricao` in (_utf8mb4'LOC',_utf8mb4'SIS')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela RCU
CREATE TABLE `RCU` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `estad_id` varchar(2) NOT NULL,
  `nom_estado` varchar(60) NOT NULL,
  `id_tipousina` varchar(3) NOT NULL,
  `id_conjuntousina` int NOT NULL,
  `id_ons_conjunto` varchar(32) NOT NULL,
  `id_ons_usina` varchar(6) NOT NULL,
  `nom_conjunto` varchar(50) NOT NULL,
  `nom_usina` varchar(50) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `dat_iniciorelacionamento` date NOT NULL,
  `dat_fimrelacionamento` date DEFAULT NULL,
  CONSTRAINT `RCU_chk_1` CHECK ((`id_conjuntousina` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela REDE_BASICA_ENS
CREATE TABLE `REDE_BASICA_ENS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `dsc_agregacao` varchar(200) NOT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dsc_caracteristica` varchar(200) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_ens` float NOT NULL,
  CONSTRAINT `REDE_BASICA_ENS_chk_1` CHECK ((`val_ens` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela REL_GRUPO_USINA
CREATE TABLE `REL_GRUPO_USINA` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` tinytext NOT NULL,
  `nom_subsistema` tinytext NOT NULL,
  `id_estad` tinytext NOT NULL,
  `nom_estado` tinytext NOT NULL,
  `id_tipousina` tinytext NOT NULL,
  `id_ons_pequenasusinas` tinytext NOT NULL,
  `id_ons_usina` tinytext NOT NULL,
  `nom_pequenasusinas` tinytext NOT NULL,
  `nom_usina` tinytext NOT NULL,
  `ceg` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela RESERVATORIOS
CREATE TABLE `RESERVATORIOS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `nom_reservatorio` varchar(20) NOT NULL,
  `tip_reservatorio` varchar(40) NOT NULL,
  `cod_resplanejamento` int DEFAULT NULL,
  `cod_posto` int DEFAULT NULL,
  `nom_usina` varchar(60) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(20) NOT NULL,
  `nom_bacia` varchar(15) NOT NULL,
  `nom_rio` varchar(15) DEFAULT NULL,
  `nom_ree` varchar(20) DEFAULT NULL,
  `dat_entrada` date NOT NULL,
  `val_cotamaxima` float NOT NULL,
  `val_cotaminima` float NOT NULL,
  `val_volmax` float NOT NULL,
  `val_volmin` float NOT NULL,
  `val_volutiltot` float NOT NULL,
  `val_produtibilidadeespecifica` float NOT NULL,
  `val_produtividade65volutil` float NOT NULL,
  `val_tipoperda` varchar(1) NOT NULL,
  `val_perda` float NOT NULL,
  `val_latitude` float DEFAULT NULL,
  `val_longitude` float DEFAULT NULL,
  `id_reservatorio` varchar(6) NOT NULL,
  CONSTRAINT `RESERVATORIOS_chk_1` CHECK ((`cod_resplanejamento` is not null)),
  CONSTRAINT `RESERVATORIOS_chk_10` CHECK ((`val_volmin` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_11` CHECK ((`val_volutiltot` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_12` CHECK ((`val_produtibilidadeespecifica` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_13` CHECK ((`val_produtividade65volutil` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_14` CHECK ((`val_perda` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_2` CHECK ((`cod_resplanejamento` <> 0)),
  CONSTRAINT `RESERVATORIOS_chk_3` CHECK ((`cod_resplanejamento` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_4` CHECK ((`cod_posto` is not null)),
  CONSTRAINT `RESERVATORIOS_chk_5` CHECK ((`cod_posto` <> 0)),
  CONSTRAINT `RESERVATORIOS_chk_6` CHECK ((`cod_posto` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_7` CHECK ((`val_cotamaxima` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_8` CHECK ((`val_cotaminima` >= 0)),
  CONSTRAINT `RESERVATORIOS_chk_9` CHECK ((`val_volmax` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS
CREATE TABLE `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `id_subsistema` varchar(2) NOT NULL,
  `nom_subsistema` varchar(60) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_estado` varchar(30) NOT NULL,
  `nom_usina` varchar(60) DEFAULT NULL,
  `id_ons` varchar(6) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_geracao` float NOT NULL,
  `val_geracaolimitada` float DEFAULT NULL,
  `val_disponibilidade` float DEFAULT NULL,
  `val_geracaoreferencia` float DEFAULT NULL,
  `val_geracaoreferenciafinal` float DEFAULT NULL,
  `cod_razaorestricao` varchar(3) DEFAULT NULL,
  `cod_origemrestricao` varchar(3) DEFAULT NULL,
  CONSTRAINT `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS_chk_1` CHECK ((`val_geracao` >= 0)),
  CONSTRAINT `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS_chk_2` CHECK ((`val_geracaolimitada` >= 0)),
  CONSTRAINT `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS_chk_3` CHECK ((`val_disponibilidade` >= 0)),
  CONSTRAINT `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS_chk_4` CHECK ((`val_geracaoreferencia` >= 0)),
  CONSTRAINT `RESTRICAO_OPERACAO_CONSTRAINED_OFF_USINAS_FOTOVOLTAICAS_chk_5` CHECK ((`val_geracaoreferenciafinal` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ
CREATE TABLE `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ` (
  `id_param` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `cod_indicador` varchar(20) NOT NULL,
  `dsc_agregacao` varchar(200) NOT NULL,
  `cod_caracteristica` varchar(100) NOT NULL,
  `dsc_caracteristica` varchar(200) NOT NULL,
  `id_periodicidade` varchar(2) NOT NULL,
  `din_referencia` datetime NOT NULL,
  `val_indicador` float NOT NULL,
  `num_perturbacoes` float NOT NULL,
  `num_perturbacoescortecarga` float NOT NULL,
  `num_perturbacoescortecarga_0a50mw` float NOT NULL,
  `num_perturbacoescortecarga_50a100mw` float NOT NULL,
  `num_perturbacoescortecarga_maior100mw` float NOT NULL,
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_1` CHECK ((`val_indicador` >= 0)),
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_2` CHECK ((`num_perturbacoes` >= 0)),
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_3` CHECK ((`num_perturbacoescortecarga` >= 0)),
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_4` CHECK ((`num_perturbacoescortecarga_0a50mw` >= 0)),
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_5` CHECK ((`num_perturbacoescortecarga_50a100mw` >= 0)),
  CONSTRAINT `TB_INDICADORES_CONF_REDE_BASICA_ROBUSTEZ_chk_6` CHECK ((`num_perturbacoescortecarga_maior100mw` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela TB_IND_DISP_FUN_GER_SIN_MENSAL
CREATE TABLE `TB_IND_DISP_FUN_GER_SIN_MENSAL` (
  `id_param` int DEFAULT NULL,
  `dat_referencia` date NOT NULL,
  `val_dispff` float NOT NULL,
  `val_indisppff` float NOT NULL,
  `val_indispff` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela USINAS_EOLICAS_CONSTRAINED_OFF
CREATE TABLE `USINAS_EOLICAS_CONSTRAINED_OFF` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_modalidadeoperacao` varchar(20) NOT NULL,
  `nom_conjuntousina` varchar(50) DEFAULT NULL,
  `nom_usina` varchar(50) NOT NULL,
  `id_ons` varchar(6) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_ventoverificado` float DEFAULT NULL,
  `flg_dadoventoinvalido` float DEFAULT NULL,
  `val_geracaoestimada` float DEFAULT NULL,
  `val_geracaoverificada` float DEFAULT NULL,
  CONSTRAINT `USINAS_EOLICAS_CONSTRAINED_OFF_chk_1` CHECK ((`val_ventoverificado` >= 0)),
  CONSTRAINT `USINAS_EOLICAS_CONSTRAINED_OFF_chk_2` CHECK ((`flg_dadoventoinvalido` >= 0)),
  CONSTRAINT `USINAS_EOLICAS_CONSTRAINED_OFF_chk_3` CHECK ((`val_geracaoestimada` >= 0)),
  CONSTRAINT `USINAS_EOLICAS_CONSTRAINED_OFF_chk_4` CHECK ((`val_geracaoverificada` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para a tabela USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF
CREATE TABLE `USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF` (
  `id_param` int DEFAULT NULL,
  `id_subsistema` varchar(3) NOT NULL,
  `id_estado` varchar(2) NOT NULL,
  `nom_modalidadeoperacao` varchar(20) NOT NULL,
  `nom_conjuntousina` varchar(50) DEFAULT NULL,
  `nom_usina` varchar(50) NOT NULL,
  `id_ons` varchar(6) NOT NULL,
  `ceg` varchar(30) NOT NULL,
  `din_instante` datetime NOT NULL,
  `val_irradianciaverificado` float DEFAULT NULL,
  `flg_dadoirradianciainvalido` float DEFAULT NULL,
  `val_geracaoestimada` float DEFAULT NULL,
  `val_geracaoverificada` float DEFAULT NULL,
  CONSTRAINT `USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF_chk_1` CHECK ((`val_irradianciaverificado` >= 0)),
  CONSTRAINT `USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF_chk_2` CHECK ((`flg_dadoirradianciainvalido` >= 0)),
  CONSTRAINT `USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF_chk_3` CHECK ((`val_geracaoestimada` >= 0)),
  CONSTRAINT `USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF_chk_4` CHECK ((`val_geracaoverificada` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

