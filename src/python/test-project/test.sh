#!/bin/bash
set -e

echo "Testing python-uv image..."

# Test Python
python --version
python3 --version

# Test uv
uv --version

# Test pip via uv
uv pip --version

echo "All tests passed!"
