# Advanced tutorial

[Open the finished tutorial in your browser](https://armilner.github.io/scrnaseq-tutorial/advanced/tutorial.html).

New to single-cell? Start with the [beginner tutorial](../beginner) instead.

This tutorial runs a full 10x single-nucleus analysis on a computing cluster, starting from the raw sequencing files. The data is human kidney from 3 control donors and 3 donors with early diabetic nephropathy (GSE131882; Wilson et al., PNAS 2019). Each step in the notebook states the decision, the default, and when to deviate.

## What makes it advanced

- **It starts from raw reads.** GEO only has count matrices that were already filtered to real cells. Ambient RNA correction needs the unfiltered matrix of every droplet, so we download the FASTQs from SRA and run Cell Ranger again.
- **It needs a cluster.** Cell Ranger aligns hundreds of millions of reads to the human genome. That takes about 32 CPUs and 60 GB of memory per sample, and about 750 GB of scratch space while it runs (150 GB of FASTQs, 16 GB of reference, 115 GB of results and the rest temporary files).
- **Nuclei, not cells.** Nuclei have more ambient RNA and many intronic reads, and QC thresholds behave differently.
- **A real disease comparison with only 3 donors per group.** Few genes pass the cutoff, and the notebook shows how to read results with that little power.
- **Labels from a reference.** Clusters get proposed names from the Azimuth kidney reference, and a person checks and approves them.

## What you need

- A Linux cluster that uses Slurm, with an allocation (account) you can charge
- Apptainer (or Singularity) on the compute nodes
- Nextflow 24 or later and Java 17
- Python 3
- Internet access from the compute nodes (for SRA, container images and the Azimuth reference)

If your cluster uses a different scheduler, the Nextflow part still works: change `executor` in `cluster/slurm.config` and submit the `.slurm` scripts your cluster's way.

## Run it

All commands are run from this `advanced/` folder on the cluster's login node. The login node only submits jobs. All heavy work runs on compute nodes.

**1. Get the code onto the cluster.**

```bash
git clone https://github.com/armilner/scrnaseq-tutorial.git
cd scrnaseq-tutorial/advanced
```

Put it somewhere with plenty of space, such as your scratch folder.

**2. Tell it about your cluster.** Open `cluster/settings.sh` and set `ACCOUNT`, `PARTITION` and `CACHE_DIR`. If your partition has less than 60 GB of memory per job, also lower the numbers in `cluster/slurm.config` and `cluster/submit.sh`.

**3. Check the container.**

```bash
./cluster/submit.sh check
```

This downloads the container image once and lists the package versions inside it. The log is in `logs/`.

**4. FASTQs to Cell Ranger output.**

```bash
./cluster/submit.sh cellranger
```

This is one long job that starts many smaller ones. It took about 6 hours for us, plus time waiting in the queue. It:

1. Downloads the 10x human reference `refdata-gex-GRCh38-2024-A`.
2. Downloads the 10 sequencing runs from SRA with nf-core/fetchngs 1.13.0.
3. Renames the files the way Cell Ranger expects. From SRA, `_1` is read 1 (the 26 bp barcode and UMI read) and `_2` is read 2 (the cDNA read).
4. Runs Cell Ranger 10.0.0 through nf-core/scrnaseq 4.2.0, one job per sample, with chemistry `SC5P-R2` (10x 5' with a short read 1). Runs from the same sample are combined.
5. Links each sample's output to `data/cellranger/<sample>/outs`, where the notebook looks for it.

Pipeline files go in `pipeline/`. If the job stops partway, submit it again and it continues where it left off. Once the render works, you can delete `pipeline/work/` (about 450 GB of temporary files).

**5. Render the tutorial.**

```bash
./cluster/submit.sh render
```

This takes about 25 minutes and writes `tutorial.html`.

## Samples

Some samples were sequenced in two runs. Both runs go into the same sample.

| Sample | GEO | SRA runs |
|---|---|---|
| control_1 | GSM3823939 | SRR9141212 |
| control_2 | GSM3823940 | SRR9141213, SRR9141214 |
| control_3 | GSM3823941 | SRR9141215, SRR9141216 |
| diabetic_1 | GSM3823942 | SRR9141217 |
| diabetic_2 | GSM3823943 | SRR9141218, SRR9141219 |
| diabetic_3 | GSM3823944 | SRR9141220, SRR9141221 |

## Naming the clusters

Each render writes `results/annotation_proposed.csv`, with a proposed cell type for every cluster. Check it against the marker dot plot, edit the `celltype` column, save it as `annotation_approved.csv` in this folder, and render again.

This folder already has `annotation_approved.csv` from our run. If your clusters come out different from ours, the notebook stops and asks you to delete it and review your own.

## Container

Everything after Cell Ranger runs in `ghcr.io/armilner/r-bioinformatics-2027:sha-dc83161`, the exact image used to make `tutorial.html` (R 4.6.1, Seurat 6.0). `run.sh` starts it with Apptainer on the cluster, or with Docker if you already have the Cell Ranger outputs on a workstation (`./run.sh render`).

## If something goes wrong

- **Cell Ranger says there are "only N free inodes" or not enough disk.** Some cluster file systems report free space wrongly. `cluster/slurm.config` already turns this check off. If you see it anyway, check your real quota.
- **Cell Ranger says read 1 and read 2 must have the same file name.** The renaming step did not run. Look for `pipeline/fastq_cellranger/`.
- **The render stops at the reference step.** Azimuth downloads its kidney reference the first time, so the compute node needs internet.
- **A job is stuck as pending with `ReqNodeNotAvail`.** Its time limit runs into planned maintenance. Lower `--time` in `cluster/submit.sh` or wait.

## Outputs

`tutorial.html`, `results/cluster_markers.csv`, `results/pseudobulk_DE.csv`, `results/gsea.csv`, `results/annotation_proposed.csv`, `results/kidney_snrna_annotated.rds`
