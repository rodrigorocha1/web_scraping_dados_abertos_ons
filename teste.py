import pandas as pd

# Lendo o arquivo CSV com Polars
df = pd.read_csv(
    'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/balanco_energia_subsistema_ho/BALANCO_ENERGIA_SUBSISTEMA_2025.csv',
    sep=';'
)
print(df.columns)
print(df['din_instante'].max())
print(df.head())



