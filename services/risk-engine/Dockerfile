# --- Builder Stage ---
FROM rust:1.85-slim-bookworm AS builder
WORKDIR /src

# Copy the risk engine source and manifest files
COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN cargo build --release

# --- Runtime Stage ---
FROM debian:bookworm-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the binary from builder (adjust binary name if your package name differs)
COPY --from=builder /src/target/release/vigil-risk-engine /usr/local/bin/

EXPOSE 8080
CMD ["vigil-risk-engine"]