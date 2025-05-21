# Python Analysis Pipeline (Scanpy)

This directory contains the Python-based analysis pipeline using Scanpy for single-cell RNA-seq data analysis.

## Pipeline Steps

1. **Data Exploration** (`data_exploration.ipynb`)
   - Load and explore the PBMC3k dataset
   - Basic quality control metrics
   - Initial data visualization
   - Data preprocessing steps

2. **Generate Seurat Object** (`generate_seurat_object.py`)
   - Convert Scanpy AnnData object to Seurat-compatible format
   - Save the object for R analysis
   - Ensure compatibility between Python and R pipelines

## Requirements

- Python 3.8+
- Dependencies listed in `requirements.txt`:
  - scanpy
  - anndata
  - numpy
  - pandas
  - scipy
  - matplotlib
  - seaborn
  - scikit-learn

## Usage

1. Create and activate the conda environment:
```bash
conda env create -f environment.yml
conda activate sc-rnaseq
```

2. Run the Jupyter notebook for data exploration:
```bash
jupyter notebook data_exploration.ipynb
```

3. Generate Seurat object:
```bash
python generate_seurat_object.py
```

## Output Files

- `data_exploration.ipynb`: Interactive notebook with analysis results
- Generated Seurat object for R analysis
- Various plots and visualizations in the notebook

## Notes

- The pipeline is designed to work with the PBMC3k dataset
- Results are compatible with the R/Seurat pipeline
- All visualizations are generated within the Jupyter notebook 