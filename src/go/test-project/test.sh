#!/bin/bash
set -e

echo "Testing go image..."

# Test Go version
go version

# Test Go can compile and run
echo 'package main; import "fmt"; func main() { fmt.Println("Hello, Go!") }' > /tmp/hello.go
go run /tmp/hello.go
rm /tmp/hello.go

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
