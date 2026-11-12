# Advanced tutorial (work in progress)

**Not finished yet.** It has not been run end to end. New to single-cell? Start with the [beginner tutorial](../beginner) instead.

A full 10x single-nucleus workflow on a public human kidney dataset (GSE131882, 3 control vs 3 early diabetic nephropathy; Wilson et al., PNAS 2019). Each step states the decision, the default, and when to deviate.

## Input

Cell Ranger `outs/` per sample, containing both `raw_feature_bc_matrix/` and `filtered_feature_bc_matrix/`. The raw matrix is required for ambient RNA correction, which is why this starts from FASTQs (SRA) and not from processed GEO tables. Paths go in `samplesheet.csv`.

GEO only has zUMIs count matrices as RDS (already barcode-filtered), so there is no raw droplet matrix to download. FASTQs are in SRA under SRP199727 (BioProject PRJNA545232), samples GSM3823939 to GSM3823944. Libraries are 10x Chromium Single Cell 5'.

Suggested route: nf-core/fetchngs for SRP199727, then nf-core/scrnaseq with `--aligner cellranger` on GRCh38. Introns are counted by default in Cell Ranger 7 and later. Point `samplesheet.csv` at each sample's `outs/` folder.

## Run

```bash
./run.sh check     # package versions inside the container
./run.sh render    # renders tutorial.html
ENGINE=apptainer ./run.sh render   # on HPC (run from this folder)
```

Container: `ghcr.io/armilner/r-bioinformatics-2026`

## Manual step

After the first render, review `results/annotation_proposed.csv` against the marker dot plot, edit the `celltype` column, save it as `annotation_approved.csv` in this folder, and render again.

## Outputs

`results/cluster_markers.csv`, `results/pseudobulk_DE.csv`, `results/gsea.csv`, `results/kidney_snrna_annotated.rds`, `tutorial.html`
