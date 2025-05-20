options(repos = c(CRAN = "https://cloud.r-project.org"))

if (!requireNamespace('BiocManager', quietly = TRUE)) {
    install.packages('BiocManager')
}

BiocManager::install(c(
    'scater',
    'scran',
    'SingleCellExperiment',
    'Seurat',
    'SC3',
    'CountClust',
    'RCA',
    'RaceID2',
    'RaceID',
    'SIMLR',
    'TSCAN',
    'ascend',
    'cellranger',
    'cidr'
), update = FALSE) 