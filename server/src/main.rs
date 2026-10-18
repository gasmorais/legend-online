mod battle;
mod game;
mod packet;
mod proto;

use axum::{
    body::Bytes,
    extract::{ws::{Message, WebSocket, WebSocketUpgrade}, Path, State},
    http::{header, StatusCode, Uri},
    response::{IntoResponse, Response},
    routing::{any, get},
    Router,
};
use game::{Session, Shared};
use serde_json::json;
use std::{collections::HashMap, path::PathBuf, sync::Arc};
use tower_http::cors::CorsLayer;

fn port() -> u16 {
    std::env::var("LG_PORT").ok().and_then(|v| v.parse().ok()).unwrap_or(8787)
}

fn root() -> PathBuf {
    std::env::var("LG_ROOT").map(PathBuf::from).unwrap_or_else(|_| PathBuf::from(".."))
}

fn xml(body: String) -> Response {
    ([(header::CONTENT_TYPE, "text/xml; charset=utf-8")], body).into_response()
}

async fn config() -> Response {
    let port = port();
    let src = std::fs::read_to_string(root().join("raw/config.xml")).unwrap_or_default();
    let mut out = String::new();
    for line in src.lines() {
        let l = if line.contains("<REQUEST_PATH") {
            "\t<REQUEST_PATH value=\"/\" />".to_string()
        } else if line.contains("<TEMPLATE_PATH") {
            "\t\t<TEMPLATE_PATH value=\"/xml/\" />".to_string()
        } else if line.contains("<SocktPath") {
            format!("        <SocktPath value=\"localhost\" SocketPort=\"{port}\" />")
        } else if line.contains("CastleServicePath") || line.contains("OuterCityServicePath") {
            line.replace("http://s1264oas.creaction-network.com/messagebroker/amf", "/messagebroker/amf")
        } else {
            line.to_string()
        };
        out.push_str(&l);
        out.push('\n');
    }
    xml(out)
}

async fn template(Path(file): Path<String>) -> Response {
    let p = root().join("raw/xml").join(file.replace("..", ""));
    match std::fs::read(&p) {
        Ok(b) => ([(header::CONTENT_TYPE, "application/octet-stream")], b).into_response(),
        Err(_) => {
            eprintln!("[http] template ausente: {file}");
            (StatusCode::NOT_FOUND, "").into_response()
        }
    }
}

async fn cdn(Path(path): Path<String>) -> Response {
    let rel = path.replace("..", "");
    let mut cands = vec![root().join("raw").join(&rel)];
    if let Some((stem, ext)) = rel.rsplit_once('.') {
        if let Some((base, hash)) = stem.rsplit_once('_') {
            if hash.len() == 8 && hash.chars().all(|c| c.is_ascii_hexdigit()) {
                cands.push(root().join("raw").join(format!("{base}.{ext}")));
            }
        }
    }
    for c in &cands {
        if let Ok(b) = std::fs::read(c) {
            let ct = match c.extension().and_then(|e| e.to_str()).unwrap_or("") {
                "png" => "image/png",
                "jpg" | "jpeg" => "image/jpeg",
                "xml" => "text/xml",
                _ => "application/octet-stream",
            };
            return ([(header::CONTENT_TYPE, ct)], b).into_response();
        }
    }
    eprintln!("[cdn] ausente: {rel}");
    use std::io::Write;
    if let Ok(mut f) = std::fs::OpenOptions::new().create(true).append(true).open(root().join("logs/cdn_missing.txt")) {
        let _ = writeln!(f, "{rel}");
    }
    (StatusCode::NOT_FOUND, "").into_response()
}

async fn manifest(uri: Uri) -> Response {
    let name = if uri.path().contains("code") { "index/code_md5.raw" } else { "index/res_md5.raw" };
    match std::fs::read(root().join(name)) {
        Ok(b) => ([(header::CONTENT_TYPE, "application/octet-stream")], b).into_response(),
        Err(_) => (StatusCode::NOT_FOUND, "").into_response(),
    }
}

fn player(st: &Shared) -> serde_json::Value {
    let text = std::fs::read_to_string(&st.flows_path).unwrap_or_default();
    serde_json::from_str::<serde_json::Value>(&text).ok().and_then(|v| v.get("player").cloned()).unwrap_or(json!({}))
}

async fn servlet(State(st): State<Arc<Shared>>, uri: Uri, body: Bytes) -> Response {
    let path = uri.path().trim_start_matches('/');
    let q = format!("{}{}", uri.query().unwrap_or(""), String::from_utf8_lossy(&body));
    eprintln!("[http] {path} {q}");
    let pl = player(&st);
    let pid = pl["player_id"].as_i64().unwrap_or(1);
    let port = port();
    match path {
        "loginselectlist" => xml(format!("<Result value=\"true\"><Item ID=\"{pid}\" Active=\"true\" /></Result>")),
        "login" | "login2" => xml(format!(
            "<Result value=\"true\" message=\"\" userId=\"{pid}\" Address=\"localhost\" Port=\"{port}\" CurrentServerName=\"Local\" />"
        )),
        "updateplayernovice" => pl["novice_process"].as_i64().unwrap_or(99900).to_string().into_response(),
        "visualizeregister" => xml("<Result value=\"true\" type=\"0\" message=\"\" />".into()),
        "nicknamecheck" => xml("<Result value=\"true\" message=\"\" />".into()),
        "flashversionservlet" => xml("<Result value=\"true\" />".into()),
        _ => {
            eprintln!("[http] sem handler: {path}");
            xml("<Result value=\"false\" />".into())
        }
    }
}

async fn socket(State(st): State<Arc<Shared>>, ws: WebSocketUpgrade) -> Response {
    ws.on_upgrade(move |s| session(s, st))
}

pub enum Out {
    Key([u8; 8]),
    Pkt(Vec<u8>, String),
}

async fn session(ws: WebSocket, st: Arc<Shared>) {
    use futures_util::{SinkExt, StreamExt};
    eprintln!("[socket] conectado");
    let (mut sink, mut stream) = ws.split();
    let (tx, mut rx) = tokio::sync::mpsc::unbounded_channel::<Out>();
    let writer = tokio::spawn(async move {
        let mut w = game::Writer { cipher: packet::Cipher::new(packet::KEY) };
        while let Some(o) = rx.recv().await {
            match o {
                Out::Key(k) => w.cipher = packet::Cipher::new(k),
                Out::Pkt(p, label) => {
                    eprintln!("[socket] -> {label}");
                    if sink.send(Message::Binary(w.seal(p).into())).await.is_err() {
                        break;
                    }
                }
            }
        }
    });
    let sess = Arc::new(tokio::sync::Mutex::new(Session::new(st.clone())));
    st.live.lock().await.push((sess.clone(), tx.clone()));
    while let Some(Ok(msg)) = stream.next().await {
        let data = match msg {
            Message::Binary(b) => b.to_vec(),
            Message::Close(_) => break,
            _ => continue,
        };
        let outs = {
            let mut s = sess.lock().await;
            let outs = s.on_bytes(&data);
            if let Some(k) = s.new_send_key.take() {
                let _ = tx.send(Out::Key(k));
            }
            if let Some(b) = s.battle_start.take() {
                tokio::spawn(battle::run(b, tx.clone()));
            }
            outs
        };
        dispatch(&tx, outs);
    }
    sess.lock().await.close();
    st.live.lock().await.retain(|(s, _)| !Arc::ptr_eq(s, &sess));
    drop(tx);
    let _ = writer.await;
    eprintln!("[socket] desconectado");
}

fn dispatch(tx: &tokio::sync::mpsc::UnboundedSender<Out>, outs: Vec<game::Outgoing>) {
    {
        if outs.iter().all(|o| o.delay_ms == 0) {
            for o in outs {
                let _ = tx.send(Out::Pkt(o.plain, format!("{:5} {}", o.code, o.label)));
            }
        } else {
            let tx2 = tx.clone();
            tokio::spawn(async move {
                for o in outs {
                    if o.delay_ms > 0 {
                        tokio::time::sleep(std::time::Duration::from_millis(o.delay_ms)).await;
                    }
                    let _ = tx2.send(Out::Pkt(o.plain, format!("{:5} {}", o.code, o.label)));
                }
            });
        }
    }
}

async fn debug(State(st): State<Arc<Shared>>, Path(name): Path<String>) -> Response {
    let live = st.live.lock().await;
    let Some((sess, tx)) = live.last() else { return (StatusCode::CONFLICT, "nenhum cliente conectado").into_response() };
    let outs = sess.lock().await.push(&name);
    let n = outs.len();
    dispatch(tx, outs);
    format!("ok: push:{name} ({n} pacotes)").into_response()
}

async fn fallback(uri: Uri) -> Response {
    eprintln!("[http] 404 {}", uri);
    (StatusCode::NOT_FOUND, "").into_response()
}

fn opcode_names() -> HashMap<(String, u16), String> {
    let mut m = HashMap::new();
    let text = std::fs::read_to_string(root().join("protocol/opcodes.csv")).unwrap_or_default();
    for line in text.lines().skip(1) {
        let parts: Vec<&str> = line.split(',').collect();
        if parts.len() >= 4 {
            if let Ok(code) = parts[1].parse::<u16>() {
                m.insert((parts[0].to_string(), code), parts[3].to_string());
            }
        }
    }
    m
}

#[tokio::main]
async fn main() {
    let shared = Arc::new(Shared {
        schema: proto::Schema::load(root().join("protocol/proto.json").to_str().unwrap()),
        opcode_names: opcode_names(),
        flows_path: root().join("server/flows.json"),
        live: tokio::sync::Mutex::new(Vec::new()),
    });
    eprintln!("[lg-server] {} mensagens protobuf, {} opcodes", shared.schema.msgs.len(), shared.opcode_names.len());
    let app = Router::new()
        .route("/config.xml", get(config))
        .route("/xml/{*file}", get(template))
        .route("/code_md5.dat", get(manifest))
        .route("/res_md5.dat", get(manifest))
        .route("/socket", get(socket))
        .route("/debug/{name}", get(debug))
        .route("/cdn/{*path}", get(cdn))
        .route("/{servlet}", any(servlet))
        .fallback(fallback)
        .layer(CorsLayer::permissive())
        .with_state(shared);
    battle::preload();
    let host = std::env::var("LG_HOST").unwrap_or_else(|_| "127.0.0.1".into());
    let addr = format!("{host}:{}", port());
    eprintln!("[lg-server] ouvindo em http://{addr}  (WebSocket do jogo: ws://{addr}/socket)");
    let listener = tokio::net::TcpListener::bind(&addr).await.expect("bind");
    axum::serve(listener, app).await.expect("serve");
}
