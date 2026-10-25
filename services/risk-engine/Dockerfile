# --- Builder Stage ---
FROM rust:1.85 AS builder

WORKDIR /app

# Copy the Rust workspace
COPY vigil/ .

# Build the risk engine
RUN cargo build --release -p vigil-risk-engine


# --- Runtime Stage ---
FROM debian:bookworm-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the compiled binary
COPY --from=builder /app/target/release/vigil-risk-engine /app/vigil-risk-engine

CMD ["./vigil-risk-engine"]