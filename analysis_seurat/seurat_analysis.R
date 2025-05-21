#!/usr/bin/env Rscript

# Chargement des bibliothèques
library(Seurat)
library(dplyr)
library(ggplot2)
library(SeuratObject)
library(SingleCellExperiment)
library(rlang)


# Fonction principale
main <- function(input_file, output_file) {
  # Chargement des données
  cat("Chargement des données...\n")
  sce <- readRDS(input_file)
  
  # Création de l'objet Seurat
  cat("Création de l'objet Seurat...\n")
  seurat_obj <- CreateSeuratObject(counts = assay(sce, "counts"),
                                 project = "PBMC3k",
                                 min.cells = 3,
                                 min.features = 200)
  
  # Calcul des métriques de qualité
  cat("Calcul des métriques de qualité...\n")
  seurat_obj[["percent.mt"]] <- PercentageFeatureSet(seurat_obj, pattern = "^MT-")
  
  # Visualisation des métriques de qualité
  pdf("qc_metrics.pdf", width = 12, height = 8)
  print(VlnPlot(seurat_obj, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3))
  dev.off()
  
  # Filtrage des cellules
  cat("Filtrage des cellules...\n")
  seurat_obj <- subset(seurat_obj, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
  
  # Normalisation des données
  cat("Normalisation des données...\n")
  seurat_obj <- NormalizeData(seurat_obj, normalization.method = "LogNormalize", scale.factor = 10000)
  
  # Identification des gènes variables
  cat("Identification des gènes variables...\n")
  seurat_obj <- FindVariableFeatures(seurat_obj, selection.method = "vst", nfeatures = 2000)
  
  # Visualisation des gènes variables
  pdf("variable_features.pdf", width = 10, height = 8)
  top10 <- head(VariableFeatures(seurat_obj), 10)
  plot1 <- VariableFeaturePlot(seurat_obj, selection.method = "vst")
  plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
  print(plot2)
  dev.off()
  
  # Mise à l'échelle des données
  cat("Mise à l'échelle des données...\n")
  all_genes <- rownames(seurat_obj)
  seurat_obj <- ScaleData(seurat_obj, features = all_genes, vars.to.regress = c("nCount_RNA", "percent.mt"))
  
  # Analyse PCA
  cat("Analyse PCA...\n")
  seurat_obj <- RunPCA(seurat_obj, features = VariableFeatures(object = seurat_obj))

  # Calcul de la variance expliquée par les 40 premières PC
  stdev <- seurat_obj[["pca"]]@stdev
  var_explained <- stdev^2 / sum(stdev^2)
  var_40pc <- sum(var_explained[1:40])
  # Sauvegarde dans un fichier texte
  write(sprintf("Variance expliquée par les 40 premières PC : %.2f%%", var_40pc * 100), file = "variance_40PC.txt")
  cat(sprintf("Variance expliquée par les 40 premières PC : %.2f%%\n", var_40pc * 100))
  
  # Visualisation PCA
  pdf("pca_analysis.pdf", width = 12, height = 8)
  print(VizDimLoadings(seurat_obj, dims = 1:2, reduction = "pca"))
  print(DimPlot(seurat_obj, reduction = "pca"))
  print(DimHeatmap(seurat_obj, dims = 1:15, cells = 500, balanced = TRUE))
  # Ajout d'un texte dans le PDF
  grid::grid.text(sprintf("Variance expliquée par les 40 premières PC : %.2f%%", var_40pc * 100), 
                  x = 0.5, y = 0.05, gp = grid::gpar(fontsize = 14))
  dev.off()
  
  # Détermination de la dimensionnalité
  cat("Détermination de la dimensionnalité...\n")
  seurat_obj <- JackStraw(seurat_obj, num.replicate = 100)
  seurat_obj <- ScoreJackStraw(seurat_obj, dims = 1:20)
  
  # Clustering
  cat("Clustering...\n")
  seurat_obj <- FindNeighbors(seurat_obj, dims = 1:40)
  seurat_obj <- FindClusters(seurat_obj, resolution = 0.5)
  
  # UMAP
  cat("Calcul de l'UMAP...\n")
  seurat_obj <- RunUMAP(seurat_obj, dims = 1:40)
  
  # t-SNE
  cat("Calcul du t-SNE...\n")
  seurat_obj <- RunTSNE(seurat_obj, dims = 1:40)
  
  # Identification des marqueurs de clusters
  cat("Identification des marqueurs de clusters...\n")
  markers <- FindAllMarkers(seurat_obj, 
                          only.pos = TRUE, 
                          min.pct = 0.25, 
                          logfc.threshold = 0.25,
                          layer = "data")
  write.csv(markers, "cluster_markers.csv")
  
  # Annotation des clusters
  cat("Annotation des clusters...\n")
  # Définition des marqueurs connus pour chaque type cellulaire
  cell_type_markers <- list(
    "CD4 T cells" = c("IL7R", "CD4"),
    "CD8 T cells" = c("CD8A", "CD8B", "GZMK"),
    "NK cells" = c("NKG7", "GNLY", "GZMB"),
    "B cells" = c("MS4A1", "CD79A"),
    "Monocytes" = c("CD14", "LYZ", "FCGR3A"),
    "Dendritic cells" = c("FCER1A", "CST3"),
    "Platelets" = c("PPBP", "PF4"),
    "Megakaryocytes" = c("ITGA2B", "PF4"),
    "Erythrocytes" = c("HBB", "HBA1")
  )
  
  # Fonction pour identifier le type cellulaire basé sur les marqueurs
  identify_cell_type <- function(cluster_markers) {
    scores <- sapply(cell_type_markers, function(markers) {
      sum(cluster_markers$gene %in% markers)
    })
    if (max(scores) == 0) return("Unknown")
    names(scores)[which.max(scores)]
  }
  
  # Annotation des clusters
  cluster_annotations <- sapply(levels(Idents(seurat_obj)), function(cluster) {
    cluster_markers <- markers[markers$cluster == cluster, ]
    identify_cell_type(cluster_markers)
  })
  
  # Mise à jour des identités des clusters
  new_cluster_ids <- cluster_annotations[as.character(Idents(seurat_obj))]
  names(new_cluster_ids) <- names(Idents(seurat_obj))
  Idents(seurat_obj) <- new_cluster_ids
  
  # Visualisation des clusters annotés
  pdf("cluster_visualization.pdf", width = 12, height = 8)
  print(DimPlot(seurat_obj, reduction = "umap", label = TRUE, repel = TRUE) + 
        ggtitle("UMAP des clusters annotés"))
  print(DimPlot(seurat_obj, reduction = "tsne", label = TRUE, repel = TRUE) + 
        ggtitle("t-SNE des clusters annotés"))
  
  # Visualisation des marqueurs clés
  key_markers <- c("CD3D", "CD4", "CD8A", "NKG7", "MS4A1", "CD14", "FCGR3A", "FCER1A")
  print(FeaturePlot(seurat_obj, features = key_markers, ncol = 4))
  dev.off()
  
  # Sauvegarde de l'objet Seurat
  cat("Sauvegarde de l'objet Seurat...\n")
  saveRDS(seurat_obj, output_file)
  
  # Sauvegarde des annotations
  write.csv(data.frame(
    Cluster = names(cluster_annotations),
    CellType = cluster_annotations
  ), "cluster_annotations.csv")
  
  cat("Analyse terminée!\n")
}

# Vérification des arguments
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  stop("Usage: Rscript seurat_analysis.R <input_file> <output_file>")
}

# Exécution de l'analyse
main(args[1], args[2]) 