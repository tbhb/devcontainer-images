ARG BASE_DEBIAN_VERSION=trixie
FROM mcr.microsoft.com/devcontainers/base:${BASE_DEBIAN_VERSION}

# Use copy mode for uv so venvs work inside containers with volume mounts
ENV UV_LINK_MODE=copy
