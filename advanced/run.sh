#!/usr/bin/env bash
# Usage: ./run.sh check | render      (set ENGINE=apptainer on HPC)
set -euo pipefail
IMG="ghcr.io/armilner/r-bioinformatics-2027:sha-dc83161"   # the exact image used for tutorial.html
ENGINE="${ENGINE:-docker}"
case "${1:-render}" in
  check)  CMD=(Rscript check_packages.R) ;;
  render) CMD=(quarto render tutorial.qmd) ;;
  *) echo "check | render"; exit 1 ;;
esac
# Only this folder is visible inside the container. Keep data/cellranger here (real files,
# or symlinks that point to somewhere inside this folder).
# Azimuth installs its kidney reference the first time, so R gets a writable library in .Rlib.
mkdir -p .Rlib
if [ "$ENGINE" = "apptainer" ]; then
  APPTAINERENV_R_LIBS_USER=/work/.Rlib apptainer exec --bind "$PWD":/work --pwd /work "docker://$IMG" "${CMD[@]}"
else
  docker run --rm -e R_LIBS_USER=/work/.Rlib -v "$PWD":/work -w /work "$IMG" "${CMD[@]}"
fi
