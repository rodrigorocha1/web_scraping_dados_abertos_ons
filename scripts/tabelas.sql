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
);

DROP TABLE cdc_tabela;


CREATE TABLE cdc_tabela(
    ENTIDADE VARCHAR(30),
    ULTIMA_DATA DATETIME NOT NULL
);

INSERT INTO cdc_tabela
VALUES ( 'Balanco_de_Energia_Subsistema', GETDATE()),
( 'Capacidade_Geracao', GETDATE()),
( 'capacidade_transformacao', GETDATE());
    
SELECT *
FROM cdc_tabela;

