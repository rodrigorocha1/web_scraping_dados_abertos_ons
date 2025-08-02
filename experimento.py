import mysql.connector
from src.config.config import Config
from datetime import datetime, timedelta

# Conexão com o banco
conn = mysql.connector.connect(
    host=Config.SERVER,
    user=Config.USERSQL,
    password=Config.PASSWORD,
    database=Config.DATABASE
)

cursor = conn.cursor()

# Executando a consulta
cursor.execute("select * FROm param_id_max pim  where pim.NOME_TABELA  = %s", ("balanco_dessem_detalhe",))

# Pegando uma única linha
resultado = cursor.fetchone()

data_atual = datetime.now().date()

_, _, _, data_banco = resultado
print(type(data_banco))
data_banco: datetime.date = data_banco.date()
print(type(data_banco))
data_banco = data_banco - timedelta(days=1)
print(data_atual)
print(data_banco)

if data_banco == data_atual:
    print(True)
else:
    print(False)

print(resultado)

# Fechando a conexão
cursor.close()
conn.close()