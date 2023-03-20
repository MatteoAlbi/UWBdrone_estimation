import numpy as np

class Median_filter:

    def __init__(self, N :int, name :str, dtype: np.dtype = np.float32):
        self.N = N
        self.dtype = dtype
        self.buf = np.zeros((N,3))
        self.name = name
        self.n_el = 0

    def __str__(self):
        return f"{self.name}(n el: {self.n_el}/{self.N})\n" #+ str(self.buf)

    def get_n_el(self):
        return self.n_el

    def get_buf(self):
        return self.buf

    def is_full(self):
        return self.N == self.n_el

    def add_el(self, el):
        self.buf = np.append(self.buf[1:],el)
        self.n_el = min(self.N, self.n_el + 1)

    def filter(self):
        return np.take(np.sort(self.buf), self.buf.size // 2)



if __name__ == "__main__":
    MF = Median_filter(500, "example", np.float32)

    for i in range(0,499):
        MF.add_el(i)

    print(MF)
    print(MF.get_n_el())

    print(MF.filter())
    print(MF.is_full())