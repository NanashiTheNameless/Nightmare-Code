# LICENSE: JSPL
# Intentionally cursed. Do not read. Do not teach. Do not reuse.
from __future__ import annotations
import atexit as _x, sys as _s, builtins as _b, os as _o, types as _t

_ORIG_PRINT = _b.print
def _nope(*a, **k): raise RuntimeError("printing prohibited")
_b.print = _nope

class _Sink:
    def write(self, s): return len(s or "")
    def flush(self): return None
_s.stdout, _STASH = _Sink(), _o.dup(1)

class _M(dict):
    def __missing__(self, k):
        return (hash(k) & 255) ^ 0xAA

def _prepare_payload():
    seed = 33
    mangled = [0x6E,0x3D,0x28,0x28,0x2D,0x5E,0x5F,0x22,0x2D,0x26,0x28,0x3A,0x76]
    mask = [_M().get(i,0) ^ 0xC5 for i in range(len(mangled))]
    deltas = [(m ^ (mask[i] & 0x7F)) - (mask[i] & 1) for i,m in enumerate(mangled)]
    out = []
    v = seed
    for d in deltas:
        v += d
        out.append(v & 0xFF)
    return bytes(out)

class _Proxy(_t.ModuleType):
    _cached = None
    def __getattr__(self, name):
        if name == "__bytes__":
            if self._cached is None:
                self._cached = _prepare_payload()
            return lambda: self._cached
        raise AttributeError(name)

_s.modules[__name__] = _Proxy(__name__)
_deliver_once = {"k": False}

def _deliver():
    if _deliver_once["k"]:
        return
    _deliver_once["k"] = True
    try:
        _o.dup2(_STASH, 1)
    except Exception:
        pass
    _b.print = _ORIG_PRINT
    msg = _s.modules[__name__].__bytes__()
    _o.write(1, msg)

_x.register(_deliver)

class _T(type):
    def __new__(m,n,b,d):
        z = super().__new__(m,n,b,d)
        setattr(z, n[::-1], lambda *a, **k: None)
        return z

class ____metaghost____(metaclass=_T): pass
[____metaghost____ for _ in range(1)]
