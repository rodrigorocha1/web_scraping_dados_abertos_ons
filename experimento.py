import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Geração de datas sequenciais fictícias
datas = [datetime(2025, 5, 1) + timedelta(days=i) for i in range(15)]

# Valores fictícios
df = pd.DataFrame({
    'din_programacaodia': datas,
    'num_patamar': np.random.randint(1, 4, size=15),
    'cod_subsistema': np.random.choice(['SE', 'NE', 'S ', 'N '], size=15),  # 2 posições
    'val_demanda': np.round(np.random.uniform(10000, 30000, size=15), 2),
    'val_geracao_renovavel': np.round(np.random.uniform(1000, 5000, size=15), 2),
    'val_geracao_hidraulica': np.round(np.random.uniform(5000, 20000, size=15), 2),
    'val_geracao_termica': np.round(np.random.uniform(2000, 8000, size=15), 2),
    'val_cons_elevatoria': np.round(np.random.uniform(100, 500, size=15), 2),
})


colunas = ['id_param'] + list(df.columns)
placeholders = ', '.join(['%s'] * len(colunas))


sql = f"""
    INSERT INTO tabela ({colunas})
    values({placeholders})
"""
print(sql)

valores = list(df.itertuples(index=True, name=None))
print(valores)
