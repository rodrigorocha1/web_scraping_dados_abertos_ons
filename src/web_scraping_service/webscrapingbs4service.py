from typing import Generator, Union, Tuple, List
import bs4
import re
import requests
from datetime import datetime
from bs4 import Tag
from src.web_scraping_service.iwebscarpingservice import IWebScrapingService
from src.utlis.llog_factory import logger


class WebScrapingBS4Service(IWebScrapingService[bs4.BeautifulSoup]):
    __url = ''

    def __init__(self, url: str):
        self.__url = url
        self.__loop = 5
        self.__data = datetime.now()

    @property
    def url(self) -> str:
        """
        Atributo URL
        :return: url
        :rtype:str
        """
        return self.__url

    @url.setter
    def url(self, url: str):
        """
         Atributo URL
        :param url: url
        :type url:str
        :return:
        :rtype:
        """
        self.__url = url

    def checar_conexao_url(self) -> bool:
        response = None
        url = self.url
        try:

            response = requests.get(url=url, timeout=10)
            response.raise_for_status()

            if response.status_code == 200:
                logger.info(
                    msg='Sucesso ao fazer conexão na url ',
                    extra={
                        'url': url,
                        'requisicao': response.text,
                        'status_code': response.status_code
                    }
                )
                return True
            logger.warning(
                msg='Erro ao fazer conexão na url ',
                extra={
                    'url': url,
                    'requisicao': response.text,
                    'status_code': response.status_code
                }
            )
            return False
        except requests.exceptions.ConnectionError as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Erro ao conectar na url: erro genérico',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.HTTPError as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Erro http',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.Timeout as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Tempo excedido (Timeout)',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.TooManyRedirects as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Muitos redirecionamentos excessivos',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.URLRequired as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='URl sem esquema (http: // ou https://)',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.InvalidURL as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='URl invalida (http: // ou https://)',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.InvalidSchema as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='URl sem esquema (http: // ou https://)',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except requests.exceptions.RequestException as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Erro ao conectar na url: ero genérico',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except Exception as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Não mapeado',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False

    def conectar_url(self) -> Union[Tuple[bool, bs4.BeautifulSoup], bool]:
        """
        Método para conectar na URL
        :return: Tupla com verdadeiro se a conexão for feita com sucesso, falso caso contrário e os dados do site, ou falso se a url cair
        :rtype:  Union[Tuple[bool, T], bool]
        """
        url = self.url
        response = None
        try:
            response = requests.get(url)
            html = response.text
            try:
                soup = bs4.BeautifulSoup(html, 'html.parser')
                logger.info(
                    msg='Sucesso ao conectar na URL',
                    extra={
                        'url': url,
                        'status_code': response.status_code
                    }
                )
                return True, soup
            except Exception as msg:
                texto_response = response.text if response is not None else ''
                logger.warning(
                    msg='Não mapeado',
                    extra={
                        'url': url,
                        'requisicao': texto_response,
                        'mensagem_de_excecao_tecnica': str(msg)
                    }
                )
                return False
        except requests.exceptions.TooManyRedirects as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Muitos redirecionamentos excessivos',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False
        except Exception as msg:
            texto_response = response.text if response is not None else ''
            logger.warning(
                msg='Não mapeado',
                extra={
                    'url': url,
                    'requisicao': texto_response,
                    'mensagem_de_excecao_tecnica': str(msg)
                }
            )
            return False

    def obter_lista_sites(self, dados_site: bs4.BeautifulSoup) -> Generator[str, None, None]:
        """
        Método para obter os sites da ons
        :param dados_site: dados do SITE
        :type dados_site: T
        :return: GERADOR com as urls
        :rtype:Generator[str, None, None]
        """
        if isinstance(dados_site, bs4.BeautifulSoup):
            sites = dados_site.find_all('li')

            yield from [
                link['href']
                for site in sites
                if isinstance(site, bs4.Tag)
                   and (link := site.find("a"))
                   and isinstance(link, bs4.Tag)
                   and 'href' in link.attrs
                   and isinstance(link['href'], str)
                   and link['href'].startswith('https://')
            ]

    def __e_link_valido(self, url: str) -> bool:
        """
        Método para validar link do csv
        :param url: url do arquivo csv
        :type url: str
        :return: Verdadeiro se ocorrer alguma ocorrência de data
        :rtype: bool
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
        Método para obter os links csv
        :param dados_site: dados do site
        :type dados_site: bs4.BeautifulSoup
        :param flag_carga_completa: flag de carga completa, true se a carga for completa, falso caso contrário
        :type flag_carga_completa: bool
        :return: Lista das urls
        :rtype: List[str]
        """
        if not isinstance(dados_site, bs4.BeautifulSoup):
            return []

        links_brutos = (
            tag.get('href')
            for tag in dados_site.find_all('a', class_='resource-url-analytics')
            if isinstance(tag, Tag)
        )

        links_csv = [
            href
            for href in links_brutos
            if isinstance(href, str) and href.endswith('.csv')
        ]

        links_filtrados = (
            links_csv if flag_carga_completa
            else list(filter(self.__e_link_valido, links_csv))
        )

        return sorted(set(links_filtrados))
