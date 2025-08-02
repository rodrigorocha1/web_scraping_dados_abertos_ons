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


CREATE TABLE `param_id_max` (
  `NOME_TABELA` varchar(400) DEFAULT NULL,
  `id_max` int DEFAULT NULL,
  `flag_url_sem_data` tinyint(1) DEFAULT NULL,
  `data_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE `logs` (
  `timestamp` datetime NOT NULL,
  `level` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `logger_name` varchar(100) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `func_name` varchar(100) NOT NULL,
  `line_no` int NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `mensagem_de_excecao_tecnica` text,
  `requisicao` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `status_code` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;