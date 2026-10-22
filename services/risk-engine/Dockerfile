FROM rust:1.85-slim-bullseye AS builder
WORKDIR /src

COPY services/ ./services/
COPY migrations/ ./migrations/
RUN cargo build --release --manifest-path services/Cargo.toml -p vigil-risk-engine

FROM debian:bullseye-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/services/target/release/vigil-risk-engine /usr/local/bin/vigil-risk-engine

ENV RUST_LOG=info
EXPOSE 8080
CMD ["vigil-risk-engine"]
