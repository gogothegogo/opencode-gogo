FROM debian:trixie

ARG PYTHON_VERSION="3.13"

# Install everything in one layer
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates procps less jq curl wget zip unzip git gh nodejs npm \
    python${PYTHON_VERSION} python${PYTHON_VERSION}-venv python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install opencode via npm
RUN npm install -g opencode-ai

# Setup user 1000 for CachyOS compatibility
RUN useradd -m -u 1000 opencode
USER opencode
WORKDIR /home/opencode

# This allows passing 'web --hostname...' via the compose 'command'
ENTRYPOINT ["opencode"]
