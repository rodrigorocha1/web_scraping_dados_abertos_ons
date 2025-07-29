import requests
from bs4 import BeautifulSoup

from src.web_scraping_service.webscrapingbs4service import WebScrapingBS4Service


def exp(url):
    response = requests.get(url)
    html = response.text

    soup = BeautifulSoup(html, 'html.parser')
    # logger.info(
    #     msg='Sucesso ao conectar na URL',
    #     extra={
    #         'url': url,
    #         'status_code': response.status_code
    #     }
    # )

    return soup


url_ons = 'https://dados.ons.org.br/'
servico_web_scraping_ons = WebScrapingBS4Service(url=url_ons)

req = servico_web_scraping_ons.conectar_url()
if isinstance(req, tuple):
    _, dados = req
    lista_sites = servico_web_scraping_ons.obter_lista_sites(dados_site=dados)
    print(lista_sites)
