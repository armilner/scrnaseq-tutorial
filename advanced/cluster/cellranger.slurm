#!/usr/bin/env bash
# Submitted by ./cluster/submit.sh cellranger. This is the Nextflow "head" job: it uses
# little CPU itself and sends each pipeline task to Slurm as its own job.
# If it stops, submit it again and Nextflow picks up where it left off (-resume).
set -euo pipefail
source cluster/settings.sh
export ACCOUNT PARTITION CACHE_DIR
export NXF_OPTS="-Xms1g -Xmx4g"
export NXF_APPTAINER_CACHEDIR="$CACHE_DIR"
export APPTAINER_TMPDIR="$CACHE_DIR/tmp"; mkdir -p "$APPTAINER_TMPDIR"
HERE="$PWD"
CONFIG="$HERE/cluster/slurm.config"

# Everything the pipelines write goes in pipeline/
mkdir -p pipeline && cd pipeline

# 1. The 10x human reference (about 11 GB once unpacked). Downloaded once.
REF=refdata-gex-GRCh38-2024-A
if [ ! -d "$REF" ]; then
  curl -sSL -o "$REF.tar.gz" "https://cf.10xgenomics.com/supp/cell-exp/$REF.tar.gz"
  tar xzf "$REF.tar.gz" && rm "$REF.tar.gz"
fi

# 2. Download the 10 FASTQ runs from SRA.
nextflow run nf-core/fetchngs -r 1.13.0 -c "$CONFIG" -profile apptainer -resume \
  --input "$HERE/cluster/ids.csv" --outdir results_fetchngs --download_method sratools

# 3. Give the files the names Cell Ranger accepts and group runs by sample.
python3 "$HERE/cluster/make_scrnaseq_samplesheet.py" \
  results_fetchngs/samplesheet/samplesheet.csv "$HERE/cluster/sra_runs.tsv" > samplesheet_scrnaseq.csv

# 4. Cell Ranger, one job per sample.
nextflow run nf-core/scrnaseq -r 4.2.0 -c "$CONFIG" -profile apptainer -resume \
  -params-file "$HERE/cluster/scrnaseq_params.yaml" --cellranger_index "$PWD/$REF"

# 5. Point data/cellranger/<sample> at the results, where samplesheet.csv expects them.
cd "$HERE" && mkdir -p data/cellranger
for s in $(tail -n +2 cluster/sra_runs.tsv | cut -f1 | sort -u); do
  ln -sfn "../../pipeline/results_scrnaseq/cellranger/count/$s" "data/cellranger/$s"
  test -d "data/cellranger/$s/outs/raw_feature_bc_matrix" || { echo "missing output for $s"; exit 1; }
done
echo "Cell Ranger outputs are ready in data/cellranger/. Next: ./cluster/submit.sh render"
