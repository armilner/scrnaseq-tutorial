# Run once: Rscript install_packages.R
# Installs everything the beginner tutorial needs.

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

cran <- c("Seurat", "presto", "harmony", "msigdbr", "ggplot2", "dplyr", "rmarkdown", "knitr")
bioc <- c("SingleCellExperiment", "muscData", "celda", "scDblFinder", "scuttle",
          "SingleR", "celldex", "DESeq2", "fgsea", "glmGamPoi")

BiocManager::install(c(cran, bioc), ask = FALSE, update = FALSE)

# check
for (p in c(cran, bioc)) {
  cat(p, if (requireNamespace(p, quietly = TRUE)) "ok" else "MISSING", "\n")
}
