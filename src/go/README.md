# Go

Go development container with modern tooling pre-installed.

## Usage

```json
{
  "image": "ghcr.io/tbhb/devcontainer-go:1.25"
}
```

## Features

- Go 1.24 - 1.25
- uv package manager (for Python tooling)
- Node.js 24 with pnpm 10
- just command runner
- GitHub CLI
- shellcheck, hadolint
- Zsh with autosuggestions and syntax highlighting
- Starship prompt
- Claude Code CLI

## Variants

| Tags | Go | Distro |
|------|-----|--------|
| `1.25-trixie`, `1.25`, `1`, `trixie`, `latest` | 1.25 | Debian Trixie |
| `1.25-bookworm` | 1.25 | Debian Bookworm |
| `1.24-trixie` | 1.24 | Debian Trixie |
| `1.24-bookworm`, `1.24`, `bookworm` | 1.24 | Debian Bookworm |
