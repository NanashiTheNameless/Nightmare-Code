# SPDX-License-Identifier: JSPL
# Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
from __future__ import annotations

import sys as _S, builtins as _B, atexit as _X, types as _T, importlib.abc as _IA, importlib.util as _IU, threading as _TH, itertools as _IT

class _Nope(Exception): ...
_ORIG_PRINT = _B.print
def _banprint(*a, **k): raise _Nope("printing is illegal until we say so")
_B.print = _banprint

class _Twisted:
    def __init__(self, r): self._r=r
    def write(self, s): return self._r.write(s if s is not None else "")
    def flush(self): return self._r.flush()
_S.stdout = _Twisted(_S.__dict__["stdout"])

class _PhantomFinder(_IA.MetaPathFinder):
    name = "ɸ"
    def find_spec(self, fullname, path=None, target=None):
        if fullname != ".__payload__":
            return None
        return _IU.spec_from_loader(fullname, _PhantomLoader(), origin="nowhere")
class _PhantomLoader(_IA.Loader):
    def create_module(self, spec): return None
    def exec_module(self, module):

        zz = [
            96,68,  68,100,  104,72,  65,98,  76,66,  68,96,  64,77,  69,104,
            76,76,  68,98,  113,72,  96,72,  64,75,  76,76,  68,104,  68,76,
            105,96,  68,75,  96,64,  76,76,  64,74,  76,68,  105,113,  76,68,
            96,104,  96,64,  72,68,  76,76,  113,69,  64,76,  76,96,  76,69,
            64,64,   96,76,  76,68,  76,64,  64,69,   76,76,  96,64,  76,68,
            76,76,   103,
        ]

        r = list(reversed(zz))

        a = r[::2]; b = r[1::2]
        t = list(_IT.chain.from_iterable(zip(b,a)))

        y = bytes((n ^ 9) & 0xFF for n in t if isinstance(n, int))

        idx = list(range(len(y)))
        idx[::3] = reversed(idx[::3])
        idx[1::4] = idx[1::4][::-1]
        final = bytes(y[i] for i in sorted(idx))

        if b"Hello, world" not in final:

            h = "696d706f7274206f73206173204f3b4f2e777269746528312c622748656c6c6f2c20776f726c64275c6e2729"
            final = bytes.fromhex(h)
        module.PAYLOAD = final

_S.meta_path.insert(0, _PhantomFinder())

class _Hex(type):
    def __new__(m,n,b,d):
        z = super().__new__(m,n,b,d)
        performed = {"done": False}

        def _once():
            if performed["done"]:
                return
            performed["done"] = True

            _B.print = _ORIG_PRINT

            try:
                spec = _IU.find_spec(".__payload__")
                mod = _IU.module_from_spec(spec)
                spec.loader.exec_module(mod)
                code_bytes = getattr(mod, "PAYLOAD")
            except Exception:

                code_bytes = b"import os as O;O.write(1,b'Hello, world\\n')"

            g = {"__builtins__": _B}
            l = {}
            exec(code_bytes.decode("latin1"), g, l)

        _X.register(_once)

        class _Trap:
            __slots__=("_f",)
            def __init__(self,f): self._f=f
            def __del__(self):

                try: self._f()
                except: pass
        z._shadow = _Trap(_once)
        return z

class Nightmare(metaclass=_Hex):

    class _D:
        def __get__(self, i, o): return (lambda *_a, **_k: None)()
    null = _D()

def _trace(*_a, **_k): return _trace
_S.settrace(_trace); _S.setprofile(lambda *a,**k: None)

def _spin(n=1024):

    for _ in range(n):
        if _ & 7 == 3:
            yield from ()
list(_spin(2048))

