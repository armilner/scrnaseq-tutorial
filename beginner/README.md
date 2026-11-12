# Beginner tutorial

A complete single-cell RNA-seq analysis that you can run on your own laptop. No experience needed.

**[Read the finished tutorial online](https://armilner.github.io/scrnaseq-tutorial/beginner/tutorial.html)** if you only want to look at the results.

## What you'll do

The data is blood cells from 8 people. Each person's cells were split in two: one half left alone and one half treated with interferon (an immune signal). We find out which cell types are present and what changes in each one after treatment.

Along the way you'll learn every standard step: cleaning the data, removing doublets, quality control, normalization, integration, clustering, naming cell types, comparing conditions, and pathway analysis.

## What's in this folder

| File | What it is |
|---|---|
| `tutorial.qmd` | **The tutorial.** Open this in RStudio. |
| `install_packages.R` | Installs everything the tutorial needs. Run it once. |
| `tutorial.html` | The finished result, the same as the online version. |
| `annotation_approved.csv` | The cell type names we checked by hand (step 9 of the tutorial). |

You need a Mac or Windows computer with at least 8 GB of RAM and about 5 GB of free space. Setup takes about 30 minutes, most of it waiting for installs.

## Step 1. Install R

R is the programming language the analysis is written in.

1. Go to https://cran.r-project.org
2. Click **Download R for macOS** or **Download R for Windows**.
   - Mac: pick the `.pkg` that matches your chip. Apple menu > About This Mac tells you if you have **Apple** (M1, M2, M3...) or **Intel**.
   - Windows: click **base**, then **Download R for Windows**.
3. Open the downloaded file and click through the installer with the default options.

## Step 2. Install RStudio

RStudio is the program you'll work in. It gives R a friendly window with buttons.

1. Go to https://posit.co/download/rstudio-desktop
2. Download RStudio Desktop (free) and install it like any other app.

On Windows you may also need **Rtools**: https://cran.r-project.org/bin/windows/Rtools (pick the version that matches your R).

## Step 3. Download this tutorial

1. Go to the [main page of this repository](https://github.com/armilner/scrnaseq-tutorial).
2. Click the green **Code** button, then **Download ZIP**.
3. Unzip it somewhere easy to find, like your Desktop or Documents.

## Step 4. Open the tutorial in RStudio

1. Open RStudio.
2. Go to **File > Open File...**, open the `beginner` folder you just unzipped, and choose `tutorial.qmd`.
3. Go to **Session > Set Working Directory > To Source File Location**. This tells R where your files are.

## Step 5. Install the packages (only once)

1. Go to **File > Open File...** and open `install_packages.R` from the same folder.
2. Click the **Source** button at the top right of that file.
3. Wait 10 to 20 minutes. Lots of text scrolls by at the bottom, which is normal.
4. At the end, every package should say `ok`.

If RStudio asks "Do you want to install from sources the packages which need compilation?", type `n` and press Enter.

## Step 6. Run the tutorial

Go back to the `tutorial.qmd` tab. You can run it two ways.

- **Step by step (best for learning).** Each grey box is a piece of code. Click the green ▶ arrow at the top right of a box to run it, and the result appears underneath. Work from top to bottom and read the text between the boxes.
- **All at once.** Click **Render** at the top. After 10 to 20 minutes it opens the finished tutorial with every plot and result.

Results are saved in a new `results` folder.

## If something goes wrong

- **"there is no package called ..."**: run Step 5 again.
- **The data download fails**: check your internet and run that box again. The data (about 100 MB) only downloads once.
- **R crashes or runs out of memory**: close other programs. 8 GB of RAM is the minimum.
- **Anything else**: [open an issue](https://github.com/armilner/scrnaseq-tutorial/issues) with the error message and the step you were on.

## Prefer the terminal or VS Code?

Install R and [Quarto](https://quarto.org/docs/get-started), then from inside this folder run:

```bash
Rscript install_packages.R
quarto render tutorial.qmd
```

## Data

Kang et al. 2018, *Nature Biotechnology*. Downloaded automatically through the Bioconductor package `muscData`.
