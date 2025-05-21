# R Analysis Pipeline (Seurat)

This directory contains the R-based analysis pipeline using Seurat for single-cell RNA-seq data analysis.

## Pipeline Steps

1. **Package Installation** (`install_packages.R`)
   - Install and load required R packages
   - Set up the R environment for analysis

2. **Seurat Analysis** (`seurat_analysis.R`)
   - Load and preprocess the data
   - Quality control and filtering
   - Normalization and feature selection
   - Dimensionality reduction (PCA)
   - Clustering analysis
   - Cell type annotation
   - Visualization of results

## Output Files

### PDF Visualizations
- `qc_metrics.pdf`: Quality control metrics plots
- `variable_features.pdf`: Top variable features visualization
- `pca_analysis.pdf`: PCA analysis results
- `cluster_visualization.pdf`: Clustering results and cell type annotations

### Data Files
- `cluster_markers.csv`: Marker genes for each cluster
- `cluster_annotations.csv`: Cell type annotations for each cluster

## Requirements

- R 4.0+
- Dependencies (installed via `install_packages.R`):
  - Seurat
  - dplyr
  - ggplot2
  - Matrix
  - patchwork
  - SeuratObject

## Usage

1. Install required packages:
```bash
Rscript install_packages.R
```

2. Run the Seurat analysis:
```bash
Rscript seurat_analysis.R
```

## Analysis Steps

1. **Quality Control**
   - Filter cells based on QC metrics
   - Remove low-quality cells and genes
   - Generate QC visualizations

2. **Data Processing**
   - Normalize the data
   - Identify variable features
   - Scale the data
   - Run PCA

3. **Clustering**
   - Find neighbors
   - Identify clusters
   - Generate UMAP visualization

4. **Cell Type Annotation**
   - Identify marker genes
   - Annotate cell types
   - Generate cluster visualizations

## Notes

- The pipeline is designed to work with the PBMC3k dataset
- Results are compatible with the Python/Scanpy pipeline
- All visualizations are saved as PDF files
- Cluster annotations and markers are saved as CSV files 