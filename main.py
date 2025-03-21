import bs4
import requests
from typing import List, Optional, Generator
import sys


def conectar_url(url: str) -> bs4.BeautifulSoup:
    response = requests.get(url)
    html = response.text
    soup = bs4.BeautifulSoup(html, 'html.parser')
    return soup




def obter_lista_sites(soup: bs4.BeautifulSoup) -> Generator[str, None, None]:
    sites = soup.find_all('li')

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



soup = conectar_url(url='https://dados.ons.org.br/')


for site in obter_lista_sites(soup=soup):
    print(site)