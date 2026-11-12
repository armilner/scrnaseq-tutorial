# Run inside the container first. Reports what the notebook needs and what is missing.
pkgs <- c("Seurat", "SeuratObject", "sctransform", "glmGamPoi", "harmony", "SoupX",
          "scDblFinder", "SingleCellExperiment", "scuttle", "DESeq2", "fgsea",
          "msigdbr", "clusterProfiler", "presto", "Matrix", "ggplot2", "patchwork",
          "dplyr", "knitr", "rmarkdown")
optional <- c("Azimuth", "SeuratData", "msigdbdf", "quarto")
status <- function(p) if (requireNamespace(p, quietly = TRUE)) as.character(packageVersion(p)) else "MISSING"
cat("R:", R.version.string, "\n\nRequired\n")
print(data.frame(package = pkgs, version = vapply(pkgs, status, "")), row.names = FALSE)
cat("\nOptional\n")
print(data.frame(package = optional, version = vapply(optional, status, "")), row.names = FALSE)
cat("\nquarto CLI:", Sys.which("quarto"), "\n")
