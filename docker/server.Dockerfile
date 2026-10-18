FROM rust:1.86-slim-bookworm AS build
WORKDIR /src
COPY Cargo.toml Cargo.lock ./
COPY src ./src
RUN cargo build --release

FROM debian:bookworm-slim
COPY --from=build /src/target/release/lg-server /usr/local/bin/lg-server
ENV LG_ROOT=/app LG_HOST=0.0.0.0 LG_PORT=8787
WORKDIR /app
EXPOSE 8787
CMD ["lg-server"]
