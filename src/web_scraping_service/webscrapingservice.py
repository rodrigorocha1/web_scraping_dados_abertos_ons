from typing import Generator, Union, Tuple
import bs4
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

    def obter_links_csv(self):
        yield from [1, 2]


if __name__ == '__main__':
    wss = WebScrapingService(
        url='https://dados.ons.org.br/dataset/balanco-energia-subsistema'
    )

    flag, soup = wss.conectar_url()
    # listas_sites = soup.find_all(class_='resource-item')
    # print(len(listas_sites))
    # print(listas_sites[0].find('a')['href'])
    # print(listas_sites[0].find('a'))
    # print('=' * 20)
    # for site in listas_sites:
    #     print(site.find('a')['href'])
    #     print(site.find('span', class_='format-label').text)
    #     print(site.find('a'))
    #     print('*' * 100)

    lista_sites = soup.find_all(class_='dropdown-menu')
    print(len(lista_sites))
    print(lista_sites[0].find('a', class_='resource-url-analytics')['href'])
    for site in lista_sites:
        site = site.find('a', class_='resource-url-analytics')['href']
        if site.endswith('csv'):
            print(site)
