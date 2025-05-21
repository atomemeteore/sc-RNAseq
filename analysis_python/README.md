# Pipeline d'Analyse Python (Scanpy)

Ce répertoire contient le pipeline d'analyse basé sur Python utilisant Scanpy pour l'analyse de données RNA-seq single-cell.

## Étapes du Pipeline

1. **Exploration des Données** (`data_exploration.ipynb`)
   - Chargement et exploration du jeu de données PBMC3k
   - Métriques de contrôle qualité de base
   - Visualisation initiale des données
   - Étapes de prétraitement des données

2. **Génération de l'Objet Seurat** (`generate_seurat_object.py`)
   - Conversion de l'objet AnnData de Scanpy au format compatible Seurat
   - Sauvegarde de l'objet pour l'analyse R
   - Assurer la compatibilité entre les pipelines Python et R

## Prérequis

- Python 3.8+
- Dépendances listées dans `requirements.txt` :
  - scanpy
  - anndata
  - numpy
  - pandas
  - scipy
  - matplotlib
  - seaborn
  - scikit-learn

## Utilisation

1. Créer et activer l'environnement conda :
```bash
conda env create -f environment.yml
conda activate sc-rnaseq
```

2. Exécuter le notebook Jupyter pour l'exploration des données :
```bash
jupyter notebook data_exploration.ipynb
```

3. Générer l'objet Seurat :
```bash
python generate_seurat_object.py
```

## Fichiers de Sortie

- `data_exploration.ipynb` : Notebook interactif avec les résultats d'analyse
- Objet Seurat généré pour l'analyse R
- Divers graphiques et visualisations dans le notebook

## Notes

- Le pipeline est conçu pour fonctionner avec le jeu de données PBMC3k
- Les résultats sont compatibles avec le pipeline R/Seurat
- Toutes les visualisations sont générées dans le notebook Jupyter 