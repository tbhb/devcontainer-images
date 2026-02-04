# Dev container images

Custom [Dev Container](https://containers.dev/) images for development environments.

## Usage

Reference images in your `devcontainer.json`:

```json
{
  "image": "ghcr.io/tbhb/<image>:latest"
}
```

Or use as a base for your own Dockerfile:

```dockerfile
FROM ghcr.io/tbhb/<image>:latest
```

## Available Images

| Image | Description |
|-------|-------------|
| *Coming soon* | |

## Development

### Prerequisites

- [devcontainer CLI](https://github.com/devcontainers/cli)
- [just](https://just.systems/)
- [uv](https://docs.astral.sh/uv/)
- Docker
- hadolint
- shellcheck

### Commands

```bash
# List available commands
just

# Install Python dependencies
just install

# Run all linters
just lint

# Build a specific image
just build <image>

# Build all images
just build-all

# Test an image
just test <image>

# Run a shell in an image
just shell <image>

# Validate all image configurations
just validate
```

### Creating an image

1. Create a new directory under `src/<image-name>/`
2. Add `.devcontainer/devcontainer.json` with configuration
3. Optionally add `.devcontainer/Dockerfile` for custom builds
4. Optionally add `test.sh` for smoke tests

See the [Dev Container specification](https://containers.dev/implementors/spec/) for details.

## License

MIT
