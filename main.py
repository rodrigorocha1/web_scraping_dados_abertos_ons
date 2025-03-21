import bs4
import requests
from typing import List, Optional


def conectar_url(url: str) -> bs4.BeautifulSoup:
    response = requests.get(url)
    html = response.text
    soup = bs4.BeautifulSoup(html, 'html.parser')
    return soup


def obter_lista_sites(soup: bs4.BeautifulSoup) -> List:
    sites = soup.find_all('li')

    lista_sites = [
        site.find('a')['href']
        for site in sites
        if isinstance(site, bs4.Tag)
        and site.find("a") is not None
        and site.find('a')['href'].startswith('https://')
    ]


    return lista_sites


soup = conectar_url(url='https://dados.ons.org.br/')
for site  in obter_lista_sites(soup=soup):
    print(site)
