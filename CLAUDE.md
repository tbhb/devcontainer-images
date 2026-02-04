# Dev container images

Repository for custom Dev Container images published to `ghcr.io/tbhb/<image>:<tag>`.

## Commands (via just)

```bash
just              # List all commands
just install      # Install dependencies (pnpm + uv)
just lint         # Run all linters
just build <img>  # Build specific image (e.g., just build python)
just test <img>   # Build and run smoke tests
just shell <img>  # Interactive shell in image
just validate     # Validate devcontainer.json files
just prek         # Run pre-commit hooks
```

## Architecture

Images live in `src/<image-name>/` with:

- `.devcontainer/devcontainer.json` (required)
- `.devcontainer/Dockerfile` (optional)
- `manifest.json` (required for CI - defines variants and tags)
- `test-project/test.sh` (optional smoke tests)

CI reads `manifest.json` to build variants from a single image definition.

## Python Image

The `python` image provides 10 variants (Python 3.10-3.14 on Debian Trixie or Bookworm).

- Base: `mcr.microsoft.com/devcontainers/python`
- Includes: uv, Zsh, Ruff formatter
- Architectures: linux/amd64, linux/arm64

## Linting stack

| Tool             | Purpose          |
| ---------------- | ---------------- |
| codespell        | Spelling         |
| yamllint         | YAML             |
| hadolint         | Dockerfiles      |
| shellcheck       | Shell scripts    |
| biome            | JSON             |
| markdownlint-cli2| Markdown         |
| vale             | Prose style      |
