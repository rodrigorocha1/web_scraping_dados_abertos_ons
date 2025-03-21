from src.web_scraping_service.iwebscarpingservice import IWebScrapingService
from src.web_scraping_service.webscrapingservice import WebScrapingService


class WebScrapingPipeline:
    def __init__(self, servico_web_scraping: IWebScrapingService):
        self.__service_web_scraping = servico_web_scraping


    def rodar_web_scraping(self):
        dados_site = self.__service_web_scraping.conectar_url()
        for link in self.__service_web_scraping.obter_lista_sites(dados_site=dados_site):
            print(link)


if __name__ == '__main__':
    wsp = WebScrapingPipeline(servico_web_scraping=WebScrapingService(url='https://dados.ons.org.br/'))
    wsp.rodar_web_scraping()