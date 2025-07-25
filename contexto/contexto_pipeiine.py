from typing import Deque, NamedTuple
from collections import deque
import pandas as pd

class ConextoPipeline(NamedTuple):
    pilha: Deque[pd.DataFrame]


if __name__ == '__main__':
    c = ConextoPipeline(pilha=deque())
    c.pilha.append(1)
    c.pilha.append(2)
    c.pilha.append(3)
    c.pilha.append(4)
    c.pilha.append(5)
    print(c.pilha)