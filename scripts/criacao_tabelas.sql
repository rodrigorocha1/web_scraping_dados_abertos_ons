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

DROP TABLE dados_pvp_eol_solar


DADOS_PVP_EOL_SOLA

CREATE TABLE DADOS_PVP_EOL_SOLA (
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


DROP TABLE EAR_Diario_por_Subsistema; 

CREATE TABLE EAR_DIARIO_POR_SUBSISTEMA (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    ear_data DATE NOT NULL,
    ear_max_subsistema FLOAT NOT NULL CHECK (ear_max_subsistema > 0),
    ear_verif_subsistema_mwmes FLOAT NOT NULL CHECK (ear_verif_subsistema_mwmes > 0),
    ear_verif_subsistema_percentual FLOAT NOT NULL CHECK (ear_verif_subsistema_percentual > 0)
);

SELECT a.ena_armazenavel_bacia_percentualmlt
FROm ENA_Diario_por_Bacia a;

DROP TABLE ENA_Diario_por_Bacia

CREATE TABLE ENA_DIARIO_POR_BACIA (
    `nom_bacia` VARCHAR(15) NOT NULL,
    `ena_data` DATE NOT NULL,
    `ena_bruta_bacia_mwmed` FLOAT NOT NULL ,
    `ena_bruta_bacia_percentualmlt` FLOAT NOT NULL ,
    `ena_armazenavel_bacia_mwmed` FLOAT NOT NULL,
    `ena_armazenavel_bacia_percentualmlt` FLOAT NOT NULL 
);





CREATE TABLE ENA_DIARIO_POR_REE_RESERVATORIO_EQUIVALENTE_DE_ENERGIA(
    `nom_ree` VARCHAR(20) NOT NULL,
    `ena_data` DATE NOT NULL,
    `ena_bruta_ree_mwmed` FLOAT NOT NULL  CHECK (`ena_bruta_ree_mwmed` > 0),
    `ena_bruta_ree_percentualmlt` FLOAT NOT NULL CHECK (`ena_bruta_ree_percentualmlt` > 0),
    `ena_armazenavel_ree_mwmed` FLOAT NOT NULL CHECK (`ena_armazenavel_ree_mwmed` != 0),
    `ena_armazenavel_ree_percentualmlt` FLOAT NOT NULL CHECK (`ena_armazenavel_ree_percentualmlt` != 0)
);



CREATE TABLE `ENA_DIARIO_POR_SUBSISTEMA` (
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

ENERGIA_VERTIDA_TURBINAVEL

DROP TABLE Energia_Vertida_Turbinavel
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







CREATE TABLE `indi_cnfia_rede_basica_trans` (
    `cod_tipoagregacao` VARCHAR(6) NOT NULL CHECK (`cod_tipoagregacao` IS NOT NULL),
    `id_periodicidade` VARCHAR(2) NOT NULL CHECK (`id_periodicidade` IS NOT NULL),
    `nom_agregacao` VARCHAR(30) NOT NULL CHECK (`nom_agregacao` IS NOT NULL),
    `din_referencia` DATETIME NOT NULL CHECK (`din_referencia` IS NOT NULL),
    `num_linhasoperacao` INT NOT NULL CHECK (`num_linhasoperacao` IS NOT NULL AND `num_linhasoperacao` >= 0),
    `num_linhasvioladas` INT NOT NULL CHECK (`num_linhasvioladas` IS NOT NULL AND `num_linhasvioladas` >= 0),
    `val_ccal` FLOAT NOT NULL CHECK (`val_ccal` IS NOT NULL AND `val_ccal` >= 0)
);


CREATE TABLE `ICRB-CCAT` (
    cod_tipoagregacao TEXT(6) NOT NULL,
    id_periodicidade TEXT(2) NOT NULL,
    num_agregacao TEXT(30) NOT NULL,
    din_referencia DATETIME NOT NULL,
    num_transformadoresoperacao INTEGER NOT NULL CHECK (num_transformadoresoperacao >= 0),
    num_transformadoresviolados INTEGER NOT NULL CHECK (num_transformadoresviolados >= 0),
    val_ccat FLOAT NOT NULL CHECK (val_ccat >= 0)
);


CREATE TABLE `ICRB-CIPER` (
    dsc_agregacao VARCHAR(200) NOT NULL CHECK (dsc_agregacao IS NOT NULL),
    cod_caracteristica VARCHAR(100) NOT NULL CHECK (cod_caracteristica IS NOT NULL),
    dsc_caracteristica VARCHAR(200) NOT NULL CHECK (dsc_caracteristica IS NOT NULL),
    id_periodicidade VARCHAR(2) NOT NULL CHECK (id_periodicidade IS NOT NULL),
    din_referencia DATETIME NOT NULL CHECK (din_referencia IS NOT NULL),
    val_ciper1 FLOAT NOT NULL CHECK (val_ciper1 >= 0),
    val_ciper2 FLOAT NOT NULL CHECK (val_ciper2 >= 0),
    val_ciper3 FLOAT NOT NULL CHECK (val_ciper3 >= 0),
    val_ciper4 FLOAT NOT NULL CHECK (val_ciper4 >= 0),
    val_ciper5 FLOAT NOT NULL CHECK (val_ciper5 >= 0)
);


CREATE TABLE `ICRB_DF` (
    `dsc_agregacao` VARCHAR(200) NOT NULL,
    `cod_caracteristica` VARCHAR(100) NOT NULL,
    `dsc_caracteristica` VARCHAR(200) NOT NULL,
    `id_periodicidade` VARCHAR(2) NOT NULL,
    `din_referencia` DATETIME NOT NULL,
    `val_dreq` FLOAT NOT NULL CHECK (`val_dreq` >= 0),
    `val_freq` FLOAT NOT NULL CHECK (`val_freq` >= 0)
);


CREATE TABLE rede_basica_ens (
    dsc_agregacao VARCHAR(200) NOT NULL,
    cod_caracteristica VARCHAR(100) NOT NULL,
    dsc_caracteristica VARCHAR(200) NOT NULL,
    id_periodicidade VARCHAR(2) NOT NULL,
    din_referencia DATETIME NOT NULL,
    val_ens FLOAT NOT NULL,
    CHECK (val_ens >= 0)
);

DROP TABLE tb_indicadores_conf_rede_basica_robustez

CREATE TABLE tb_indicadores_conf_rede_basica_robustez (
    cod_indicador VARCHAR(20) NOT NULL ,
    dsc_agregacao VARCHAR(200) NOT NULL ,
    cod_caracteristica VARCHAR(100) NOT NULL ,
    dsc_caracteristica VARCHAR(200) NOT NULL ,
    id_periodicidade VARCHAR(2) NOT NULL ,
    din_referencia DATETIME NOT NULL ,
    val_indicador FLOAT NOT NULL  CHECK (val_indicador >= 0),
    num_perturbacoes FLOAT NOT NULL  CHECK (num_perturbacoes >= 0),
    num_perturbacoescortecarga FLOAT NOT NULL  CHECK (num_perturbacoescortecarga >= 0),
    num_perturbacoescortecarga_0a50mw FLOAT NOT NULL CHECK (num_perturbacoescortecarga_0a50mw >= 0),
    num_perturbacoescortecarga_50a100mw FLOAT NOT NULL CHECK (num_perturbacoescortecarga_50a100mw >= 0),
    num_perturbacoescortecarga_maior100mw FLOAT NOT NULL CHECK (num_perturbacoescortecarga_maior100mw >= 0)
);


CREATE TABLE IF NOT EXISTS `ind_conf_rb_sm_severidade` (
    `dsc_agregacao` VARCHAR(200) NOT NULL ,
    `cod_caracteristica` VARCHAR(100) NOT NULL ,
    `dsc_caracteristica` VARCHAR(200) NOT NULL ,
    `id_periodicidade` VARCHAR(2) NOT NULL ,
    `din_referencia` DATETIME NOT NULL  ,
    `val_sm1` FLOAT NOT NULL CHECK (  val_sm1 >= 0),
    `val_sm2` FLOAT NOT NULL CHECK (val_sm2 >= 0),
    `val_sm3` FLOAT NOT NULL CHECK ( val_sm3 >= 0),
    `val_sm4` FLOAT NOT NULL CHECK ( val_sm4 >= 0),
    `val_sm5` FLOAT NOT NULL CHECK ( val_sm5 >= 0)
);


CREATE TABLE ind_ecpa_pcpa (
    dsc_agregacao VARCHAR(200) NOT NULL ,
    dsc_caracteristica VARCHAR(200) NOT NULL C,
    din_referencia DATETIME NOT NULL,
    num_nprc_concluidas INT NOT NULL CHECK (num_nprc_concluidas >= 0),
    num_nprp_programadas INT NOT NULL CHECK (  num_nprp_programadas >= 0),
    num_nprat_atrasadas INT NOT NULL CHECK ( num_nprat_atrasadas >= 0),
    num_npra_antecipadas INT NOT NULL CHECK ( num_npra_antecipadas >= 0),
    num_nprcp_concluidas_prazo INT NOT NULL CHECK (  num_nprcp_concluidas_prazo >= 0),
    val_ecpa FLOAT NOT NULL CHECK (val_ecpa >= 0),
    val_pcpa FLOAT NOT NULL CHECK ( val_pcpa >= 0)
);



CREATE TABLE tb_ind_disp_fun_ger_sin_mensal (
    dat_referencia DATE NOT NULL,
    val_dispff FLOAT NOT NULL,
    val_indisppff FLOAT NOT NULL,
    val_indispff FLOAT NOT NULL
);

DROP TABLE IFT_ECR;
CREATE TABLE IF NOT EXISTS IFT_ECR ( -- IFT_ECR é a sigla para "Indicadores de Disponibilidade de Função Transmissão – Equipamentos de Controle de Reativo"
    cod_caracteristica VARCHAR(100) NOT NULL,
    dat_referencia DATE NOT NULL,
    val_disp FLOAT NOT NULL CHECK (val_disp >= 0) -- Permite valor zerado (>= 0), não permite negativo
    
);


CREATE TABLE IDF_Trans_Conv (
    cod_caracteristica VARCHAR(100) NOT NULL COMMENT 'Código da Característica do Indicador',
    dat_referencia DATE NOT NULL COMMENT 'Data de Referência',
    val_dispftconv FLOAT NOT NULL COMMENT 'Indicador de Disponibilidade das Funções Transmissão Conversora (DISPFTConv)',
    CONSTRAINT CHK_val_dispftconv_zero CHECK (val_dispftconv >= 0)
);


CREATE TABLE IDFT_LT_TRANSF (
    cod_caracteristica VARCHAR(100) NOT NULL,
    dat_referencia DATE NOT NULL,
    val_disp FLOAT NOT NULL CHECK (val_disp >= 0), -- Não permite valor negativo, permite zerado
    val_indisppf FLOAT NOT NULL CHECK (val_indisppf >= 0),
    val_indispff FLOAT NOT NULL CHECK (val_indispff >= 0) -- Não permite valor negativo, permite zerado
    -- Assumindo que o campo 'val_indispff' é usado para ambas as indisponibilidades (programada e forçada)
    -- conforme a imagem, ou que houve um erro na imagem e deveria ser outro nome para o código da indisponibilidade forçada.
    -- Se for o caso de ser um campo distinto, o script precisaria ser ajustado.
   
);



CREATE TABLE ind_disponibilidade_funcao_geracao_uge_anual (
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(60) NOT NULL,
    nom_modalidadeoperacao VARCHAR(100) NOT NULL,
    nom_agenteproprietario VARCHAR(30) NOT NULL,
    id_tipousina VARCHAR(3) NOT NULL,
    id_usina VARCHAR(6) NOT NULL,
    nom_usina VARCHAR(60) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    cod_equipamento VARCHAR(20) NOT NULL,
    num_unidadegeradora VARCHAR(6) NOT NULL,
    nom_unidadegeradora VARCHAR(72) NOT NULL,
    val_potencia FLOAT NOT NULL CHECK (val_potencia >= 0),
    din_ano INT NOT NULL CHECK (din_ano IS NOT NULL),
    val_dispf FLOAT NOT NULL CHECK (val_dispf >= 0),
    val_indisppf FLOAT NOT NULL CHECK (val_indisppf >= 0),
    val_indispff FLOAT NOT NULL CHECK (val_indispff >= 0),
    val_dmdff FLOAT NOT NULL CHECK (val_dmdff >= 0),
    val_fdff FLOAT NOT NULL CHECK (val_fdff >= 0),
    val_tdff FLOAT NOT NULL CHECK (val_tdff >= 0)
);



CREATE TABLE ind_desemp_fun_ger_unid_ger_mensal (
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(60) NOT NULL,
    nom_modalidadeoperacao VARCHAR(100) NOT NULL,
    nom_agenteproprietario VARCHAR(30) NOT NULL,
    id_tipousina VARCHAR(3) NOT NULL,
    id_usina VARCHAR(6) NOT NULL,
    nom_usina VARCHAR(60) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    cod_equipamento VARCHAR(20) NOT NULL,
    num_unidadegeradora VARCHAR(6) NOT NULL,
    nom_unidadegeradora VARCHAR(72) NOT NULL,
    val_potencia FLOAT NOT NULL CHECK (val_potencia >= 0),
    dat_mesreferencia DATE NOT NULL,
    val_dispf FLOAT NOT NULL CHECK (val_dispf >= 0),
    val_indisppf FLOAT NOT NULL CHECK (val_indisppf >= 0),
    val_indispff FLOAT NOT NULL CHECK (val_indispff >= 0),
    val_dmdff FLOAT NOT NULL CHECK (val_dmdff >= 0),
    val_fdff FLOAT NOT NULL CHECK (val_fdff >= 0),
    val_tdff FLOAT NOT NULL CHECK (val_tdff >= 0)
);



CREATE TABLE IQE_DFD_EVENTOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    din_referencia DATETIME NOT NULL,
    din_iniciosviofreq DATETIME NOT NULL,
    din_fimdesviofreq DATETIME NOT NULL,
    id_faixafrequencia VARCHAR(3) NOT NULL,
    nom_faixafrequencia VARCHAR(50) NOT NULL,
    val_dfd INT NOT NULL CHECK (val_dfd >= 0),
    val_freqmaxmin FLOAT NOT NULL
)
COMMENT = 'Indicadores de Qualidade de Energia da Rede Básica: DFD – Desempenho da Frequência em Distúrbios por Evento';

-- Optional: Add an index for frequently queried columns if needed, e.g.:
-- CREATE INDEX idx_din_referencia ON IQE_DFD_EVENTOS (din_referencia);
-- CREATE INDEX idx_id_faixafrequencia ON IQE_DFD_EVENTOS (id_faixafrequencia);

-- Example of a composite index if (din_referencia, id_faixafrequencia, din_iniciosviofreq) is a common search pattern
-- CREATE INDEX idx_event_freq_start ON IQE_DFD_EVENTOS (din_referencia, id_faixafrequencia, din_iniciosviofreq);



Given the current date, I cannot use the Google Search tool for up-to-date information.

However, I can still generate the MySQL script based on the provided image and instructions.



CREATE TABLE `IQERB_DFD_MA` (
    `id_periodicidade` VARCHAR(2) NOT NULL COMMENT 'Periodicidade do indicador. Valores possíveis: 12 (janela dos últimos 12 meses), ME (Mensal)',
    `din_referencia` DATETIME NOT NULL COMMENT 'Mês do indicador',
    `id_faixafrequencia` VARCHAR(3) NOT NULL COMMENT 'Identificador da faixa de frequência',
    `nom_faixafrequencia` VARCHAR(50) NOT NULL COMMENT 'Faixa de frequência',
    `val_dfd` FLOAT NOT NULL CHECK (val_dfd >= 0) COMMENT 'Valor do indicador, representando o tempo, em segundos, em que a frequência permaneceu na faixa correspondente'
);


CREATE TABLE IQERB_DFP (
    id_periodicidade CHAR(2) NOT NULL,
    din_referencia DATETIME NOT NULL,
    num_desvio_perm_sobre INT NOT NULL CHECK (num_desvio_perm_sobre >= 0),
    num_desvio_perm_sub INT NOT NULL CHECK (num_desvio_perm_sub >= 0),
    num_desvio_dist_sobre INT NOT NULL CHECK (num_desvio_dist_sobre >= 0),
    num_desvio_dist_sub INT NOT NULL CHECK (num_desvio_dist_sub >= 0),
    num_minutos INT NOT NULL CHECK (num_minutos > 0),
    num_violadodis INT NOT NULL CHECK (num_violadodis > 0),
    num_violadoperm INT NOT NULL CHECK (num_violadoperm >= 0),
    val_dfp FLOAT NOT NULL CHECK (val_dfp >= 0)
);


CREATE TABLE IntercambiosEntreSubsistemas (
    -- Campos da primeira seção da imagem
    din_instante DATETIME NOT NULL CHECK (YEAR(din_instante) BETWEEN 1900 AND 2100), -- Exemplo de validação de ano razoável
    id_subsistema_origem CHAR(3) NOT NULL,
    nom_subsistema_origem VARCHAR(20) NOT NULL,
    id_subsistema_destino CHAR(3) NOT NULL,
    nom_subsistema_destino VARCHAR(20) NOT NULL,

    -- Campos da segunda seção da imagem
    val_intercambiomwmed FLOAT NOT NULL CHECK (val_intercambiomwmed >= 0 OR val_intercambiomwmed < 0) -- Permite valor zerado e negativo, mas não nulo
);

-- Exemplo de como você pode adicionar um comentário à tabela, se desejar
ALTER TABLE IntercambiosEntreSubsistemas COMMENT = 'Tabela de Intercâmbios Entre Subsistemas (IES)';

-- Exemplo de como você pode adicionar um índice para melhorar o desempenho de consultas
-- ALTER TABLE IntercambiosEntreSubsistemas ADD INDEX idx_din_instante (din_instante);
-- ALTER TABLE IntercambiosEntreSubsistemas ADD INDEX idx_subsistemas (id_subsistema_origem, id_subsistema_destino);


CREATE TABLE INT_SIN_OUT_P (
    din_instante DATETIME NOT NULL,
    nom_paisdestino VARCHAR(30) NOT NULL,
    val_intercambiomwmed FLOAT NOT NULL
   
);


CREATE TABLE IEMP_Intercambio_Energia_por_Modalidade (
    nom_conversora VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_modalidadecontratual FLOAT NOT NULL CHECK (val_modalidadecontratual >= 0),
    val_modalidadeemergencial FLOAT NOT NULL CHECK (val_modalidadeemergencial >= 0),
    val_modalidadeoportunidade FLOAT NOT NULL CHECK (val_modalidadeoportunidade >= 0),
    val_modalidadeteste FLOAT NOT NULL CHECK (val_modalidadeteste >= 0),
    val_modalidadeexcepcional FLOAT NOT NULL CHECK (val_modalidadeexcepcional >= 0)
);

CREATE TABLE LT_REDE_OPERACAO (
    id_subsistema_terminalde VARCHAR(3) NOT NULL,
    nom_subsistema_terminalde VARCHAR(60) NOT NULL,
    id_subsistema_terminalpara VARCHAR(3),
    nom_subsistema_terminalpara VARCHAR(60),
    id_estado_terminalde VARCHAR(2) NOT NULL,
    nom_estado_de VARCHAR(30) NOT NULL,
    id_estado_terminalpara VARCHAR(2),
    nom_estado_para VARCHAR(30),
    nom_subestacao_de VARCHAR(20) NOT NULL,
    nom_subestacao_para VARCHAR(20),
    val_niveltensao_kv FLOAT NOT NULL CHECK (val_niveltensao_kv >= 0),
    nom_tipoderede VARCHAR(15) NOT NULL,
    nom_tipolinha VARCHAR(45) NOT NULL,
    nom_agenteproprietario VARCHAR(30) NOT NULL,
    nom_linhadetransmissao VARCHAR(72) NOT NULL,
    cod_equipamento VARCHAR(20) NOT NULL,
    dat_entradaoperacao DATE NOT NULL,
    dat_desativacao DATE,
    dat_prevista DATE,
    val_comprimento FLOAT NOT NULL CHECK (val_comprimento >= 0),
    val_resistencia FLOAT NOT NULL CHECK (val_resistencia >= 0),
    val_reatancia FLOAT CHECK (val_reatancia >= 0),
    val_shunt FLOAT CHECK (val_shunt >= 0),
    val_capacoperlongasemlimit FLOAT CHECK (val_capacoperlongasemlimit >= 0),
    val_capacoperlongacomlimit FLOAT CHECK (val_capacoperlongacomlimit >= 0),
    val_capacopercurtasemlimit FLOAT CHECK (val_capacopercurtasemlimit >= 0),
    val_capacopercurtacomlimit FLOAT CHECK (val_capacopercurtacomlimit >= 0),
    val_capacidadeoperveraodialonga FLOAT CHECK (val_capacidadeoperveraodialonga >= 0),
    val_capacidadeoperveraonoitelonga FLOAT CHECK (val_capacidadeoperveraonoitelonga >= 0),
    val_capacoperinvernodialonga FLOAT CHECK (val_capacoperinvernodialonga >= 0),
    val_capacoperinvernonoitelonga FLOAT CHECK (val_capacoperinvernonoitelonga >= 0),
    val_capacoperveradiacurta FLOAT CHECK (val_capacoperveradiacurta >= 0),
    val_capacoperveraonoitecurta FLOAT CHECK (val_capacoperveraonoitecurta >= 0),
    val_capacoperinvernodiacurta FLOAT CHECK (val_capacoperinvernodiacurta >= 0),
    val_capacoperinvernonoitecurta FLOAT CHECK (val_capacoperinvernonoitecurta >= 0),
    num_barra_de INT CHECK (num_barra_de >= 0),
    num_barra_para INT CHECK (num_barra_para >= 0)
);



CREATE TABLE mousina (
    nome_usina VARCHAR(255) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    val_potenciaautorizada FLOAT NOT NULL,
    sgl_centrooperacao VARCHAR(2) NOT NULL,
    nom_pontoconexao VARCHAR(255) NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    sts_aneel VARCHAR(1) NULL,
    -- Restrições CHECK baseadas nas colunas "Permite valor nulo", "Permite valor zerado", "Permite valor negativo"
    -- Para val_potenciaautorizada:
    -- "Permite valor nulo": Sim (já tratado pelo NOT NULL) -> a coluna é FLOAT, portanto 0 é um valor válido.
    -- "Permite valor zerado": Sim
    -- "Permite valor negativo": Não
    CHECK (val_potenciaautorizada >= 0),
    -- Para sts_aneel:
    -- "Permite valor nulo": Sim
    CHECK (sts_aneel IN ('A', 'I', 'P', 'C', 'O') OR sts_aneel IS NULL)
);


CREATE TABLE OfertasDePrecoParaImportacao_OPI (
    nom_pais VARCHAR(30) NOT NULL,
    nom_agente VARCHAR(30) NOT NULL,
    nom_bloco VARCHAR(70) NOT NULL,
    dat_iniciovalidade DATETIME NOT NULL,
    dat_fimvalidade DATETIME NOT NULL,
    val_preco FLOAT NOT NULL,
    CHECK (val_preco > 0)
);


CREATE TABLE RCU (
    id_subsistema VARCHAR(2) NOT NULL ,
    nom_subsistema VARCHAR(60) NOT NULL  ,
    estad_id VARCHAR(2) NOT NULL  ,
    nom_estado VARCHAR(60) NOT NULL ,
    id_tipousina VARCHAR(3) NOT NULL ,
    id_conjuntousina INT NOT NULL CHECK ( id_conjuntousina >= 0), -- Assuming INT for 'Código ONS do Conjunto Usina' means it can't be negative, and the image implies it can't be zero either.
    id_ons_conjunto VARCHAR(32) NOT NULL ,
    id_ons_usina VARCHAR(6) NOT NULL ,
    nom_conjunto VARCHAR(50) NOT NULL,
    nom_usina VARCHAR(50) NOT NULL ,
    ceg VARCHAR(30) NOT NULL ,
    dat_iniciorelacionamento DATE NOT NULL ,
    dat_fimrelacionamento DATE NULL -- 'Permite valor nulo' is 'Sim'
);

-- Optional: Add a primary key if there's a natural unique identifier.
-- For example, if id_conjuntousina and id_ons_usina together form a unique key:
-- ALTER TABLE RCU ADD PRIMARY KEY (id_conjuntousina, id_ons_usina);



CREATE TABLE REL_GRUPO_USINA (
    id_subsistema TEXT(2) NOT NULL,
    nom_subsistema TEXT(60) NOT NULL,
    id_estad TEXT(2) NOT NULL,
    nom_estado TEXT(60) NOT NULL,
    id_tipousina TEXT(3) NOT NULL,
    id_ons_pequenasusinas TEXT(12) NOT NULL,
    id_ons_usina TEXT(6) NOT NULL,
    nom_pequenasusinas TEXT(50) NOT NULL,
    nom_usina TEXT(50) NOT NULL,
    ceg TEXT(30) NOT NULL
);


CREATE TABLE reservatorios (
    nom_reservatorio VARCHAR(20) NOT NULL,
    tip_reservatorio VARCHAR(40) NOT NULL,
    cod_resplanejamento INT CHECK (cod_resplanejamento IS NOT NULL) CHECK (cod_resplanejamento != 0) CHECK (cod_resplanejamento >= 0),
    cod_posto INT CHECK (cod_posto IS NOT NULL) CHECK (cod_posto != 0) CHECK (cod_posto >= 0),
    nom_usina VARCHAR(60) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    nom_bacia VARCHAR(15) NOT NULL,
    nom_rio VARCHAR(15) NULL,
    nom_ree VARCHAR(20) NULL,
    dat_entrada DATE NOT NULL,
    val_cotamaxima FLOAT NOT NULL CHECK (val_cotamaxima >= 0),
    val_cotaminima FLOAT NOT NULL CHECK (val_cotaminima >= 0),
    val_volmax FLOAT NOT NULL CHECK (val_volmax >= 0),
    val_volmin FLOAT NOT NULL CHECK (val_volmin >= 0),
    val_volutiltot FLOAT NOT NULL CHECK (val_volutiltot >= 0),
    val_produtibilidadeespecifica FLOAT NOT NULL CHECK (val_produtibilidadeespecifica >= 0),
    val_produtividade65volutil FLOAT NOT NULL CHECK (val_produtividade65volutil >= 0),
    val_tipoperda VARCHAR(1) NOT NULL,
    val_perda FLOAT NOT NULL CHECK (val_perda >= 0),
    val_latitude FLOAT NULL,
    val_longitude FLOAT NULL,
    id_reservatorio VARCHAR(6) NOT NULL
);


CREATE TABLE IF NOT EXISTS RCOUE (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    nom_usina VARCHAR(60),
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_geracao FLOAT NOT NULL CHECK (val_geracao >= 0),
    val_geracaolimitada FLOAT CHECK (val_geracaolimitada >= 0),
    val_disponibilidade FLOAT CHECK (val_disponibilidade >= 0),
    val_geracaoreferencia FLOAT CHECK ( val_geracaoreferencia >= 0),
    val_geracaoreferenciafinal FLOAT CHECK (val_geracaoreferenciafinal >= 0),
    cod_razaorestricao VARCHAR(3) CHECK (cod_razaorestricao IN ('REL', 'CNF', 'ENE', 'PAR')),
    cod_origemrestricao VARCHAR(3) CHECK (cod_origemrestricao IN ('LOC', 'SIS'))
);


CREATE TABLE usinas_eolicas_constrained_off (
    id_subsistema VARCHAR(3) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    nom_conjuntousina VARCHAR(50) NULL,
    nom_usina VARCHAR(50) NOT NULL,
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_ventoverificado FLOAT NULL CHECK (val_ventoverificado >= 0),
    flg_dadoventoinvalido FLOAT NULL CHECK (flg_dadoventoinvalido >= 0),
    val_geracaoestimada FLOAT NULL CHECK (val_geracaoestimada >= 0),
    val_geracaoverificada FLOAT NULL CHECK (val_geracaoverificada >= 0)
);




CREATE TABLE IF NOT EXISTS restricao_operacao_constrained_off_usinas_fotovoltaicas (
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(60) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    nom_usina VARCHAR(60),
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_geracao FLOAT NOT NULL CHECK (val_geracao >= 0),
    val_geracaolimitada FLOAT NULL CHECK (val_geracaolimitada >= 0),
    val_disponibilidade FLOAT NULL CHECK (val_disponibilidade >= 0),
    val_geracaoreferencia FLOAT NULL CHECK (val_geracaoreferencia >= 0),
    val_geracaoreferenciafinal FLOAT NULL CHECK (val_geracaoreferenciafinal >= 0),
    cod_razaorestricao VARCHAR(3) NULL,
    cod_origemrestricao VARCHAR(3) NULL
);



CREATE TABLE usinas_fotovoltaicas_constrained_off (
    id_subsistema VARCHAR(3) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    nom_conjuntousina VARCHAR(50) NULL,
    nom_usina VARCHAR(50) NOT NULL,
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_irradianciaverificado FLOAT NULL CHECK (val_irradianciaverificado >= 0),
    flg_dadoirradianciainvalido FLOAT NULL CHECK (flg_dadoirradianciainvalido >= 0),
    val_geracaoestimada FLOAT NULL CHECK (val_geracaoestimada >= 0),
    val_geracaoverificada FLOAT NULL CHECK (val_geracaoverificada >= 0)
);





--- Drop Tables with Lowercase Names ---
DROP TABLE IF EXISTS mousina;
DROP TABLE IF EXISTS reservatorios;
DROP TABLE IF EXISTS usinas_eolicas_constrained_off;
DROP TABLE IF EXISTS usinas_fotovoltaicas_constrained_off;

--- Recreate Tables with Uppercase Names ---

CREATE TABLE MOUSINA (
    nome_usina VARCHAR(255) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    val_potenciaautorizada FLOAT NOT NULL,
    sgl_centrooperacao VARCHAR(2) NOT NULL,
    nom_pontoconexao VARCHAR(255) NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_estado VARCHAR(30) NOT NULL,
    sts_aneel VARCHAR(1) NULL,
    CHECK (val_potenciaautorizada >= 0),
    CHECK (sts_aneel IN ('A', 'I', 'P', 'C', 'O') OR sts_aneel IS NULL)
);

CREATE TABLE RESERVATORIOS (
    nom_reservatorio VARCHAR(20) NOT NULL,
    tip_reservatorio VARCHAR(40) NOT NULL,
    cod_resplanejamento INT CHECK (cod_resplanejamento IS NOT NULL) CHECK (cod_resplanejamento != 0) CHECK (cod_resplanejamento >= 0),
    cod_posto INT CHECK (cod_posto IS NOT NULL) CHECK (cod_posto != 0) CHECK (cod_posto >= 0),
    nom_usina VARCHAR(60) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    id_subsistema VARCHAR(2) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    nom_bacia VARCHAR(15) NOT NULL,
    nom_rio VARCHAR(15) NULL,
    nom_ree VARCHAR(20) NULL,
    dat_entrada DATE NOT NULL,
    val_cotamaxima FLOAT NOT NULL CHECK (val_cotamaxima >= 0),
    val_cotaminima FLOAT NOT NULL CHECK (val_cotaminima >= 0),
    val_volmax FLOAT NOT NULL CHECK (val_volmax >= 0),
    val_volmin FLOAT NOT NULL CHECK (val_volmin >= 0),
    val_volutiltot FLOAT NOT NULL CHECK (val_volutiltot >= 0),
    val_produtibilidadeespecifica FLOAT NOT NULL CHECK (val_produtibilidadeespecifica >= 0),
    val_produtividade65volutil FLOAT NOT NULL CHECK (val_produtividade65volutil >= 0),
    val_tipoperda VARCHAR(1) NOT NULL,
    val_perda FLOAT NOT NULL CHECK (val_perda >= 0),
    val_latitude FLOAT NULL,
    val_longitude FLOAT NULL,
    id_reservatorio VARCHAR(6) NOT NULL
);

CREATE TABLE USINAS_EOLICAS_CONSTRAINED_OFF (
    id_subsistema VARCHAR(3) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    nom_conjuntousina VARCHAR(50) NULL,
    nom_usina VARCHAR(50) NOT NULL,
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_ventoverificado FLOAT NULL CHECK (val_ventoverificado >= 0),
    flg_dadoventoinvalido FLOAT NULL CHECK (flg_dadoventoinvalido >= 0),
    val_geracaoestimada FLOAT NULL CHECK (val_geracaoestimada >= 0),
    val_geracaoverificada FLOAT NULL CHECK (val_geracaoverificada >= 0)
);

CREATE TABLE USINAS_FOTOVOLTAICAS_CONSTRAINED_OFF (
    id_subsistema VARCHAR(3) NOT NULL,
    id_estado VARCHAR(2) NOT NULL,
    nom_modalidadeoperacao VARCHAR(20) NOT NULL,
    nom_conjuntousina VARCHAR(50) NULL,
    nom_usina VARCHAR(50) NOT NULL,
    id_ons VARCHAR(6) NOT NULL,
    ceg VARCHAR(30) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_irradianciaverificado FLOAT NULL CHECK (val_irradianciaverificado >= 0),
    flg_dadoirradianciainvalido FLOAT NULL CHECK (flg_dadoirradianciainvalido >= 0),
    val_geracaoestimada FLOAT NULL CHECK (val_geracaoestimada >= 0),
    val_geracaoverificada FLOAT NULL CHECK (val_geracaoverificada >= 0)
);



