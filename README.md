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

# Rapport Comparatif : Analyse Python vs Seurat

## 1. Méthodologie

### Approche Python (scanpy)
- **Prétraitement** : Normalisation et filtrage des données
- **Analyse** : 
  - Calcul du score de silhouette pour évaluer la cohérence des clusters
  - Analyse des distances au centre des clusters
  - Visualisation UMAP avec coloration par type cellulaire
- **Points forts** :
  - Évaluation quantitative de la qualité des clusters
  - Analyse de la cohérence interne des clusters
  - Visualisation des distances au centre

### Approche Seurat
- **Prétraitement** :
  - Filtrage basé sur les métriques de qualité (nFeature_RNA, percent.mt)
  - Normalisation LogNormalize
  - Identification des gènes variables
- **Analyse** :
  - PCA et détermination de la dimensionnalité
  - Clustering avec l'algorithme de Louvain
  - UMAP pour la visualisation
  - Identification des marqueurs de clusters
  - Annotation automatique des types cellulaires
- **Points forts** :
  - Pipeline complet d'analyse
  - Annotation automatique des types cellulaires
  - Visualisations détaillées à chaque étape

## 2. Résultats

### Métriques de Qualité
- **Seurat** :
  - Filtrage : nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5
  - Visualisation des métriques de qualité dans `qc_metrics.pdf`
  - Identification de 2000 gènes variables

### Clustering
- **Seurat** :
  - 9 clusters identifiés
  - Résolution de clustering : 0.5
  - Modularité maximale : 0.8674
- **Python** :
  - Évaluation de la cohérence des clusters via score de silhouette
  - Analyse des distances au centre pour chaque type cellulaire

### Annotation des Types Cellulaires
- **Seurat** :
  - Annotation automatique basée sur des marqueurs connus
  - Types cellulaires identifiés :
    - CD4 T cells
    - CD8 T cells
    - NK cells
    - B cells
    - Monocytes
    - Dendritic cells
    - Platelets
    - Megakaryocytes
    - Erythrocytes

## 3. Visualisations

### Seurat
- `qc_metrics.pdf` : Métriques de qualité
- `variable_features.pdf` : Top 10 gènes variables
- `pca_analysis.pdf` : Résultats PCA
- `cluster_visualization.pdf` : UMAP des clusters annotés

### Python
- Visualisation UMAP des types cellulaires
- Carte de chaleur des distances au centre des clusters

## 4. Avantages et Limites

### Approche Python
**Avantages** :
- Évaluation quantitative de la qualité des clusters
- Analyse plus approfondie de la cohérence des clusters
- Flexibilité pour des analyses personnalisées

**Limites** :
- Moins de visualisations automatiques
- Pas d'annotation automatique des types cellulaires

### Approche Seurat
**Avantages** :
- Pipeline complet et bien établi
- Annotation automatique des types cellulaires
- Visualisations détaillées à chaque étape
- Identification des marqueurs de clusters

**Limites** :
- Moins d'outils pour l'évaluation quantitative des clusters
- Moins flexible pour des analyses personnalisées

## 5. Conclusion

Les deux approches sont complémentaires :
- L'approche Seurat fournit un pipeline complet avec annotation automatique
- L'approche Python permet une évaluation plus approfondie de la qualité des clusters

Recommandation : Utiliser les deux approches en parallèle pour une analyse plus complète :
1. Seurat pour le pipeline principal et l'annotation
2. Python pour l'évaluation quantitative de la qualité des clusters 