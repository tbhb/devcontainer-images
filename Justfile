# Dev Container Images
# https://github.com/tbhb/devcontainer-images

set shell := ['uv', 'run', '--frozen', 'bash', '-euo', 'pipefail', '-c']
set positional-arguments

pnpm := "pnpm exec"

# List available recipes
default:
    @just --list

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

# Install all dependencies (Python + Node.js)
install: install-node install-python

# Install only Node.js dependencies
install-node:
    #!/usr/bin/env bash
    pnpm install --frozen-lockfile

# Install only Python dependencies
install-python:
    #!/usr/bin/env bash
    uv sync --frozen

# ------------------------------------------------------------------------------
# Linting
# ------------------------------------------------------------------------------

# Run all linters
lint: lint-spelling lint-yaml lint-dockerfile lint-shell lint-json lint-docs

# Check spelling
lint-spelling:
    codespell

# Lint YAML files
lint-yaml:
    yamllint --strict .

# Lint Dockerfiles
lint-dockerfile:
    #!/usr/bin/env bash
    for dockerfile in src/*/.devcontainer/Dockerfile; do
        if [[ -f "${dockerfile}" ]]; then
            echo "Linting ${dockerfile}..."
            hadolint "${dockerfile}"
        fi
    done

# Lint shell scripts
lint-shell:
    #!/usr/bin/env bash
    shopt -s nullglob
    scripts=(src/*/.devcontainer/*.sh)
    if [[ ${#scripts[@]} -gt 0 ]]; then
        shellcheck "${scripts[@]}"
    fi

# Lint JSON files
lint-json:
    {{pnpm}} biome check --files-ignore-unknown=true .

# Lint documentation
lint-docs: lint-markdown lint-prose

# Lint Markdown files
lint-markdown *args:
    {{pnpm}} markdownlint-cli2 {{ if args == "" { '"**/*.md"' } else { args } }}

# Lint prose in Markdown files
lint-prose *args:
    vale {{ if args == "" { "src/**/*.md README.md" } else { args } }}

# Format code
format:
    codespell -w
    {{pnpm}} biome format --write .

# Fix code issues
fix:
    {{pnpm}} biome format --write .
    {{pnpm}} biome check --write .

# Sync Vale styles and dictionaries
vale-sync:
    vale sync

# ------------------------------------------------------------------------------
# Pre-commit
# ------------------------------------------------------------------------------

# Run pre-commit hooks on changed files
prek:
    prek

# Run pre-commit hooks on all files
prek-all:
    prek run --all-files

# Install pre-commit hooks
prek-install:
    prek install

# ------------------------------------------------------------------------------
# Building
# ------------------------------------------------------------------------------

# Build an image locally
build image *args:
    #!/usr/bin/env bash
    devcontainer build \
        --workspace-folder "src/{{ image }}" \
        "$@"

# Build all images
build-all:
    #!/usr/bin/env bash
    for image in src/*/; do
        name=$(basename "${image}")
        echo "Building ${name}..."
        just build "${name}"
    done

# ------------------------------------------------------------------------------
# Testing
# ------------------------------------------------------------------------------

# Test an image (build and run smoke tests)
test image:
    #!/usr/bin/env bash
    echo "Testing {{ image }}..."
    just build "{{ image }}"

    # Run smoke test if it exists
    if [[ -f "src/{{ image }}/test.sh" ]]; then
        devcontainer exec --workspace-folder "src/{{ image }}" bash /workspaces/test.sh
    fi

# Test all images
test-all:
    #!/usr/bin/env bash
    for image in src/*/; do
        name=$(basename "${image}")
        just test "${name}"
    done

# Validate image configurations
validate:
    #!/usr/bin/env bash
    for image in src/*/; do
        echo "Validating ${image}..."
        if [[ ! -f "${image}.devcontainer/devcontainer.json" ]]; then
            echo "ERROR: Missing devcontainer.json in ${image}"
            exit 1
        fi
        # Validate JSON
        jq empty "${image}.devcontainer/devcontainer.json"
    done
    echo "All images valid"

# ------------------------------------------------------------------------------
# Local Development
# ------------------------------------------------------------------------------

# Run a shell in an image
shell image:
    #!/usr/bin/env bash
    devcontainer up --workspace-folder "src/{{ image }}"
    devcontainer exec --workspace-folder "src/{{ image }}" bash

# ------------------------------------------------------------------------------
# CI Helpers
# ------------------------------------------------------------------------------

# List all images
list-images:
    #!/usr/bin/env bash
    for image in src/*/; do
        basename "${image}"
    done

# Get image metadata
image-info image:
    #!/usr/bin/env bash
    jq '.' "src/{{ image }}/.devcontainer/devcontainer.json"
