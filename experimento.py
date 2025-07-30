import polars as pl

# URL do arquivo CSV


url = 'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/hist_despacho_energia/info2024.csv'
df = pl.read_csv(url).filter(pl.col("val_demanda") > 10000)

# Converte para lista de tuplas (valores linha a linha)
data_tuples = [tuple(row) for row in df.to_numpy()]
