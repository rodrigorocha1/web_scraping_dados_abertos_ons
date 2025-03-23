import re

def verifica_url(url):
    padrao_mes = r"_\d{4}_\d{2}\."  # Verifica se tem ano e mês
    padrao_ano = r"_\d{4}\."        # Verifica se tem apenas o ano

    if re.search(padrao_mes, url):
        return True  # Contém ano e mês
    elif re.search(padrao_ano, url):
        return False  # Contém apenas o ano
    return None  # Caso inesperado

# Testando
url1 = "https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/disponibilidade_usina_ho/DISPONIBILIDADE_USINA_2025_01.csv"
url2 = "https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/disponibilidade_usina_ho/DISPONIBILIDADE_USINA_2025.csv"

print(verifica_url(url1))  # True (ano e mês)
print(verifica_url(url2))  # False (apenas ano)
