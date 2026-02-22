ARG GO_VERSION=dev-1.26
FROM mcr.microsoft.com/devcontainers/go:${GO_VERSION}

# Use copy mode for uv so venvs work inside containers with volume mounts
ENV UV_LINK_MODE=copy
