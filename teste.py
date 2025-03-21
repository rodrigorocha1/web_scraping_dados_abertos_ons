from src.web_scraping_service.webscrapingservice import WebScrapingService
import sys

wss = WebScrapingService(url='https://dados.ons.org.br/')

dados_site = wss.conectar_url()

for link in wss.obter_lista_sites(dados_site=dados_site):
    print(link)


print(sys.getsizeof(wss ) / (1024 * 1024))