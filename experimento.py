import pandas as pd
import polars as pl

# URL do arquivo CSV


df = pd.DataFrame({
    'Nome': ['Alice', 'Bob', 'Charlie', 'David'],
    'Idade': [25, 30, 35, 40],
    'Cidade': ['Nova Iorque', 'Londres', 'Paris', 'Tóquio']
})

print(df.head())
print()
print(df.index.max())
f_reset = df.reset_index()
df = f_reset.rename(
    columns={ # Corrected 'colunms' to 'columns'
        'index': 'id_param'
    }
)
print(df)
print()
print(df['id_param'].max()) # Accessing the renamed column