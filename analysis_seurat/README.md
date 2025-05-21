# Pipeline d'Analyse R (Seurat)

Ce répertoire contient le pipeline d'analyse basé sur R utilisant Seurat pour l'analyse de données RNA-seq single-cell.

## Étapes du Pipeline

1. **Installation des Packages** (`install_packages.R`)
   - Installation et chargement des packages R requis
   - Configuration de l'environnement R pour l'analyse

2. **Analyse Seurat** (`seurat_analysis.R`)
   - Chargement et prétraitement des données
   - Contrôle qualité et filtrage
   - Normalisation et sélection des caractéristiques
   - Réduction de dimensionnalité (ACP)
   - Analyse de clustering
   - Annotation des types cellulaires
   - Visualisation des résultats

## Fichiers de Sortie

### Visualisations PDF
- `qc_metrics.pdf` : Graphiques des métriques de contrôle qualité
- `variable_features.pdf` : Visualisation des caractéristiques variables
- `pca_analysis.pdf` : Résultats de l'analyse en composantes principales
- `cluster_visualization.pdf` : Résultats du clustering et annotations des types cellulaires

### Fichiers de Données
- `cluster_markers.csv` : Gènes marqueurs pour chaque cluster
- `cluster_annotations.csv` : Annotations des types cellulaires pour chaque cluster

## Prérequis

- R 4.0+
- Dépendances (installées via `install_packages.R`) :
  - Seurat
  - dplyr
  - ggplot2
  - Matrix
  - patchwork
  - SeuratObject

## Utilisation

1. Installer les packages requis :
```bash
Rscript install_packages.R
```

2. Exécuter l'analyse Seurat :
```bash
Rscript seurat_analysis.R
```

## Étapes d'Analyse

1. **Contrôle Qualité**
   - Filtrage des cellules basé sur les métriques de QC
   - Suppression des cellules et gènes de faible qualité
   - Génération des visualisations de QC

2. **Traitement des Données**
   - Normalisation des données
   - Identification des caractéristiques variables
   - Mise à l'échelle des données
   - Exécution de l'ACP

3. **Clustering**
   - Recherche des voisins
   - Identification des clusters
   - Génération de la visualisation UMAP

4. **Annotation des Types Cellulaires**
   - Identification des gènes marqueurs
   - Annotation des types cellulaires
   - Génération des visualisations de clusters

## Notes

- Le pipeline est conçu pour fonctionner avec le jeu de données PBMC3k
- Les résultats sont compatibles avec le pipeline Python/Scanpy
- Toutes les visualisations sont sauvegardées en fichiers PDF
- Les annotations de clusters et les marqueurs sont sauvegardés en fichiers CSV 