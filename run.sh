#!/usr/bin/env bash
# Usage: ./run.sh check | render      (set ENGINE=apptainer on HPC)
set -euo pipefail
IMG="ghcr.io/armilner/r-bioinformatics-2026"
ENGINE="${ENGINE:-docker}"
case "${1:-render}" in
  check)  CMD=(Rscript check_packages.R) ;;
  render) CMD=(quarto render tutorial.qmd) ;;
  *) echo "check | render"; exit 1 ;;
esac
if [ "$ENGINE" = "apptainer" ]; then
  apptainer exec --bind "$PWD":/work --pwd /work "docker://$IMG" "${CMD[@]}"
else
  docker run --rm -v "$PWD":/work -w /work "$IMG" "${CMD[@]}"
fi
