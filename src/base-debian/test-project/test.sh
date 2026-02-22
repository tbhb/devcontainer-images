#!/bin/bash
set -e

echo "Testing base-debian image..."

# Test Zsh
zsh --version

# Test uv
uv --version

# Test Node and pnpm
node --version
pnpm --version

# Test just
just --version

# Test GitHub CLI
gh --version

# Test shellcheck
shellcheck --version

# Test hadolint
hadolint --version

# Test starship
starship --version

# Test Claude Code CLI
claude --version

echo "All tests passed!"
