# Single-Cell RNA-seq Analysis

This repository contains the analysis of single-cell RNA sequencing data using both Python (Scanpy) and R (Seurat) approaches.

## Project Structure

```
.
├── analysis_python/          # Python-based analysis using Scanpy
│   ├── environment.yml      # Conda environment file
│   ├── requirements.txt     # Python package requirements
│   ├── data_exploration.ipynb  # Jupyter notebook for data exploration
│   └── generate_seurat_object.py  # Script to generate Seurat object
├── analysis_seurat/         # R-based analysis using Seurat
│   ├── seurat_analysis.R    # Seurat analysis script
│   ├── install_packages.R   # R package installation script
│   ├── cluster_annotations.csv  # Cluster annotations
│   └── cluster_markers.csv  # Cluster markers
└── comparison_report.md     # Detailed comparison of both approaches
```

## Setup

### Python Environment
```bash
conda env create -f analysis_python/environment.yml
conda activate sc-rnaseq
```

### R Environment
```bash
Rscript analysis_seurat/install_packages.R
```

## Usage

1. Generate Seurat object from PBMC3k data:
```bash
python analysis_python/generate_seurat_object.py
```

2. Run Seurat analysis:
```bash
Rscript analysis_seurat/seurat_analysis.R
```

## Results

The analysis results are stored in their respective directories:
- `analysis_python/`: Python/Scanpy results
- `analysis_seurat/`: R/Seurat results

A detailed comparison of both approaches can be found in `comparison_report.md`.

## Dataset

This project uses the PBMC3k dataset from 10x Genomics, which contains approximately 2,700 peripheral blood mononuclear cells (PBMCs). This dataset is commonly used as a reference for single-cell RNA-seq analysis.

### Dataset Characteristics
- **Cell Type**: Peripheral Blood Mononuclear Cells (PBMCs)
- **Number of Cells**: ~2,700
- **Technology**: 10x Genomics Chromium Single Cell 3' v2
- **Organism**: Human
- **Tissue**: Peripheral Blood
- **Publication Year**: 2017

### Cell Types Present
- T cells (CD4+ and CD8+)
- B cells
- NK cells
- Monocytes
- Dendritic cells
- Platelets

Source: 10x Genomics (https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k) 