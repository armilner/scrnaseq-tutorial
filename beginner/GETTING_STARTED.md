# Getting started (no experience needed)

This guide takes you from nothing installed to a finished analysis. You won't need to type any commands. It takes about 30 minutes, most of it waiting for installs.

You need a computer (Mac or Windows) with at least 8 GB of RAM and about 5 GB of free space.

## Step 1. Install R

R is the programming language the analysis is written in.

1. Go to https://cran.r-project.org
2. Click **Download R for macOS** or **Download R for Windows**.
   - Mac: pick the `.pkg` file that matches your chip. Apple menu > About This Mac tells you if you have **Apple** (M1, M2, M3...) or **Intel**.
   - Windows: click **base**, then **Download R for Windows**.
3. Open the downloaded file and click through the installer with the default options.

## Step 2. Install RStudio

RStudio is the program you'll actually work in. It gives R a friendly window with buttons. It also includes Quarto, which turns the tutorial into a web page.

1. Go to https://posit.co/download/rstudio-desktop
2. Download RStudio Desktop (free) for your system and install it like any other app.

On Windows you may also need **Rtools** to install some packages: https://cran.r-project.org/bin/windows/Rtools (pick the version that matches your R).

## Step 3. Download this tutorial

1. On the GitHub page of this repository, click the green **Code** button.
2. Click **Download ZIP**.
3. Unzip it somewhere easy to find, like your Desktop or Documents.

(If you already use git, you can `git clone` the repository instead.)

## Step 4. Open the tutorial in RStudio

1. Open RStudio.
2. Go to **File > Open File...**, find the folder you unzipped, open the `beginner` folder, and choose `tutorial_beginner.qmd`.
3. Tell R to work in this folder: **Session > Set Working Directory > To Source File Location**.

RStudio has four panels. The top left shows the tutorial file. The bottom left is the **Console**, where R runs. The right side shows files, plots and help.

## Step 5. Install the packages (once)

Packages are add-ons that do the single-cell work.

1. In the **Files** panel (bottom right), click `install_packages.R` to open it.
2. Click the **Source** button at the top right of that file.
3. Wait. This takes 10 to 20 minutes the first time. Lots of text scrolls by in the Console, which is normal.
4. At the end, every package should say `ok`. If one says `MISSING`, see "If something goes wrong" below.

If RStudio asks "Do you want to install from sources the packages which need compilation?", type `n` and press Enter.

## Step 6. Run the tutorial

You can do this two ways.

**Option A: render everything at once.** Go back to the `tutorial_beginner.qmd` tab and click **Render** at the top. It runs all the steps, which takes about 10 to 20 minutes, then opens `tutorial_beginner.html` with all the results and plots.

**Option B: step by step (best for learning).** Each grey box in the file is a code chunk. Click the small green ▶ arrow at the top right of a chunk to run it, and the result appears below it. Go from top to bottom and read the text between chunks as you go.

Results are saved in the `results` folder.

## If something goes wrong

- **"there is no package called ..."**: run `install_packages.R` again (Step 5).
- **The download in step 1 of the tutorial fails**: check your internet connection and run the chunk again. The data (about 100 MB) only downloads once.
- **Out of memory, or R crashes**: close other programs. 8 GB of RAM is the minimum.
- **Something else**: copy the red error message and search for it, or open an issue on this GitHub repository with the message and what step you were on.

## Prefer VS Code or the terminal?

That works too. Install R plus Quarto (https://quarto.org/docs/get-started), then in a terminal inside the `beginner` folder run:

```bash
Rscript install_packages.R
quarto render tutorial_beginner.qmd
```

In VS Code, install the **R** and **Quarto** extensions to run chunks and preview the result.
