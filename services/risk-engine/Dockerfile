# --- Builder Stage ---
FROM rust:1.85-slim-bookworm AS builder
WORKDIR /src

# Copy the root workspace manifest
COPY Cargo.toml ./

# Copy dependent workspace modules if they exist
COPY services/common ./services/common

# Copy the risk engine service folder
COPY services/risk-engine ./services/risk-engine

# Build specifically the risk engine package from the workspace root
RUN cargo build --release -p vigil-risk-engine

# --- Runtime Stage ---
FROM debian:bookworm-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/target/release/vigil-risk-engine /usr/local/bin/

EXPOSE 8080
CMD ["vigil-risk-engine"]