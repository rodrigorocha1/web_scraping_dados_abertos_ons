from typing import Generator

import bs4
import requests
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService, T


class WebScrapingService(IWebScrapingService[bs4.BeautifulSoup]):
    def __init__(self, url: str):
        self.__url = url
        self.__soup = self.conectar_url()

    def conectar_url(self) -> bs4.BeautifulSoup:
        response = requests.get(self.__url)
        html = response.text
        soup = bs4.BeautifulSoup(html, 'html.parser')
        return soup

    def obter_lista_sites(self) -> Generator[str, None, None]:
        sites = self.__soup.find_all('li')

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

