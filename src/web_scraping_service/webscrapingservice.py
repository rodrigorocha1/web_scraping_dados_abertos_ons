from typing import Generator, Union, Tuple
import bs4
import re
import requests
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService


class WebScrapingService(IWebScrapingService[bs4.BeautifulSoup]):
    def __init__(self, url: str):
        self.__url = url
        self.__soup = self.conectar_url()

    @property
    def url(self) -> str:
        return self.__url

    @url.setter
    def url(self, url: str):
        self.__url = url

    def conectar_url(self) -> Tuple[bool, Union[bs4.BeautifulSoup, str]]:
        try:
            response = requests.get(self.__url)
            html = response.text
            soup = bs4.BeautifulSoup(html, 'html.parser')
            return True, soup
        except Exception as e:
            return False, 'Erro'

    def obter_lista_sites(self, dados_site: bs4.BeautifulSoup) -> Generator[str, None, None]:
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
            print(len(lista_sites))

            yield from lista_sites

    def


if __name__ == '__main__':
    from datetime import datetime

    wss = WebScrapingService(
        url='https://dados.ons.org.br/dataset/balanco-energia-dessem'
    )

    ano = datetime.now().year
    mes = datetime.now().month
    print(ano, mes)

    flag, soup = wss.conectar_url()

    lista_sites = soup.find_all(
        'a',
        class_='resource-url-analytics',

    )
    lista_sites = [
        site['href']
        for site in lista_sites
        if site['href'].endswith('csv')
    ]
    print(lista_sites)
    print(len(lista_sites))
