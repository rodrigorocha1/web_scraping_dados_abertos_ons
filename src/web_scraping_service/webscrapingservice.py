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
