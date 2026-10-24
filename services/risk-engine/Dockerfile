# --- Builder Stage ---
FROM rust:1.85-slim-bookworm AS builder
WORKDIR /src

# Copy the entire workspace or necessary manifest files first
COPY Cargo.toml Cargo.lock ./
COPY services/risk-engine ./services/risk-engine
# Copy any other dependent services/common modules if your workspace requires them
COPY services/common ./services/common

WORKDIR /src/services/risk-engine
RUN cargo build --release -p vigil-risk-engine

# --- Runtime Stage ---
FROM debian:bookworm-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/target/release/vigil-risk-engine /usr/local/bin/
EXPOSE 8080
CMD ["vigil-risk-engine"]