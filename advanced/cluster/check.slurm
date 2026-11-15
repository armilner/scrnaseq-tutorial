#!/usr/bin/env bash
# Submitted by ./cluster/submit.sh check. Lists package versions inside the container.
# The first run downloads and converts the container image, which can take a while.
set -euo pipefail
source cluster/settings.sh
export APPTAINER_CACHEDIR="$CACHE_DIR"
export APPTAINER_TMPDIR="$CACHE_DIR/tmp"; mkdir -p "$APPTAINER_TMPDIR"
ENGINE=apptainer ./run.sh check
