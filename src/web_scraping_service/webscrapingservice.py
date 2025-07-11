from typing import Generator, Union, Tuple, List
import bs4
import re
import requests
from datetime import datetime
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService


class WebScrapingService(IWebScrapingService[bs4.BeautifulSoup]):
    def __init__(self, url: str):
        self.__url = url
        self.__soup = self.conectar_url()
        self.__data = datetime.now()

    @property
    def url(self) -> str:
        return self.__url

    @url.setter
    def url(self, url: str):
        self.__url = url

    def conectar_url(self) -> Tuple[bool, Union[bs4.BeautifulSoup, str]]:
        """
            Método para conectar na url
            :return: Retorna uma flag indicando sucesso ou falha e a conexão Beautifull soup junto com alguma mensagem
            :rtype: Tuple[bool, Union[bs4.BeautifulSoup, str]]
        """
        try:
            response = requests.get(self.__url)
            html = response.text
            soup = bs4.BeautifulSoup(html, 'html.parser')
            return True, soup
        except Exception as e:
            return False, 'Erro'

    def obter_lista_sites(self, dados_site: bs4.BeautifulSoup) -> Generator[str, None, None]:
        """
            Obtem a lista de sites
        :param dados_site: a conexão obtida usando beautifull soup
        :type dados_site: bs4.BeautifulSoup
        :return: Um generator com as urls
        :rtype: Generator[str, None, None]
        """

        if isinstance(dados_site, bs4.BeautifulSoup):
            sites = dados_site.find_all('li')

            lista_sites = [
                link['href']
                for site in sites
                if isinstance(site, bs4.Tag)
                   and (link := site.find("a"))
                   and isinstance(link, bs4.Tag)
                   and 'href' in link.attrs
                   and isinstance(link['href'], str)
                   and link['href'].startswith('https://')
            ]

            yield from lista_sites

    def __e_link_valido(self, url: str) -> bool:

        ano = str(self.__data.year)
        mes = str(self.__data.month).zfill(2)
        dia = str(self.__data.day).zfill(2)


        padroes_data_atual = [
            rf'{ano}[-_]{mes}[-_]{dia}(?!\d)',  # ano-mês-dia
            rf'{ano}[-_]{mes}(?![-_]\d)',  # ano-mês
            rf'{ano}(?![-_]\d)'  # apenas ano
        ]

        padrao_qualquer_data = r'\d{4}([-_])\d{2}([-_])\d{2}|\d{4}([-_])\d{2}|\d{4}'

        contem_data_atual = any(re.search(padrao, url) for padrao in padroes_data_atual)
        contem_qualquer_data = re.search(padrao_qualquer_data, url) is not None

        return contem_data_atual or not contem_qualquer_data

    def obter_links_csv(
            self,
            dados_site: bs4.BeautifulSoup,
            flag_carga_completa: bool = True) \
            -> Generator[str, None, None]:

        """
            Método para obter os links de conexão em csv
            :param dados_site: dados da conexão Beautiful soup
            :type dados_site: bs4.BeautifulSoup
            :param flag_carga_completa: Flag para indicar carga completa True para carga completa e falso para alterados
            :type flag_carga_completa: bool
            :return: Um generator com os links csv
            :rtype: Generator[str, None, None]
        """

        for link in dados_site.find_all('a', class_='resource-url-analytics'):
            href = link.get('href', '')
            if href.endswith('.csv') and (flag_carga_completa or self.__e_link_valido(href)):
                # yield href
                print('Href')
                print(f'Resultado {href}')

# if __name__ == '__main__':
#     lista_urls = [
#         'https://dados.ons.org.br/dataset/balanco-energia-subsistema',
#         'https://dados.ons.org.br/dataset/disponibilidade_usina',
#         'https://dados.ons.org.br/dataset/geracao-usina-2',
#         'https://dados.ons.org.br/dataset/programacao_diaria',
#         'https://dados.ons.org.br/dataset/ind_confiarb_ccal'
#     ]
#     for url in lista_urls:
#         print('*' * 10)
#         print(url)
#         wss = WebScrapingService(
#             url=url
#         )
#
#         flag, soup = wss.conectar_url()
#
#         for link_csv in wss.obter_links_csv(dados_site=soup, flag_carga_completa=False):
#             print(link_csv)
