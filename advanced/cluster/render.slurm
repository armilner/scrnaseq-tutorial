#!/usr/bin/env bash
# Submitted by ./cluster/submit.sh render. Renders tutorial.qmd inside the container.
# About 25 minutes with 32 CPUs and 60 GB. The first run needs internet (Azimuth reference).
set -euo pipefail
source cluster/settings.sh
export APPTAINER_CACHEDIR="$CACHE_DIR"
export APPTAINER_TMPDIR="$CACHE_DIR/tmp"; mkdir -p "$APPTAINER_TMPDIR"
ENGINE=apptainer ./run.sh render
