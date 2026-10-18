use serde_json::{json, Map, Value};
use std::collections::HashMap;

#[derive(Clone, Debug)]
pub struct Field {
    pub name: String,
    pub num: u32,
    pub ty: String,
    pub repeated: bool,
    pub msg: String,
}

pub struct Schema {
    pub msgs: HashMap<String, Vec<Field>>,
}

impl Schema {
    pub fn load(path: &str) -> Self {
        let text = std::fs::read_to_string(path).unwrap_or_else(|e| panic!("proto.json: {path}: {e}"));
        let v: Value = serde_json::from_str(&text).expect("proto.json inválido");
        let mut msgs = HashMap::new();
        for (name, info) in v.as_object().unwrap() {
            let fields = info["fields"].as_array().map(|a| {
                a.iter()
                    .map(|f| Field {
                        name: f["name"].as_str().unwrap_or_default().to_string(),
                        num: f["num"].as_u64().unwrap_or(0) as u32,
                        ty: f["type"].as_str().unwrap_or("INT32").to_string(),
                        repeated: f["repeated"].as_bool().unwrap_or(false),
                        msg: f["msg"].as_str().unwrap_or_default().to_string(),
                    })
                    .collect()
            });
            msgs.insert(name.clone(), fields.unwrap_or_default());
        }
        Self { msgs }
    }

    pub fn encode(&self, msg: &str, value: &Value) -> Vec<u8> {
        let mut out = Vec::new();
        let Some(fields) = self.msgs.get(msg) else {
            eprintln!("[proto] mensagem desconhecida: {msg}");
            return out;
        };
        let obj = value.as_object().cloned().unwrap_or_default();
        for f in fields {
            let Some(v) = obj.get(&f.name) else { continue };
            if f.repeated {
                for item in v.as_array().cloned().unwrap_or_default() {
                    self.write_field(&mut out, f, &item);
                }
            } else {
                self.write_field(&mut out, f, v);
            }
        }
        out
    }

    fn write_field(&self, out: &mut Vec<u8>, f: &Field, v: &Value) {
        match f.ty.as_str() {
            "STRING" | "BYTES" => {
                let bytes = match v {
                    Value::String(s) => s.as_bytes().to_vec(),
                    Value::Array(a) => a.iter().map(|x| x.as_u64().unwrap_or(0) as u8).collect(),
                    _ => v.to_string().into_bytes(),
                };
                key(out, f.num, 2);
                varint(out, bytes.len() as u64);
                out.extend_from_slice(&bytes);
            }
            "MESSAGE" => {
                let ty = v.get("$type").and_then(|t| t.as_str()).map(str::to_string).unwrap_or_else(|| f.msg.clone());
                let body = self.encode(&ty, v);
                key(out, f.num, 2);
                varint(out, body.len() as u64);
                out.extend_from_slice(&body);
            }
            "FLOAT" => {
                key(out, f.num, 5);
                out.extend_from_slice(&(v.as_f64().unwrap_or(0.0) as f32).to_le_bytes());
            }
            "DOUBLE" => {
                key(out, f.num, 1);
                out.extend_from_slice(&v.as_f64().unwrap_or(0.0).to_le_bytes());
            }
            "FIXED32" | "SFIXED32" => {
                key(out, f.num, 5);
                out.extend_from_slice(&(v.as_i64().unwrap_or(0) as u32).to_le_bytes());
            }
            "FIXED64" | "SFIXED64" => {
                key(out, f.num, 1);
                out.extend_from_slice(&(v.as_i64().unwrap_or(0) as u64).to_le_bytes());
            }
            "SINT32" | "SINT64" => {
                let n = v.as_i64().unwrap_or(0);
                key(out, f.num, 0);
                varint(out, ((n << 1) ^ (n >> 63)) as u64);
            }
            "BOOL" => {
                key(out, f.num, 0);
                varint(out, v.as_bool().unwrap_or(false) as u64);
            }
            _ => {
                let n = v.as_i64().or_else(|| v.as_u64().map(|u| u as i64)).unwrap_or(0);
                key(out, f.num, 0);
                varint(out, n as u64);
            }
        }
    }

    pub fn decode(&self, msg: &str, mut data: &[u8]) -> Value {
        let fields = self.msgs.get(msg).cloned().unwrap_or_default();
        let mut obj = Map::new();
        while !data.is_empty() {
            let (k, rest) = read_varint(data);
            data = rest;
            let (num, wire) = ((k >> 3) as u32, (k & 7) as u8);
            let f = fields.iter().find(|f| f.num == num);
            let name = f.map(|f| f.name.clone()).unwrap_or_else(|| format!("#{num}"));
            let val = match wire {
                0 => {
                    let (n, rest) = read_varint(data);
                    data = rest;
                    if f.map(|f| f.ty == "BOOL").unwrap_or(false) { json!(n != 0) } else { json!(n as i64) }
                }
                2 => {
                    let (len, rest) = read_varint(data);
                    let (bytes, rest) = rest.split_at((len as usize).min(rest.len()));
                    data = rest;
                    match f.map(|f| f.ty.as_str()) {
                        Some("STRING") => json!(String::from_utf8_lossy(bytes)),
                        Some("MESSAGE") if !f.unwrap().msg.is_empty() => self.decode(&f.unwrap().msg.clone(), bytes),
                        Some("INT32") | Some("INT64") | Some("UINT32") => {
                            let mut v = Vec::new();
                            let mut b = bytes;
                            while !b.is_empty() {
                                let (n, r) = read_varint(b);
                                v.push(json!(n as i64));
                                b = r;
                            }
                            json!(v)
                        }
                        _ => json!(bytes.iter().map(|b| format!("{b:02x}")).collect::<String>()),
                    }
                }
                1 => {
                    let (b, rest) = data.split_at(8.min(data.len()));
                    data = rest;
                    json!(b.iter().map(|b| format!("{b:02x}")).collect::<String>())
                }
                5 => {
                    let (b, rest) = data.split_at(4.min(data.len()));
                    data = rest;
                    json!(b.iter().map(|b| format!("{b:02x}")).collect::<String>())
                }
                _ => break,
            };
            if f.map(|f| f.repeated).unwrap_or(false) {
                let entry = obj.entry(name).or_insert_with(|| json!([]));
                match val {
                    Value::Array(a) => entry.as_array_mut().unwrap().extend(a),
                    v => entry.as_array_mut().unwrap().push(v),
                }
            } else {
                obj.insert(name, val);
            }
        }
        Value::Object(obj)
    }
}

fn key(out: &mut Vec<u8>, num: u32, wire: u8) {
    varint(out, ((num << 3) | wire as u32) as u64);
}

fn varint(out: &mut Vec<u8>, mut n: u64) {
    loop {
        let b = (n & 0x7F) as u8;
        n >>= 7;
        if n == 0 {
            out.push(b);
            break;
        }
        out.push(b | 0x80);
    }
}

fn read_varint(data: &[u8]) -> (u64, &[u8]) {
    let mut n = 0u64;
    let mut shift = 0;
    for (i, b) in data.iter().enumerate() {
        n |= ((b & 0x7F) as u64) << shift;
        if b & 0x80 == 0 {
            return (n, &data[i + 1..]);
        }
        shift += 7;
        if shift > 63 {
            break;
        }
    }
    (n, &[])
}
