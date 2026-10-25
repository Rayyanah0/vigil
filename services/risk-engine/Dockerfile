# --- Builder Stage ---
FROM rust:1.85-slim-bookworm AS builder
WORKDIR /src

# Copy only the Cargo.toml and source files that exist inside the service folder
COPY services/risk-engine/Cargo.toml ./
COPY services/risk-engine/src ./src

RUN cargo build --release

# --- Runtime Stage ---
FROM debian:bookworm-slim AS runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/target/release/vigil-risk-engine /usr/local/bin/

EXPOSE 8080
CMD ["vigil-risk-engine"]