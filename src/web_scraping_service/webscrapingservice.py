from typing import Generator, Union, Tuple, List
import bs4
import re
import requests
from datetime import datetime
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService


class WebScrapingService(IWebScrapingService[bs4.BeautifulSoup]):

    def __init__(self, url: str):
        self.__url = url

        self.__data = datetime.now()

    @property
    def url(self) -> str:
        """

        :return:
        :rtype:
        """
        return self.__url

    @url.setter
    def url(self, url: str):
        """

        :param url:
        :type url:
        :return:
        :rtype:
        """
        self.__url = url

    def conectar_url(self) -> Tuple[bool, Union[bs4.BeautifulSoup, str]]:
        """

        :return:
        :rtype:
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

        :param dados_site:
        :type dados_site:
        :return:
        :rtype:
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
        """

        :param url:
        :type url:
        :return:
        :rtype:
        """

        ano = str(self.__data.year)
        mes = str(self.__data.month).zfill(2)
        dia = str(self.__data.day).zfill(2)

        padroes_data_atual = [
            rf'{ano}[-_]{mes}[-_]{dia}(?!\d)',  # ano-mês-dia
            rf'{ano}[-_]{mes}(?![-_]\d)',  # ano-mês
            rf'{ano}(?![-_]\d)'  # apenas ano
        ]

        padrao_qualquer_data = r'\d{4}([-_])\d{2}([-_])\d{2}|\d{4}([-_])\d{2}|\d{4}'

        contem_data_atual = any(re.search(padrao, url)
                                for padrao in padroes_data_atual)
        contem_qualquer_data = re.search(padrao_qualquer_data, url) is not None

        return contem_data_atual or not contem_qualquer_data

    def obter_links_csv(
            self,
            dados_site: bs4.BeautifulSoup,
            flag_carga_completa: bool = True) \
            -> List[str]:
        """

        :param dados_site:
        :type dados_site:
        :param flag_carga_completa:
        :type flag_carga_completa:
        :return:
        :rtype:
        """

        lista_url = []

        for link in dados_site.find_all('a', class_='resource-url-analytics'):
            if isinstance(link, bs4.Tag):
                href = link.get('href', '')
                if isinstance(href, str) and href.endswith('.csv'):
                    if flag_carga_completa or self.__e_link_valido(href):
                        lista_url.append(href)

        return sorted([url for url in set(lista_url) if isinstance(url, str)])


if __name__ == '__main__':
    lista_urls = [
        'https://dados.ons.org.br/dataset/balanco-energia-subsistema',
        'https://dados.ons.org.br/dataset/disponibilidade_usina',
        'https://dados.ons.org.br/dataset/geracao-usina-2',
        'https://dados.ons.org.br/dataset/programacao_diaria',
        'https://dados.ons.org.br/dataset/ind_confiarb_ccal'
    ]
    for url in lista_urls:
        print('*' * 10)
        print(url)
        wss = WebScrapingService(
            url=url
        )

        flag, soup = wss.conectar_url()

        for link_csv in wss.obter_links_csv(dados_site=soup, flag_carga_completa=False):
            print(link_csv)
