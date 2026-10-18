#!/usr/bin/env python3
from __future__ import annotations

import struct


class AMF3Reader:
    def __init__(self, data: bytes, pos: int = 0):
        self.data, self.pos = data, pos
        self.strings: list[str] = []
        self.objects: list = []
        self.traits: list[tuple] = []

    def eof(self) -> bool:
        return self.pos >= len(self.data)

    def u8(self) -> int:
        v = self.data[self.pos]
        self.pos += 1
        return v

    def u29(self) -> int:
        v = 0
        for i in range(4):
            b = self.u8()
            if i < 3:
                v = (v << 7) | (b & 0x7F)
                if not b & 0x80:
                    return v
            else:
                return (v << 8) | b
        return v

    def i29(self) -> int:
        v = self.u29()
        return v - (1 << 29) if v & (1 << 28) else v

    def string(self) -> str:
        ref = self.u29()
        if not ref & 1:
            return self.strings[ref >> 1]
        n = ref >> 1
        s = self.data[self.pos:self.pos + n].decode("utf-8", "replace")
        self.pos += n
        if s:
            self.strings.append(s)
        return s

    def read(self):
        marker = self.u8()
        if marker in (0x00, 0x01):
            return None
        if marker == 0x02:
            return False
        if marker == 0x03:
            return True
        if marker == 0x04:
            return self.i29()
        if marker == 0x05:
            v = struct.unpack_from(">d", self.data, self.pos)[0]
            self.pos += 8
            return v
        if marker == 0x06:
            return self.string()
        if marker in (0x07, 0x0B):
            ref = self.u29()
            if not ref & 1:
                return self.objects[ref >> 1]
            s = self.data[self.pos:self.pos + (ref >> 1)].decode("utf-8", "replace")
            self.pos += ref >> 1
            self.objects.append(s)
            return s
        if marker == 0x08:
            ref = self.u29()
            if not ref & 1:
                return self.objects[ref >> 1]
            v = struct.unpack_from(">d", self.data, self.pos)[0]
            self.pos += 8
            self.objects.append({"__date__": v})
            return self.objects[-1]
        if marker == 0x09:
            return self.array()
        if marker == 0x0A:
            return self.object()
        if marker == 0x0C:
            ref = self.u29()
            if not ref & 1:
                return self.objects[ref >> 1]
            n = ref >> 1
            b = self.data[self.pos:self.pos + n]
            self.pos += n
            v = {"__bytes__": b.hex()}
            self.objects.append(v)
            return v
        if marker in (0x0D, 0x0E, 0x0F, 0x10):
            ref = self.u29()
            if not ref & 1:
                return self.objects[ref >> 1]
            n = ref >> 1
            self.u8()
            out: list = []
            self.objects.append(out)
            if marker == 0x10:
                self.string()
                out.extend(self.read() for _ in range(n))
            else:
                fmt = {0x0D: ">i", 0x0E: ">I", 0x0F: ">d"}[marker]
                size = struct.calcsize(fmt)
                for _ in range(n):
                    out.append(struct.unpack_from(fmt, self.data, self.pos)[0])
                    self.pos += size
            return out
        if marker == 0x11:
            ref = self.u29()
            if not ref & 1:
                return self.objects[ref >> 1]
            n = ref >> 1
            self.u8()
            d: dict = {}
            self.objects.append(d)
            for _ in range(n):
                k = self.read()
                d[str(k)] = self.read()
            return d
        raise ValueError(f"marcador AMF3 desconhecido {marker:#x} em {self.pos - 1}")

    def array(self):
        ref = self.u29()
        if not ref & 1:
            return self.objects[ref >> 1]
        n = ref >> 1
        assoc: dict = {}
        holder: list = []
        slot = len(self.objects)
        self.objects.append(holder)
        while True:
            k = self.string()
            if not k:
                break
            assoc[k] = self.read()
        dense = [self.read() for _ in range(n)]
        if assoc:
            result = {**{str(i): v for i, v in enumerate(dense)}, **assoc}
            self.objects[slot] = result
            return result
        holder.extend(dense)
        return holder

    def object(self):
        ref = self.u29()
        if not ref & 1:
            return self.objects[ref >> 1]
        if not ref & 2:
            cls, ext, dyn, names = self.traits[ref >> 2]
        else:
            ext = bool(ref & 4)
            dyn = bool(ref & 8)
            count = ref >> 4
            cls = self.string()
            names = [self.string() for _ in range(count)] if not ext else []
            self.traits.append((cls, ext, dyn, names))
        obj: dict = {}
        if cls:
            obj["__class__"] = cls
        self.objects.append(obj)
        if ext:
            if cls in ("flex.messaging.io.ArrayCollection", "flex.messaging.io.ObjectProxy"):
                obj["source"] = self.read()
                return obj
            raise ValueError(f"externalizable não suportado: {cls}")
        for name in names:
            obj[name] = self.read()
        if dyn:
            while True:
                k = self.string()
                if not k:
                    break
                obj[k] = self.read()
        return obj


def read_all(data: bytes) -> list:
    r = AMF3Reader(data)
    out = []
    while not r.eof():
        r.strings, r.objects, r.traits = [], [], []
        out.append(r.read())
    return out
