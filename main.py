import mysql.connector

from src.config.config import Config

# Configurações de conexão - altere conforme seu ambiente
config = {
    'user': Config.USERSQL,
    'password': Config.PASSWORD,
    'host': Config.SERVER,
    'database': Config.DATABASE,
}

def salvar_ddl_tabelas():
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    # 1. Pegar nomes das tabelas
    cursor.execute("""
        SELECT TABLE_NAME
        FROM information_schema.TABLES
        WHERE TABLE_SCHEMA = %s
    """, (config['database'],))

    tabelas = [row[0] for row in cursor.fetchall()]

    with open('scripts/create_tables.sql', 'w', encoding='utf-8') as f:
        for tabela in tabelas:
            # 2. Pegar o DDL da tabela
            cursor.execute(f"SHOW CREATE TABLE `{tabela}`")
            result = cursor.fetchone()
            ddl = result[1]  # O segundo campo é o script CREATE TABLE

            f.write(f"-- Script para a tabela {tabela}\n")
            f.write(ddl)
            f.write(";\n\n")

    cursor.close()
    conn.close()

if __name__ == '__main__':
    salvar_ddl_tabelas()
