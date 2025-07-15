CREATE TABLE BALANCO_ENERGIA_DESSEM_GERAL(
	din_programacaodia datetime not null,
	num_patamar SMALLINT NOT null check (num_patamar > 0),
	cod_subsistema VARCHAR(2) not null,
	val_demanda FLOAT not null CHECK (val_demanda >=0),
	val_geracao_hidraulica FLOAT not null CHECK (val_geracao_hidraulica >=0),
	val_geracao_termica FLOAT not null CHECK (val_geracao_termica >=0),
	val_cons_elevatoria FLOAT not null CHECK (val_cons_elevatoria >=0)
);

CREATE TABLE BALANCO_ENERGIA_DESSEM_DETALHADO(
	din_programacaodia datetime not null,
	num_patamar SMALLINT NOT null check (num_patamar > 0),
	cod_subsistema VARCHAR(2) not null,
	val_demanda FLOAT not null CHECK (val_demanda >=0),
	val_geracao_hidraulica FLOAT not null CHECK (val_geracao_hidraulica >=0),
	val_ger_pch FLOAT not null CHECK (val_ger_pch >=0),
	val_geracao_termica FLOAT not null CHECK (val_geracao_termica >=0),
	val_ger_pct FLOAT not null CHECK (val_ger_pct >=0),
	val_ger_eolica FLOAT not null CHECK (val_ger_eolica >=0),
	val_ger_fotovoltaica FLOAT not null CHECK (val_ger_fotovoltaica >=0),
	val_ger_mmgd FLOAT not null CHECK (val_ger_mmgd >=0),
	val_cons_elevatoria FLOAT not null CHECK (val_cons_elevatoria >=0)
	
	
);

CREATE TABLE BALANCO_ENERGIA_SUBSISTEMA(
	id_subsistema VARCHAR(3) NOT NULL,
    nome_subsistema VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_gerhidraulica FLOAT,
    val_gertermica FLOAT,
    val_gereolica FLOAT,
    val_gersolar FLOAT,
    val_carga FLOAT NOT NULL,
    val_intercambio FLOAT,
    CHECK (val_gerhidraulica >= 0 OR val_gerhidraulica IS NULL),
    CHECK (val_gertermica >= 0 OR val_gertermica IS NULL),
    CHECK (val_gereolica >= 0 OR val_gereolica IS NULL),
    CHECK (val_gersolar >= 0 OR val_gersolar IS NULL),
    CHECK (val_carga >= 0)
)

CREATE TABLE CAPACIDADE_INSTALADA_GERACAO (
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    nom_agenteproprietario VARCHAR(30) NOT NULL,
    nom_agenteoperador VARCHAR(30) NOT NULL,
    nom_tipousina VARCHAR(30) NOT NULL CHECK (nom_tipousina IN ('EOLIELÉTRICA', 'FOTOVOLTAICA', 'HIDROELÉTRICA', 'NUCLEAR', 'TÉRMICA')),
    nom_usina VARCHAR(60) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    nom_unidadegeradora VARCHAR(72) NOT NULL,
    cod_equipamento VARCHAR(20) NOT NULL,
    num_unidadegeradora VARCHAR(6) NOT NULL,
    nom_combustivel VARCHAR(30) NOT NULL,
    dat_entradateste DATETIME,
    dat_entradaoperacao DATETIME NOT NULL,
    dat_desativacao DATETIME,
    val_potenciaefetiva FLOAT NOT NULL CHECK (val_potenciaefetiva >= 0)
);

CREATE TABLE CAPACIDADE_TRANSFORMACAO_REDE_BASICA(
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    nom_tipotransformador VARCHAR(45) NOT NULL,
    nom_agenteproprietario VARCHAR(30) NOT NULL,
    nom_subestacao VARCHAR(20) NOT NULL,
    nom_transformador VARCHAR(72) NOT NULL,
    cod_equipamento VARCHAR(20) NOT NULL,
    dat_entradaoperacao DATE NOT NULL,
    dat_desativacao DATE NULL, -- Allows NULL values, meaning the transformer is active [cite: 9]
    val_tensaoprimario_kv FLOAT NOT NULL CHECK (val_tensaoprimario_kv >= 0), -- Does not allow NULL, zero, or negative values [cite: 9]
    val_tensaosecundario_kv FLOAT NOT NULL CHECK (val_tensaosecundario_kv >= 0), -- Does not allow NULL, zero, or negative values [cite: 9]
    val_tensaoterciario_kv FLOAT NULL CHECK (val_tensaoterciario_kv >= 0), -- Allows NULL, but not zero or negative values [cite: 9]
    val_potencianominal_mva FLOAT NOT NULL CHECK (val_potencianominal_mva >= 0), -- Does not allow NULL, zero, or negative values [cite: 12]
    nom_tipoderede VARCHAR(15) NOT NULL,
    num_barra_primario INTEGER NOT NULL,
    num_barra_secundario INTEGER NOT NULL
	
);

CREATE TABLE CARGA_ENERGIA_DIARIA (
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_cargaenergiamwmed FLOAT NOT NULL CHECK (val_cargaenergiamwmed >= 0)
);


CREATE TABLE CARGA_ENERGIA_MENSAL (
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_cargaenergiamwmed FLOAT NOT NULL CHECK (val_cargaenergiamwmed >= 0)
  
);

CREATE TABLE CARGA_GLOBAL_RORAIMA (
	din_instante DATETIME NOT NULL,
    val_carga_mw FLOAT(10, 3) NOT NULL CHECK (val_carga_mw >= 0)
	
);

CREATE TABLE CMO_SEMANAL (
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_cmomediasemanal FLOAT NOT NULL,
    val_cmoleve FLOAT NOT NULL ,
    val_cmomedia FLOAT NOT NULL ,
    val_cmopesada FLOAT NOT NULL
);


CREATE TABLE CMO_SEMIHORARIO(
	id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_cmo FLOAT NOT NULL
);

CREATE TABLE CVU_USINAS_TERMICAS(
 	dat_iniciosemana DATE NOT NULL,
    dat_fimsemana DATE NOT NULL,
    ano_referencia INT NOT NULL,
    mes_referencia INT NOT NULL,
    num_revisao INT NOT NULL,
    nom_semanaoperativa VARCHAR(150) NOT NULL,
    cod_modelos INT NOT NULL,
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    nom_usina VARCHAR(150) NOT NULL,
    val_cvu DECIMAL(18, 2) NOT NULL,
    -- CHECK constraints
    CONSTRAINT chk_ano_referencia_not_zero CHECK (ano_referencia != 0),
    CONSTRAINT chk_ano_referencia_not_negative CHECK (ano_referencia >= 0),
    CONSTRAINT chk_mes_referencia_not_zero CHECK (mes_referencia != 0),
    CONSTRAINT chk_mes_referencia_not_negative CHECK (mes_referencia >= 0),
    CONSTRAINT chk_num_revisao_not_negative CHECK (num_revisao >= 0),
    CONSTRAINT chk_cod_modelos_not_zero CHECK (cod_modelos != 0),
    CONSTRAINT chk_cod_modelos_not_negative CHECK (cod_modelos >= 0),
    CONSTRAINT chk_val_cvu_not_negative CHECK (val_cvu >= 0)
);

CREATE TABLE CONTORNOS_BACIAS_HIDROGRAFICAS(
	dat_iniciosemana DATE NOT NULL,
    dat_fimsemana DATE NOT NULL,
    ano_referencia INT NOT NULL CHECK (ano_referencia > 0),
    mes_referencia INT NOT NULL CHECK (mes_referencia >= 1 AND mes_referencia <= 12),
    num_revisao INT NOT NULL CHECK (num_revisao >= 0),
    nom_semanaoperativa VARCHAR(150) NOT NULL,
    cod_modelos INT NOT NULL CHECK (cod_modelos > 0),
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    nom_usina VARCHAR(150) NOT NULL,
    val_cvu DECIMAL(18, 2) NOT NULL CHECK (val_cvu >= 0)
);

CREATE TABLE DADOS_HIDROLOGICOS_RESERVATORIOS_DIARIOS (
    dat_iniciosemana DATE NOT NULL,
    dat_fimsemana DATE NOT NULL,
    ano_referencia INTEGER NOT NULL CHECK (ano_referencia > 0), -- Não permite valor zerado nem negativo
    mes_referencia INTEGER NOT NULL CHECK (mes_referencia >= 1 AND mes_referencia <= 12), -- Não permite valor zerado nem negativo (e garante um mês válido)
    num_revisao INTEGER NOT NULL CHECK (num_revisao >= 0), -- Permite valor zerado, mas não negativo
    nom_semanaoperativa VARCHAR(150) NOT NULL,
    cod_modelos INTEGER NOT NULL CHECK (cod_modelos > 0), -- Não permite valor zerado nem negativo
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    nom_usina VARCHAR(150) NOT NULL,
    val_cvu DECIMAL(18, 2) NOT NULL CHECK (val_cvu >= 0) -- Permite valor zerado, mas não negativo
);


CREATE TABLE DADOS_HIDROLOGICOS_RESERVATORIOS_HORARIOS (
    id_subsistema VARCHAR(2) NOT NULL ,
    nom_subsistema VARCHAR(40) NOT NULL, 
    tip_reservatorio VARCHAR(40) NOT NULL, 
    nom_bacia VARCHAR(15) NOT NULL ,
    id_reservatorio VARCHAR(6) NOT NULL ,
    nom_reservatorio VARCHAR(20) NOT NULL , 
    cod_usina INTEGER CHECK ( cod_usina > 0), -- Permite nulo, mas não zerado ou negativo
    din_instante DATETIME NOT NULL,
    val_nivelmontante FLOAT NOT NULL CHECK (val_nivelmontante >= 0), -- Não permite nulo, zerado ou negativo
    val_niveljusante FLOAT CHECK (val_niveljusante > 0), -- Permite nulo, mas não zerado ou negativo
    val_volumeutil FLOAT ,
    val_vazaoafluente FLOAT,
    val_vazaodefluente FLOAT CHECK ( val_vazaodefluente >= 0), -- Permite nulo, mas não zerado ou negativo
    val_vazaoturbinada FLOAT CHECK ( val_vazaoturbinada >= 0), -- Permite nulo, mas não zerado ou negativo
    val_vazaovertida FLOAT CHECK (val_vazaovertida >= 0), -- Permite nulo, mas não zerado ou negativo
    val_vazaooutrasestruturas FLOAT CHECK (val_vazaooutrasestruturas >= 0), -- Permite nulo, mas não zerado ou negativo
    val_vazaotransferida FLOAT,
    val_vazaovertidanaoturbinavel FLOAT CHECK ( val_vazaovertidanaoturbinavel >= 0) -- Permite nulo, mas não zerado ou negativo
);



CREATE TABLE DADOS_HIDROLOGICOS_VOLUME_ESPERA_RECOMENDADO (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    tip_reservatorio VARCHAR(40) NOT NULL,
    nom_bacia VARCHAR(15) NOT NULL,
    nom_ree VARCHAR(20),
    id_reservatorio VARCHAR(6) NOT NULL,
    nom_reservatorio VARCHAR(20) NOT NULL,
    num_ordemcs INTEGER CHECK (num_ordemcs >= 0), -- Permite nulo: Não, Zerado: Não, Negativo: Não
    cod_usina INTEGER CHECK ( cod_usina >= 0), -- Permite nulo: Não, Zerado: Não, Negativo: Não
    din_instante DATETIME NOT NULL,
    val_volumeespera FLOAT NOT NULL CHECK (val_volumeespera >= 0) -- Permite nulo: Não, Zerado: Sim, Negativo: Não
);


CREATE TABLE DADOS_DOS_PROGRAMADOS_DOS_ELEMENTOS_DE_FLUXO_CONTROLADO (
    din_programacaodia DATETIME NOT NULL,
    num_patamar INT NOT NULL CHECK (num_patamar > 0),
    nom_elementofluxocontrolado VARCHAR(500) NOT NULL,
    dsc_elementofluxocontrolado VARCHAR(500) NOT NULL,
    tip_terminal INT NOT NULL CHECK (tip_terminal > 0),
    cod_submercado VARCHAR(3) NOT NULL,
    val_carga FLOAT NOT NULL
);


CREATE TABLE Dados_dos_Programados_dos_Elementos_de_Fluxo_Controlado (
    dat_programacao DATETIME NOT NULL,
    num_patamar INT NOT NULL,
    cod_usinapdp VARCHAR(100) NOT NULL,
    nom_usinapdp VARCHAR(250) NOT NULL,
    val_previsao FLOAT NOT NULL,
    val_programado FLOAT NOT NULL,
   -- Garante que a data não seja nula (redundante com NOT NULL, mas explícito)
    CONSTRAINT chk_dat_programacao_min_value CHECK (dat_programacao >= '1000-01-01 00:00:00'), -- Garante uma data de referência válida
    CONSTRAINT chk_num_patamar_positive CHECK (num_patamar > 0), -- Garante que o número do patamar seja positivo
    CONSTRAINT chk_val_previsao_non_negative CHECK (val_previsao >= 0), -- Garante que o valor previsto não seja negativo
    CONSTRAINT chk_val_programado_non_negative CHECK (val_programado >= 0) -- Garante que o valor programado não seja negativo
);



CREATE TABLE dados_pvp_eol_solar (
    dat_programacao DATETIME NOT NULL CHECK (dat_programacao IS NOT NULL),
    num_patamar INTEGER NOT NULL CHECK (num_patamar IS NOT NULL AND num_patamar >= 0),
    cod_usinapdp VARCHAR(100) NOT NULL CHECK (cod_usinapdp IS NOT NULL),
    nom_usinapdp VARCHAR(250) NOT NULL CHECK (nom_usinapdp IS NOT NULL),
    val_previsao FLOAT NOT NULL CHECK (val_previsao IS NOT NULL AND val_previsao >= 0),
    val_programado FLOAT NOT NULL CHECK (val_programado IS NOT NULL AND val_programado >= 0)
);


SQL

CREATE TABLE DADOS_DOS_VALORES_DA_PROGRAMACAO_DIARIA (
    din_programacaodia DATETIME NOT NULL,
    num_patamar INTEGER NOT NULL CHECK (num_patamar != 0) CHECK (num_patamar >= 0),
    cod_exibicaousina VARCHAR(100) NOT NULL,
    nom_usina VARCHAR(250) NOT NULL,
    tip_geracao VARCHAR(50) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20),
    id_subsistema VARCHAR(3),
    nom_subsistema VARCHAR(60),
    id_estado VARCHAR(2),
    nom_estado VARCHAR(30),
    val_geracaoprogramada FLOAT NOT NULL,
    val_disponibilidade FLOAT CHECK (val_disponibilidade >= 0),
    val_ordemmerito FLOAT CHECK (val_ordemmerito >= 0),
    val_inflexibilidade FLOAT CHECK (val_inflexibilidade >= 0),
    val_uc FLOAT CHECK (val_uc >= 0),
    val_razaoeletrica FLOAT CHECK (val_razaoeletrica >= 0),
    val_geracaoenergetica FLOAT CHECK (val_geracaoenergetica >= 0),
    val_gesubgsub FLOAT CHECK (val_gesubgsub >= 0),
    val_exportacao FLOAT CHECK (val_exportacao >= 0),
    val_reposicaoexportacao FLOAT CHECK (val_reposicaoexportacao >= 0),
    val_faltacombustivel FLOAT CHECK (val_faltacombustivel >= 0)
);


CREATE TABLE DADOS_DE_DISPONIBILIDADE_DE_USINAS_EM_BASE_HORARIA (
    id_subsistema VARCHAR NOT NULL, -- Permite valor nulo: Não
    nom_subsistema VARCHAR(20) NOT NULL, -- Permite valor nulo: Não
    id_estado VARCHAR(2) NOT NULL, -- Permite valor nulo: Não
    nom_estado VARCHAR(30) NOT NULL, -- Permite valor nulo: Não
    nom_usina VARCHAR(60) NOT NULL, -- Permite valor nulo: Não
    id_tipousina VARCHAR(30) NOT NULL, -- Permite valor nulo: Não
    nom_tipocombustivel VARCHAR(50) NOT NULL, -- Permite valor nulo: Não
    id_ons VARCHAR(32) NOT NULL, -- Permite valor nulo: Não
    din_instante DATETIME NOT NULL, -- Permite valor nulo: Não
    val_potenciainstalada FLOAT NOT NULL CHECK (val_potenciainstalada >= 0), -- Permite valor nulo: Não, Permite valor zerado: Sim, Permite valor negativo: Não
    val_dispoposicional FLOAT NOT NULL CHECK (val_dispoposicional >= 0), -- Permite valor nulo: Não, Permite valor zerado: Sim, Permite valor negativo: Não
    val_dispincronizada FLOAT NOT NULL CHECK (val_dispincronizada >= 0) -- Permite valor nulo: Não, Permite valor zerado: Sim, Permite valor negativo: Não
);


CREATE TABLE EAR_DIARIO_POR_BACIA (
    nom_curto VARCHAR(15) NOT NULL,
    ear_data DATE NOT NULL,
    ear_max_bacia FLOAT NOT NULL CHECK (ear_max_bacia >= 0),
    ear_verif_bacia_mwmes FLOAT NOT NULL CHECK (ear_verif_bacia_mwmes >= 0),
    ear_verif_bacia_percentual FLOAT NOT NULL CHECK (ear_verif_bacia_percentual >= 0)
);

CREATE TABLE EAR_DIARIO_REE (
    nom_ree VARCHAR(20) NOT NULL,
    ear_data DATETIME NOT NULL,
    ear_max_ree FLOAT NOT NULL CHECK (ear_max_ree > 0),
    ear_verif_ree_mwmes FLOAT NOT NULL CHECK (ear_verif_ree_mwmes != 0),
    ear_verif_ree_percentual FLOAT NOT NULL CHECK (ear_verif_ree_percentual > 0)
);


CREATE TABLE EAR_DIARIO_RESEVATORIO (
    `nom_reservatorio` VARCHAR(20) NOT NULL,
    `cod_resplanejamento` INT NOT NULL CHECK (`cod_resplanejamento` >= 0),
    `tip_reservatorio` VARCHAR(40) NOT NULL,
    `nom_bacia` VARCHAR(15) NOT NULL,
    `nom_ree` VARCHAR(20),
    `id_subsistema` VARCHAR(2) NOT NULL,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `id_subsistema_jusante` VARCHAR(2) NOT NULL,
    `nom_subsistema_jusante` VARCHAR(20) NOT NULL,
    `ear_data` DATETIME NOT NULL,
    `ear_reservatorio_subsistema_proprio_mwmes` FLOAT NOT NULL CHECK (`ear_reservatorio_subsistema_proprio_mwmes` >= 0),
    `ear_reservatorio_subsistema_jusante_mwmes` FLOAT NOT NULL CHECK (`ear_reservatorio_subsistema_jusante_mwmes` >= 0),
    `earmax_reservatorio_subsistema_proprio_mwmes` FLOAT NOT NULL CHECK (`earmax_reservatorio_subsistema_proprio_mwmes` >= 0),
    `earmax_reservatorio_subsistema_jusante_mwmes` FLOAT NOT NULL CHECK (`earmax_reservatorio_subsistema_jusante_mwmes` >= 0),
    `ear_reservatorio_percentual` FLOAT NOT NULL CHECK (`ear_reservatorio_percentual` >= 0),
    `ear_total_mwmes` FLOAT NOT NULL CHECK (`ear_total_mwmes` >= 0),
    `ear_maxima_total_mwmes` FLOAT NOT NULL CHECK (`ear_maxima_total_mwmes` >= 0),
    `val_contribearbacia` FLOAT NOT NULL CHECK (`val_contribearbacia` >= 0),
    `val_contribearmaxbacia` FLOAT NOT NULL CHECK (`val_contribearmaxbacia` >= 0),
    `val_contribearsubsistema` FLOAT NOT NULL CHECK (`val_contribearsubsistema` >= 0),
    `val_contribearmaxsubsistema` FLOAT NOT NULL CHECK (`val_contribearmaxsubsistema` >= 0),
    `val_contribearsubsistemajusante` FLOAT NOT NULL CHECK (`val_contribearsubsistemajusante` >= 0),
    `val_contribearmaxsubsistemajusante` FLOAT NOT NULL CHECK (`val_contribearmaxsubsistemajusante` >= 0),
    `val_contribearsin` FLOAT NOT NULL CHECK (`val_contribearsin` >= 0),
    `val_contribearmaxsin` FLOAT NOT NULL CHECK (`val_contribearmaxsin` >= 0)
);


CREATE TABLE EAR_Diario_por_Subsistema (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    ear_data DATE NOT NULL,
    ear_max_subsistema FLOAT NOT NULL CHECK (ear_max_subsistema > 0),
    ear_verif_subsistema_mwmes FLOAT NOT NULL CHECK (ear_verif_subsistema_mwmes > 0),
    ear_verif_subsistema_percentual FLOAT NOT NULL CHECK (ear_verif_subsistema_percentual > 0)
);

SELECT a.ena_armazenavel_bacia_percentualmlt
FROm ENA_Diario_por_Bacia a;

CREATE TABLE ENA_Diario_por_Bacia (
    `nom_bacia` VARCHAR(15) NOT NULL,
    `ena_data` DATE NOT NULL,
    `ena_bruta_bacia_mwmed` FLOAT NOT NULL ,
    `ena_bruta_bacia_percentualmlt` FLOAT NOT NULL ,
    `ena_armazenavel_bacia_mwmed` FLOAT NOT NULL,
    `ena_armazenavel_bacia_percentualmlt` FLOAT NOT NULL 
);



CREATE TABLE ena_diario_por_ree_reservatorio_equivalente_de_energia(
    `nom_ree` VARCHAR(20) NOT NULL,
    `ena_data` DATE NOT NULL,
    `ena_bruta_ree_mwmed` FLOAT NOT NULL  CHECK (`ena_bruta_ree_mwmed` > 0),
    `ena_bruta_ree_percentualmlt` FLOAT NOT NULL CHECK (`ena_bruta_ree_percentualmlt` > 0),
    `ena_armazenavel_ree_mwmed` FLOAT NOT NULL CHECK (`ena_armazenavel_ree_mwmed` != 0),
    `ena_armazenavel_ree_percentualmlt` FLOAT NOT NULL CHECK (`ena_armazenavel_ree_percentualmlt` != 0)
);


CREATE TABLE `ENA_Diario_por_Subsistema` (
    `id_subsistema` VARCHAR(2) NOT NULL,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `ena_data` DATE NOT NULL,
    `ena_bruta_regiao_mwmed` FLOAT NOT NULL,
    `ena_bruta_regiao_percentualmlt` FLOAT NOT NULL,
    `ena_armazenavel_regiao_mwmed` FLOAT NOT NULL,
    `ena_armazenavel_regiao_percentualmlt` FLOAT NOT NULL,

    -- Restrições CHECK com base nas colunas "Permite valor nulo", "Permite valor zerado", "Permite valor negativo"
    -- id_subsistema: Não Nulo, Não Zerado (implícito por não ser numérico), Não Negativo (implícito)
    -- nom_subsistema: Não Nulo, Não Zerado (implícito por não ser numérico), Não Negativo (implícito)
    -- ena_data: Não Nulo, Não Zerado (implícito por ser data), Não Negativo (implícito)

    -- ena_bruta_regiao_mwmed: Não Nulo, Não Zerado, Não Negativo

    CHECK (`ena_bruta_regiao_mwmed` <> 0),
    CHECK (`ena_bruta_regiao_mwmed` >= 0),

    -- ena_bruta_regiao_percentualmlt: Não Nulo, Não Zerado, Sim (Permite Negativo)

    CHECK (`ena_bruta_regiao_percentualmlt` <> 0),

    -- ena_armazenavel_regiao_mwmed: Não Nulo, Não Zerado, Sim (Permite Negativo)

    CHECK (`ena_armazenavel_regiao_mwmed` <> 0),

    -- ena_armazenavel_regiao_percentualmlt: Não Nulo, Não Zerado, Sim (Permite Negativo)
  
    CHECK (`ena_armazenavel_regiao_percentualmlt` <> 0)
);


CREATE TABLE `ENA_DIARIO_POR_RESEVATORIO` (

    `nome_reservatorio` VARCHAR(20) NOT NULL,
    `cod_replanejamento` INT NOT NULL,
    `tip_reservatorio` VARCHAR(40) NOT NULL,
    `nom_bacia` VARCHAR(15) NOT NULL,
    `nom_ree` VARCHAR(20) NULL,
    `id_subsistema` VARCHAR(2) NOT NULL,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `ena_data` DATE NOT NULL,

    `ena_bruta_res_mwmed` FLOAT NOT NULL CHECK (`ena_bruta_res_mwmed` >= 0),
    `ena_bruta_res_percentualmlt` FLOAT NOT NULL CHECK (`ena_bruta_res_percentualmlt` >= 0),
    `ena_armazenavel_res_mwmed` FLOAT NOT NULL CHECK (`ena_armazenavel_res_mwmed` >= 0),
    `ena_armazenavel_res_percentualmlt` FLOAT NOT NULL CHECK (`ena_armazenavel_res_percentualmlt` >= 0),
    `ena_queda_bruta` FLOAT NOT NULL CHECK (`ena_queda_bruta` >= 0),
    `mlt_ena` FLOAT NOT NULL CHECK (`mlt_ena` >= 0)
);


CREATE TABLE Energia_Vertida_Turbinavel (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(40) NOT NULL,
    nom_bacia VARCHAR(15) NOT NULL,
    nom_rio VARCHAR(15) NOT NULL,
    nom_agente VARCHAR(30) NOT NULL,
    nom_reservatorio VARCHAR(20) NOT NULL,
    cod_usina INT NOT NULL,
    din_instante DATETIME NOT NULL,
    val_geracao FLOAT NOT NULL CHECK (val_geracao >= 0),
    val_disponibilidade FLOAT NOT NULL CHECK (val_disponibilidade >= 0),
    val_vazaoturbinada FLOAT NOT NULL CHECK (val_vazaoturbinada >= 0),
    val_vazaovertida FLOAT NOT NULL CHECK (val_vazaovertida >= 0),
    val_vazaovertidanoturbinavel FLOAT NOT NULL CHECK (val_vazaovertidanoturbinavel >= 0),
    val_produtividade FLOAT NOT NULL CHECK (val_produtividade > 0),
    val_folgadeGeracao FLOAT NOT NULL CHECK (val_folgadeGeracao >= 0),
    val_energiavertida FLOAT NOT NULL CHECK (val_energiavertida >= 0),
    val_vazaovertidaturbinavel FLOAT NOT NULL CHECK (val_vazaovertidaturbinavel >= 0),
    val_energiavertidaturbinavel FLOAT NOT NULL CHECK (val_energiavertidaturbinavel >= 0)
);


CREATE TABLE `Equipamentos_Controle_Reativos_Rede_Operação` (
    `id_subsistema` VARCHAR(2) NOT NULL ,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `id_estado` VARCHAR(2) NOT NULL,
    `nom_estado` VARCHAR(30) NOT NULL ,
    `nom_subestacao` VARCHAR(20) NOT NULL ,
    `nom_agente_proprietario` VARCHAR(30) NOT NULL ,
    `nom_tipoderede` VARCHAR(15) NOT NULL ,
    `nom_tipoequipamento` VARCHAR(45) NOT NULL,
    `nom_equipamento` VARCHAR(72) NOT NULL ,
    `val_potreativanominal_mvar` FLOAT NULL ,
    `val_limiteinferior_mvar` FLOAT NULL,
    `val_limitesuperior_mvar` FLOAT NULL CHECK ( (`val_limitesuperior_mvar` != 0 AND `val_limitesuperior_mvar` > 0)),
    `dat_entradaoperacao` DATETIME NOT NULL ,
    `dat_desativacao` DATETIME NULL  ,
    `cod_equipamento` VARCHAR(20) NOT NULL 
);



SQL

CREATE TABLE Fator_Capacidade_Geração_Eolica_Solar (
    `id_subsistema` VARCHAR(2) NOT NULL,
    `nom_subsistema` VARCHAR(60) NOT NULL ,
    `id_estado` VARCHAR(2) NOT NULL ,
    `nom_estado` VARCHAR(30) NOT NULL ,
    `cod_pontoconexao` VARCHAR(11) NULL  ,
    `nom_pontoconexao` VARCHAR(45) NULL  ,
    `nom_localizacao` VARCHAR(20) NULL  ,
    `val_latitudesecoletora` FLOAT NULL CHECK (val_latitudesecoletora != 0) ,  
    `val_longitudesecoletora` FLOAT NULL CHECK (val_longitudesecoletora != 0),
    `val_latitudepontoconexao` FLOAT NULL CHECK(val_latitudepontoconexao != 0),
    `val_longitudepontoconexao` FLOAT NULL  CHECK (val_longitudepontoconexao != 0) ,
    `nom_modalidadeoperacao` VARCHAR(20) NOT NULL ,
    `nom_tipousina` VARCHAR(30) NOT NULL ,
    `nom_usina_conjunto` VARCHAR(60) NOT NULL ,
    `din_instante` DATETIME NOT NULL ,
    `id_ons` VARCHAR(6) NOT NULL ,
    `ceg` VARCHAR(30) NOT NULL ,
    `val_geracaoprogramada` FLOAT NOT NULL CHECK (val_geracaoprogramada >=0) ,
    `val_geracaoverificada` FLOAT NOT NULL CHECK (val_geracaoverificada >=0),
    `val_capacidadeinstalada` FLOAT NOT NULL CHECK (val_capacidadeinstalada >=0) ,
    `val_fatorcapacidade` FLOAT NOT NULL CHECK (val_fatorcapacidade >=0)
);




CREATE TABLE Geração_Comercial_Para_Exportação_Internacional (
    nom_conversora VARCHAR(20)  NULL,
    din_instante DATETIME  NULL,
    val_modalidadecontratual FLOAT  NULL,
    val_modalidadeemergencial FLOAT  NULL ,
    val_modalidadeoportunidade FLOAT  NULL ,
    val_modalidadeteste FLOAT  NULL ,
    val_modalidadeexcepcional FLOAT  NULL 
);


CREATE TABLE `GERACAO_USINA_BASE_HORARIA` (
    `din_instante` DATETIME NOT NULL,
    `id_subsistema` VARCHAR(3) NOT NULL,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `id_estado` VARCHAR(2) NOT NULL,
    `nom_estado` VARCHAR(30) NOT NULL,
    `cod_modalidadeoperacao` VARCHAR(20) NULL,
    `nom_tipousina` VARCHAR(30) NOT NULL,
    `nom_tipocombustivel` VARCHAR(50) NOT NULL,
    `nom_usina` VARCHAR(60) NOT NULL,
    `id_ons` VARCHAR(32) NOT NULL,
    `ceg` VARCHAR(30) NULL,
    `val_geracao` FLOAT NULL,

    -- Checks based on "Permite valor nulo"



    CONSTRAINT check_val_geracao_zero_allowed CHECK ( `val_geracao` >= 0), -- 'Sim' for val_geracao means zero is allowed, so we only restrict negative values here.

    -- Checks based on "Permite valor negativo" (assuming 'Não' means no negative allowed)
    CONSTRAINT check_val_geracao_non_negative CHECK (`val_geracao` >= 0)
);



CREATE TABLE `GERACAO_TERMICA_MOTIVO_DESPACHO` (
    `din_instante` DATETIME NOT NULL CHECK (`din_instante` >= 0),
    `nom_tipopatamar` VARCHAR(8) NOT NULL,
    `id_subsistema` VARCHAR(3) NOT NULL,
    `nom_subsistema` VARCHAR(20) NOT NULL,
    `nom_usina` VARCHAR(60) NOT NULL,
    `cod_usinaplanejamento` INT NOT NULL CHECK (`cod_usinaplanejamento` >= 0),
    `ceg` VARCHAR(30) NULL,
    `val_proggeracao` FLOAT NOT NULL CHECK (`val_proggeracao` >= 0),
    `val_progordemmerito` FLOAT NOT NULL CHECK (`val_progordemmerito` >= 0),
    `val_progordemdemeritoref` FLOAT NOT NULL CHECK (`val_progordemdemeritoref` >= 0),
    `val_progordemdemeritoacimadainflex` FLOAT NULL CHECK (`val_progordemdemeritoacimadainflex` >= 0),
    `val_proginflexibilidade` FLOAT NOT NULL CHECK (`val_proginflexibilidade` >= 0),
    `val_proginflexembutmerito` FLOAT NULL CHECK (`val_proginflexembutmerito` >= 0),
    `val_proginflexpura` FLOAT NULL CHECK (`val_proginflexpura` >= 0),
    `val_prograzaoeletrica` FLOAT NOT NULL CHECK (`val_prograzaoeletrica` >= 0),
    `val_proggarantiaenergetica` FLOAT NOT NULL CHECK (`val_proggarantiaenergetica` >= 0),
    `val_proggfom` FLOAT NOT NULL CHECK (`val_proggfom` >= 0),
    `val_progreposicaoperdas` FLOAT NOT NULL CHECK (`val_progreposicaoperdas` >= 0),
    `val_progexportacao` FLOAT NOT NULL CHECK (`val_progexportacao` >= 0),
    `val_progreservapotencia` FLOAT NULL CHECK (`val_progreservapotencia` >= 0),
    `val_proggsub` FLOAT NOT NULL CHECK (`val_proggsub` >= 0),
    `val_progunitcommitment` FLOAT NULL CHECK (`val_progunitcommitment` >= 0),
    `val_progconstrainedoff` FLOAT NULL CHECK (`val_progconstrainedoff` >= 0),
    `val_proginflexibilidadedessem` FLOAT NULL CHECK (`val_proginflexibilidadedessem` >= 0),
    `val_verifgeracao` FLOAT NOT NULL CHECK (`val_verifgeracao` >= 0),
    `val_verifordemmerito` FLOAT NOT NULL CHECK (`val_verifordemmerito` >= 0),
    `val_verifordemdemeritoacimadainflex` FLOAT NULL CHECK (`val_verifordemdemeritoacimadainflex` >= 0),
    `val_verifinflexibilidade` FLOAT NOT NULL CHECK (`val_verifinflexibilidade` >= 0),
    `val_verifinflexembutmerito` FLOAT NULL CHECK (`val_verifinflexembutmerito` >= 0),
    `val_verifinflexpura` FLOAT NULL CHECK (`val_verifinflexpura` >= 0),
    `val_verifrazaoeletrica` FLOAT NOT NULL CHECK (`val_verifrazaoeletrica` >= 0),
    `val_verifgarantiaenergetica` FLOAT NOT NULL CHECK (`val_verifgarantiaenergetica` >= 0),
    `val_verifgfom` FLOAT NOT NULL CHECK (`val_verifgfom` >= 0),
    `val_verifreposicaoperdas` FLOAT NOT NULL CHECK (`val_verifreposicaoperdas` >= 0),
    `val_verifexportacao` FLOAT NOT NULL CHECK (`val_verifexportacao` >= 0),
    `val_fdexp` FLOAT NOT NULL CHECK (`val_fdexp` >= 0),
    `val_verifreservapotencia` FLOAT NULL CHECK (`val_verifreservapotencia` >= 0),
    `val_atendsatisfatoriorpo` INT NULL CHECK (`val_atendsatisfatoriorpo` >= 0),
    `val_verifgsub` FLOAT NOT NULL CHECK (`val_verifgsub` >= 0),
    `val_verifunitcommitment` FLOAT NULL CHECK (`val_verifunitcommitment` >= 0),
    `val_verifconstrainedoff` FLOAT NOT NULL CHECK (`val_verifconstrainedoff` >= 0),
    `tip_restricaoeletrica` INT NULL CHECK (`tip_restricaoeletrica` >= 0)
);



Certo, vamos criar o script MySQL para a tabela "Grandezas Fluviométricas" com base na imagem fornecida.

Analisando a imagem, temos duas seções principais de dados. Vou criar uma tabela que combine essas informações, considerando os campos e suas características.

No MySQL, para simular as condições de "Permite valor nulo", "Permite valor zerado" e "Permite valor negativo", usaremos as seguintes abordagens:

Permite valor nulo: NULL ou NOT NULL.

Permite valor zerado: Para campos numéricos, o valor 0 é permitido por padrão, a menos que haja uma restrição específica. Não há um CHECK direto para "permitir valor zerado", pois ele já é permitido.

Permite valor negativo: Para campos numéricos, o valor negativo é permitido por padrão. Novamente, não há um CHECK direto para "permitir valor negativo", pois ele já é permitido. Se o "não permite valor negativo" fosse a regra, usaríamos CHECK (campo >= 0).

A tabela será criada com as colunas na ordem em que aparecem na imagem, consolidando as informações. O campo "Código" será a chave primária, pois é um identificador único.

Aqui está o script MySQL:

SQL

CREATE TABLE Grandezas_Fluviometricas (
    id_postofluviometrico VARCHAR(8) NOT NULL  COMMENT 'Identificador do Posto Fluviométrico conforme cadastro da Agência Nacional das Águas',
    nome_postofluviometrico VARCHAR(80) NOT NULL COMMENT 'Nome do Posto Fluviométrico',
    val_latitude FLOAT NULL COMMENT 'Latitude da localização do Posto Fluviométrico',
    val_longitude FLOAT NULL COMMENT 'Longitude da localização do Posto Fluviométrico',
    nom_rio VARCHAR(60) NULL COMMENT 'Nome do rio onde está localizado Posto Fluviométrico',
    nom_bacia VARCHAR(60) NULL COMMENT 'Nome Curto da Bacia Hidro Energética',
    din_medicao DATE NULL COMMENT 'Dia da medida',
    val_vazaomedia FLOAT NULL COMMENT 'Vazão Média do Posto Fluviométrico medido em m3/s',
    val_vazaomediaincr FLOAT NULL COMMENT 'Vazão Incremental entre Postos Fluviométricos medido em m3/s',

    -- Adicionando verificações baseadas na coluna "Permite valor negativo"
    -- Para val_latitude e val_longitude, a imagem indica "Sim" para negativo, então não há CHECK para isso.
    -- Para val_vazaomedia e val_vazaomediaincr, a imagem indica "Não" para negativo, então adicionamos CHECK.
    CHECK (val_vazaomedia >= 0),
    CHECK (val_vazaomediaincr >= 0)
);

-- Adicionando comentários para a tabela
ALTER TABLE Grandezas_Fluviometricas COMMENT = 'Tabela contendo informações sobre grandezas fluviométricas de postos.';

-- Adicionando comentários para as colunas com mais detalhes se necessário (já feito no CREATE TABLE)
-- ALTER TABLE Grandezas_Fluviometricas MODIFY COLUMN id_postofluviometrico VARCHAR(8) NOT NULL COMMENT 'Identificador do Posto Fluviométrico conforme cadastro da Agência Nacional das Águas';
-- ... e assim por diante para outras colunas se for necessário adicionar mais detalhes que não couberam no CREATE TABLE.



CREATE TABLE Importacao_Energia_Modalidade_Comercial_Bloco (
    nom_pais VARCHAR(30) NOT NULL,
    nom_agente VARCHAR(30) NOT NULL,
    nom_bloco VARCHAR(70) NOT NULL,
    cod_bloco VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_importacaoprogramada FLOAT NOT NULL CHECK (val_importacaoprogramada >= 0),
    val_importacaodespachada FLOAT NOT NULL CHECK (val_importacaodespachada >= 0),
    val_importacaoverificada FLOAT NOT NULL CHECK (val_importacaoverificada >= 0),
    val_preco FLOAT NULL CHECK (val_preco > 0)
);



CREATE TABLE indicadores_conf_rede_basica_atls (
    nom_fluxo VARCHAR(8) NOT NULL,
    id_periodicidade VARCHAR(2) NOT NULL CHECK (id_periodicidade IN ('AN', 'ME')),
    din_referencia DATETIME NOT NULL,
    val_atls FLOAT NOT NULL CHECK (val_atls >= 0),
    num_horasviolacao INT NOT NULL CHECK (num_horasviolacao >= 0)
);













