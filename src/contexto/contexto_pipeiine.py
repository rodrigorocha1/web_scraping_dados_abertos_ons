from dataclasses import dataclass
from typing import List


@dataclass
class ContextoPipeline:
    lista_sites_csv: List[str]
