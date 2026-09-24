#!/bin/bash
# Generates ~/.holmes/config.yaml from the template, expanding $VAR references.
# Run this once after setting your env vars, or add it to your shell profile.

set -euo pipefail
DOTFILES="$HOME/.dotfiles/holmes/.holmes"

TEMPLATE="$DOTFILES/config-template.yaml"
OUTPUT="$DOTFILES/config.yaml"

envsubst <"$TEMPLATE" >"$OUTPUT"
echo "✓ ~/.holmes/config.yaml generated"
