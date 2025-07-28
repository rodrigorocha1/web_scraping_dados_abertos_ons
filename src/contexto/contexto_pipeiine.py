from typing import Deque, NamedTuple
import pandas as pd


class ContextoPipeline(NamedTuple):
    pilha: Deque[pd.DataFrame]
