#!/usr/bin/env python3

import scanpy as sc
import anndata2ri
from rpy2.robjects import r
import os

def main():
    # Charger les données PBMC3k
    print("Chargement des données PBMC3k...")
    adata = sc.datasets.pbmc3k()
    
    # Convertir en objet R
    print("Conversion en objet R...")
    anndata2ri.activate()
    r['saveRDS'](adata, "pbmc3k_seurat.rds")
    
    # Déplacer le fichier dans le dossier Seurat
    print("Déplacement du fichier...")
    os.makedirs("../analysis_seurat", exist_ok=True)
    os.rename("pbmc3k_seurat.rds", "../analysis_seurat/pbmc3k_seurat.rds")
    
    print("Terminé ! Le fichier a été généré dans analysis_seurat/pbmc3k_seurat.rds")

if __name__ == "__main__":
    main() 