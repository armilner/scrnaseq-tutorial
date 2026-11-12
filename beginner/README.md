# Beginner: single-cell RNA-seq from start to finish

One notebook, one laptop, every step of a full analysis in order. Each step says what it does and why.

Data: PBMCs from 8 donors, control vs interferon-beta (Kang et al., Nature Biotechnology 2018). It downloads automatically through the Bioconductor package `muscData`, so you don't need to fetch anything yourself.

**Never used R or a terminal? Read [GETTING_STARTED.md](GETTING_STARTED.md) first.** It walks you through installing R and RStudio and running this with a few clicks.

## Run

```bash
Rscript install_packages.R                 # once
quarto render tutorial_beginner.qmd        # or open it in RStudio and click Render
```

This needs about 8 GB of RAM and takes about 10 to 20 minutes.

## Steps

Load data, ambient RNA (decontX), doublets (scDblFinder), QC (MAD-based), normalize, integrate (Harmony), cluster and UMAP, marker genes, naming clusters (SingleR plus markers, then checked by you), pseudobulk DESeq2 between conditions, and GSEA with Hallmark and Reactome.

## Outputs (in `results/`)

`qc_table.csv`, `cluster_markers.csv`, `annotation_proposed.csv`, `pseudobulk_DE.csv`, `gsea.csv`, `pbmc_ifnb_annotated.rds`
