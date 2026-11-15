#!/usr/bin/env bash
# Submit a step of the advanced tutorial to Slurm. Run from the advanced/ folder:
#   ./cluster/submit.sh cellranger   FASTQs from SRA -> Cell Ranger -> data/cellranger/
#   ./cluster/submit.sh render       Cell Ranger output -> tutorial.html
#   ./cluster/submit.sh check        list package versions in the container
set -euo pipefail
cd "$(dirname "$0")/.."
source cluster/settings.sh
if [ "$ACCOUNT" = "CHANGE_ME" ] || [ "$PARTITION" = "CHANGE_ME" ]; then
  echo "Edit cluster/settings.sh first (ACCOUNT and PARTITION)."; exit 1
fi
step="${1:-}"
case "$step" in
  cellranger) opts=(--time=3-00:00:00 --cpus-per-task=8  --mem=15G) ;;
  render)     opts=(--time=08:00:00   --cpus-per-task=32 --mem=60G) ;;
  check)      opts=(--time=03:00:00   --cpus-per-task=8  --mem=15G) ;;
  *) echo "Usage: ./cluster/submit.sh cellranger | render | check"; exit 1 ;;
esac
mkdir -p logs
sbatch --account="$ACCOUNT" --partition="$PARTITION" "${opts[@]}" \
  --job-name="snrna_$step" --output="logs/${step}_%j.log" "cluster/$step.slurm"
