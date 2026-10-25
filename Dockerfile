# --- Builder Stage ---
FROM rust:1.85-slim-bookworm AS builder
WORKDIR /app

# Copy the entire workspace repository (root Cargo.toml, common modules, and risk-engine)
COPY . .

# Build the risk engine package specifically from the workspace root
RUN cargo build --release -p vigil-risk-engine

# --- Runtime Stage ---
FROM debian:bookworm-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/vigil-risk-engine /usr/local/bin/

EXPOSE 8080
CMD ["vigil-risk-engine"]
