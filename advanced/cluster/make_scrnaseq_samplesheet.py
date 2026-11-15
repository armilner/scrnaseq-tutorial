"""Build the nf-core/scrnaseq samplesheet from fetchngs output.
Usage: python3 make_scrnaseq_samplesheet.py <fetchngs_outdir>/samplesheet/samplesheet.csv sra_runs.tsv > samplesheet_scrnaseq.csv
Runs of the same sample share a row name, so scrnaseq merges them into one cellranger count.

Cell Ranger only accepts Illumina-style names (..._R1_001.fastq.gz), but SRA files end in
_1/_2. So we make links with the right names in fastq_cellranger/ and point the sheet at those.
SRA _1 is the 26 bp barcode+UMI read (R1) and _2 is the 91 bp cDNA read (R2)."""
import csv, os, sys
fetch, runs = sys.argv[1], sys.argv[2]
srr2sample = {r["srr"]: r["sample"] for r in csv.DictReader(open(runs), delimiter="\t")}
rows = list(csv.DictReader(open(fetch)))
link_dir = os.path.abspath("fastq_cellranger")
os.makedirs(link_dir, exist_ok=True)
w = csv.writer(sys.stdout); w.writerow(["sample", "fastq_1", "fastq_2"])
seen = set()
for r in rows:
    srr = r["run_accession"]
    if srr not in srr2sample: sys.exit(f"unexpected run {srr}")
    seen.add(srr)
    links = []
    for read, src in (("R1", r["fastq_1"]), ("R2", r["fastq_2"])):
        link = os.path.join(link_dir, f"{srr}_S1_L001_{read}_001.fastq.gz")
        if os.path.lexists(link): os.remove(link)
        os.symlink(os.path.abspath(src), link)
        links.append(link)
    w.writerow([srr2sample[srr]] + links)
missing = set(srr2sample) - seen
if missing: sys.exit(f"missing runs: {sorted(missing)}")
