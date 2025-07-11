import re
from datetime import datetime

class ValidadorURL:
    def __init__(self, data: datetime):
        self.__data = data

    def e_link_valido(self, url: str) -> bool:
        ano = str(self.__data.year)
        mes = str(self.__data.month).zfill(2)
        dia = str(self.__data.day).zfill(2)

        print(f"Data atual: ano={ano}, mes={mes}, dia={dia}")
        print(f"URL recebida: {url}")

        padroes_data_atual = [
            rf'{ano}[-_]{mes}[-_]{dia}(?!\d)',  # ano-mês-dia
            rf'{ano}[-_]{mes}(?![-_]\d)',       # ano-mês
            rf'{ano}(?![-_]\d)'                 # apenas ano
        ]

        padrao_qualquer_data = r'\d{4}([-_])\d{2}([-_])\d{2}|\d{4}([-_])\d{2}|\d{4}'

        print("\nVerificando se URL contém data atual:")
        for i, padrao in enumerate(padroes_data_atual, 1):
            match = re.search(padrao, url)
            print(f"  Padrão {i}: '{padrao}' -> {'Encontrado' if match else 'Não encontrado'}")

        contem_data_atual = any(re.search(padrao, url) for padrao in padroes_data_atual)
        print(f"URL contém data atual? {contem_data_atual}")

        contem_qualquer_data = re.search(padrao_qualquer_data, url) is not None
        print(f"URL contém alguma data (qualquer)? {contem_qualquer_data}")

        resultado = contem_data_atual or not contem_qualquer_data
        print(f"Resultado final da validação: {resultado}\n")

        return resultado


if __name__ == "__main__":
    # Defina a data atual para teste
    data_atual = datetime(2024, 7, 11)
    validador = ValidadorURL(data_atual)

    # Teste URLs variadas
    urls = [
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/ind_qualid_dfd_evento/IND_QUALID_DFD_EVENTO.csv',
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/carga/arquivo-2024.csv',
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/carga/arquivo-2024-07.csv',
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/carga/arquivo-2024-07-11.csv',
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/carga/arquivo-2023-05-01.csv',
        'https://ons-aws-prod-opendata.s3.amazonaws.com/dataset/carga/arquivo-2023.csv',
    ]

    for url in urls:
        print("========================================")
        valido = validador.e_link_valido(url)
        print(f"URL: {url}\nÉ válida? {valido}\n")
