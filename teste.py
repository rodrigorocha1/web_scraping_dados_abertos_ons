import polars as pl

# Lendo o arquivo CSV com Polars
df = pl.read_csv(
    'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/balanco_energia_subsistema_ho/BALANCO_ENERGIA_SUBSISTEMA_2000.csv',
    separator=';'
)
print(df)
print(df.dtypes)
df = df.to_pandas()
print(df.info())