library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(rtracklayer)
library(Seurat)
library(knitr)
library(janitor)
library(ggsci)
library(ggpubr)
library(cowplot)
library(DT)
library(biomaRt)
library(gplots)
source("helperFunctions.R")

#---- load data ---- 
load("data/unfilteredSeurat_1820_human.Rdata")
load("data/unfilteredSeurat_1820_mouse.Rdata")

#---- convert mouse to human gene names biomart

convertMouseGeneList <- function(x){
  require("biomaRt")
  human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
  mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
  
  genesV2 = getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = x , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T)
  humanx <- unique(genesV2[, 2])
  return(humanx)
}
head(humanX)

genes <- convertMouseGeneList(list_seurat_1820m[["1820"]]@assays[["RNA"]]@data@Dimnames[[1]])


#---- overlapping data ----

cell_List_human2 <- Cells(list_seurat_1820h[["1820"]]@assays[["RNA"]]@data)
cell_List_mouse2 <- Cells(list_seurat_1820m[["1820"]]@assays[["RNA"]]@data)
 
gene_List_human <- row.names(list_seurat_1820h[["1820"]]@assays[["RNA"]]@data)

#---- create Venn diagramm ----
venn_1820 <- venn(list(Human = gene_List_human,
                       Mouse = genes))

venn_1822 <- venn(list(Human = gene_List_human1822,
                       Mouse = gene_List_mouse1822))


#---- Intersection ----

isect1820 <- attr(venn_1820, "intersections")
view(isect1820)
