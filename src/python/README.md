# Python

Python development container with [uv](https://docs.astral.sh/uv/) pre-installed.

## Usage

```json
{
  "image": "ghcr.io/tbhb/python:3.13"
}
```

## Features

- Python 3.13 (default) or 3.12
- uv package manager
- Zsh shell with common-utils
- Ruff extension pre-configured

## Variants

| Tag | Python Version | Base |
|-----|---------------|------|
| `3.13-bookworm`, `3.13`, `latest` | 3.13 | Debian Bookworm |
| `3.12-bookworm`, `3.12` | 3.12 | Debian Bookworm |
