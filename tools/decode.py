#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import lzma
import pathlib
import struct
import zlib
from dataclasses import dataclass, field, asdict

RECV_KEY = bytes([174, 191, 86, 120, 171, 205, 239, 241])
PKG_MAGIC = 29099
PKG_HEADER = 20


@dataclass
class Layer:
    algo: str
    before: int
    after: int


@dataclass
class Result:
    source: str
    layers: list[Layer] = field(default_factory=list)
    format: str = "unknown"

    @property
    def data(self) -> bytes:
        return self._data

    def add(self, algo: str, data: bytes) -> "Result":
        self.layers.append(Layer(algo, len(self._data), len(data)))
        self._data = data
        return self


def _zlib_at(data: bytes, offset: int = 0) -> bytes | None:
    try:
        obj = zlib.decompressobj()
        out = obj.decompress(data[offset:])
        if out:
            return out
    except zlib.error:
        return None
    return None


def _zlib_multi(data: bytes) -> bytes | None:
    layers = []
    current = data
    while current[:1] == b"\x78":
        nxt = _zlib_at(current)
        if nxt is None:
            break
        layers.append(nxt)
        current = nxt
    return layers[-1] if layers else None


def detect(data: bytes) -> str:
    if data[:3] in (b"FWS", b"CWS", b"ZWS"):
        return "swf_" + data[:3].decode().lower()
    if data[:2] in (b"\x78\x9c", b"\x78\xda", b"\x78\x01"):
        return "zlib"
    if data[:4] == b"ATF\x00" or data[:3] == b"ATF":
        return "atf"
    if data[:8] == b"\x89PNG\r\n\x1a\n":
        return "png"
    if data[:2] == b"\xff\xd8":
        return "jpeg"
    if data[:4] == b"PK\x03\x04":
        return "zip"
    if data[:1] == b"<" or data[:3] == b"\xef\xbb\xbf":
        return "xml"
    if len(data) > 8 and data[0] == 0x14 and data[5:7] in (b"\x78\x9c", b"\x78\xda"):
        return "module"
    return "unknown"


def dec_module(data: bytes) -> bytes:
    body = data[21: len(data) - 121]
    trailer = data[len(data) - 121:]
    out = bytearray(124)
    out[0:3] = b"CWS"
    out[3:124] = trailer
    out[124:] = body
    return bytes(out)


def dec_swf(data: bytes) -> bytes:
    version = data[3]
    if data[:3] == b"CWS":
        body = zlib.decompress(data[8:])
    elif data[:3] == b"ZWS":
        filters = [lzma._decode_filter_properties(lzma.FILTER_LZMA1, data[12:17])]
        body = lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=filters).decompress(data[17:])
    elif data[:3] == b"FWS":
        body = data[8:]
    else:
        return data
    length = struct.unpack("<I", data[4:8])[0]
    out = bytearray(8 + len(body))
    out[0:3] = b"FWS"
    out[3] = version
    out[4:8] = struct.pack("<I", length)
    out[8:] = body
    return bytes(out)


def dec_socket(data: bytes, key: bytes = RECV_KEY) -> bytes:
    key = bytearray(key)
    out = bytearray(len(data))
    for i in range(len(data)):
        if i > 0:
            key[i % 8] = (key[i % 8] + data[i - 1]) & 0xFF ^ (i & 0xFF)
            out[i] = ((data[i] - data[i - 1]) & 0xFF) ^ key[i % 8]
        else:
            out[0] = data[0] ^ key[0]
    return bytes(out)


def parse_packet(payload: bytes) -> dict:
    if len(payload) < PKG_HEADER:
        return {}
    magic, length, checksum, code, client_id, ext1, ext2 = struct.unpack(">HHHHIII", payload[:20])
    total = 119
    for b in payload[6:length]:
        total += b
    return {
        "magic": magic,
        "length": length,
        "checksum": checksum,
        "checksum_ok": (total & 0x7F7F) == checksum,
        "code": code,
        "code_hex": f"0x{code:04x}",
        "client_id": client_id,
        "extend1": ext1,
        "extend2": ext2,
        "body_bytes": length - PKG_HEADER,
    }


def decode(data: bytes, source: str = "") -> Result:
    result = Result(source=source)
    result._data = data
    kind = detect(data)
    result.format = kind

    if kind == "module":
        return result.add("module_container", dec_module(result._data))
    if kind in ("swf_cws", "swf_zws"):
        return result.add("swf_body", dec_swf(result._data))
    if kind == "zlib":
        nxt = _zlib_multi(result._data)
        if nxt is not None:
            result.add("zlib_multi", nxt)
            if result._data[:3] in (b"FWS", b"CWS", b"ZWS"):
                result.add("swf_body", dec_swf(result._data))
            result.format = detect(result._data)
        return result
    return result


def cmd_triage(args) -> None:
    root = pathlib.Path(args.dir)
    counts: dict[str, int] = {}
    records = []
    for path in sorted(root.rglob("*")):
        if not path.is_file():
            continue
        data = path.read_bytes()
        kind = detect(data)
        counts[kind] = counts.get(kind, 0) + 1
        records.append({"path": str(path.relative_to(root)), "format": kind, "size": len(data)})
    out = pathlib.Path("index") / "formats.json"
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(records, indent=1))
    for kind, n in sorted(counts.items(), key=lambda kv: -kv[1]):
        print(f"{n:7d}  {kind}")
    print(f"\nrelatório: {out}")


def cmd_decode(args) -> None:
    data = pathlib.Path(args.file).read_bytes()
    result = decode(data, source=args.file)
    print(json.dumps({"format": result.format, "layers": [asdict(l) for l in result.layers]}, indent=1))
    if args.out:
        target = pathlib.Path(args.out) / (pathlib.Path(args.file).stem + ".dec")
        target.write_bytes(result.data)
        print("gravado:", target)


def cmd_socket(args) -> None:
    payload = bytes.fromhex(args.hexbytes.replace(" ", "").replace(",", ""))
    plain = dec_socket(payload)
    print("plaintext:", plain.hex())
    if len(plain) >= PKG_HEADER:
        print(json.dumps(parse_packet(plain), indent=1))


def main() -> None:
    parser = argparse.ArgumentParser(prog="decode.py", description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("triage")
    p.add_argument("dir")
    p.set_defaults(func=cmd_triage)

    p = sub.add_parser("decode")
    p.add_argument("file")
    p.add_argument("--out")
    p.set_defaults(func=cmd_decode)

    p = sub.add_parser("socket-decrypt")
    p.add_argument("hexbytes")
    p.set_defaults(func=cmd_socket)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
