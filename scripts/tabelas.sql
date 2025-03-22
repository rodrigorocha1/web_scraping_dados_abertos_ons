CREATE TABLE BALANCO_ENERGIA_SUBSISTEMA(
    id_subsistema VARCHAR(3) NOT NULL,
    nom_subsistema VARCHAR(20) NOT NULL,
    din_instante DATETIME NOT NULL,
    val_gerhidraulica FLOAT CHECK (val_gerhidraulica >= 0),
    val_gertermica FLOAT CHECK (val_gertermica >= 0),
    val_gereolica FLOAT CHECK (val_gereolica >= 0),
    val_gersolar FLOAT NOT NULL CHECK (val_gersolar >= 0),
    val_carga FLOAT NOT NULL CHECK (val_carga >= 0),
    val_intercambio FLOAT NOT NULL
)



CREATE TABLE cdc_tabela(
    ano INT NOT NULL,
    mes INT NOT NULL
)