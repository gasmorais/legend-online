pub const KEY: [u8; 8] = [174, 191, 86, 120, 171, 205, 239, 241];
pub const MAGIC: u16 = 29099;
pub const HEADER: usize = 20;

#[derive(Clone, Debug)]
pub struct Cipher {
    pub key: [u8; 8],
}

impl Cipher {
    pub fn new(key: [u8; 8]) -> Self { Self { key } }

    pub fn encrypt(&mut self, data: &mut [u8]) {
        for i in 0..data.len() {
            if i > 0 {
                let k = i % 8;
                self.key[k] = self.key[k].wrapping_add(data[i - 1]) ^ (i as u8);
                data[i] = (data[i] ^ self.key[k]).wrapping_add(data[i - 1]);
            } else {
                data[0] ^= self.key[0];
            }
        }
    }

    pub fn decrypt(&mut self, raw: &[u8]) -> Vec<u8> {
        let mut out = vec![0u8; raw.len()];
        for i in 0..raw.len() {
            if i > 0 {
                let k = i % 8;
                self.key[k] = self.key[k].wrapping_add(raw[i - 1]) ^ (i as u8);
                out[i] = raw[i].wrapping_sub(raw[i - 1]) ^ self.key[k];
            } else {
                out[0] = raw[0] ^ self.key[0];
            }
        }
        out
    }

    pub fn peek(&self, raw: &[u8], n: usize) -> Vec<u8> {
        let mut c = self.clone();
        c.decrypt(&raw[..n.min(raw.len())])
    }
}

#[derive(Debug, Clone)]
pub struct Packet {
    pub code: u16,
    pub client_id: u32,
    pub extend1: u32,
    pub extend2: u32,
    pub body: Vec<u8>,
}

pub fn checksum(buf: &[u8]) -> u16 {
    let mut sum: u32 = 119;
    for b in &buf[6..] {
        sum += *b as u32;
    }
    (sum & 0x7F7F) as u16
}

pub fn build(code: u16, client_id: u32, extend1: u32, extend2: u32, body: &[u8]) -> Vec<u8> {
    let len = HEADER + body.len();
    let mut b = Vec::with_capacity(len);
    b.extend_from_slice(&MAGIC.to_be_bytes());
    b.extend_from_slice(&(len as u16).to_be_bytes());
    b.extend_from_slice(&0u16.to_be_bytes());
    b.extend_from_slice(&code.to_be_bytes());
    b.extend_from_slice(&client_id.to_be_bytes());
    b.extend_from_slice(&extend1.to_be_bytes());
    b.extend_from_slice(&extend2.to_be_bytes());
    b.extend_from_slice(body);
    let cs = checksum(&b);
    b[4..6].copy_from_slice(&cs.to_be_bytes());
    b
}

pub fn parse(plain: &[u8]) -> Option<Packet> {
    if plain.len() < HEADER {
        return None;
    }
    let u16_at = |i: usize| u16::from_be_bytes([plain[i], plain[i + 1]]);
    let u32_at = |i: usize| u32::from_be_bytes([plain[i], plain[i + 1], plain[i + 2], plain[i + 3]]);
    if u16_at(0) != MAGIC {
        return None;
    }
    Some(Packet {
        code: u16_at(6),
        client_id: u32_at(8),
        extend1: u32_at(12),
        extend2: u32_at(16),
        body: plain[HEADER..].to_vec(),
    })
}

pub struct Reader {
    buf: Vec<u8>,
    pub cipher: Cipher,
}

impl Reader {
    pub fn new() -> Self { Self { buf: Vec::new(), cipher: Cipher::new(KEY) } }

    pub fn push(&mut self, data: &[u8]) -> Vec<Packet> {
        self.buf.extend_from_slice(data);
        let mut out = Vec::new();
        loop {
            if self.buf.len() < 4 {
                break;
            }
            let head = self.cipher.peek(&self.buf, 4);
            let magic = u16::from_be_bytes([head[0], head[1]]);
            if magic != MAGIC {
                self.buf.remove(0);
                continue;
            }
            let len = u16::from_be_bytes([head[2], head[3]]) as usize;
            if len < HEADER || self.buf.len() < len {
                break;
            }
            let raw: Vec<u8> = self.buf.drain(..len).collect();
            let plain = self.cipher.decrypt(&raw);
            if let Some(p) = parse(&plain) {
                if checksum(&plain) == u16::from_be_bytes([plain[4], plain[5]]) {
                    out.push(p);
                } else {
                    eprintln!("[socket] checksum inválido no opcode {}", p.code);
                }
            }
        }
        out
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn roundtrip() {
        let mut enc = Cipher::new(KEY);
        let mut dec = Cipher::new(KEY);
        for code in [3u16, 4153, 20001] {
            let pkt = build(code, 1, 0, 0, b"hello world");
            let mut wire = pkt.clone();
            enc.encrypt(&mut wire);
            assert_eq!(dec.decrypt(&wire), pkt);
        }
    }
}
