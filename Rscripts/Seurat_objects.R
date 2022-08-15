library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data & preparing Seurat objects for mouse samples----
fnames <- list.files("data/Mouse_unfiltered/", pattern = "7273_Expression_Data_Unfiltered_mouse.st.gz", full.names = T)
list.files("data/Mouse_unfiltered/","7273_Expression_Data_Unfiltered_mouse.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp


list_seurat_7273m <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix

exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^mt-")

return(exp)
})
names(list_seurat_7273m) <- names.exp

str(list_seurat_7273m)

## save seurat-objects
save(list_seurat_7273m, file = "data/unfilteredSeurat_7273_mouse.Rdata")


# load data & preparing Seurat objects for human samples----
fnames <- list.files("data/Human_unfiltered/", pattern = "7273_Expression_Data_Unfiltered.st.gz", full.names = T)
list.files("data/Human_unfiltered/","7273_Expression_Data_Unfiltered.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp

list_seurat_7273h <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")
  
  return(exp)
})
names(list_seurat_7273h) <- names.exp

str(list_seurat_7273h)

## save seurat-objects
save(list_seurat_7273h, file = "data/unfilteredSeurat_7273_human.Rdata")

# load different seurat objects and merge them (human samples)----
load("data/unfilteredSeurat_1820_human.Rdata")
load("data/unfilteredSeurat_1822_human.Rdata")
load("data/unfilteredSeurat_7270_human.Rdata")
load("data/unfilteredSeurat_7271_human.Rdata")
load("data/unfilteredSeurat_7272_human.Rdata")
load("data/unfilteredSeurat_7273_human.Rdata")

## merged objects
mergedseurat_samples <- merge(x = list_seurat_1820h[[1]], y = c(list_seurat_1822h[[1]],list_seurat_7270h[[1]],list_seurat_7271h[[1]],list_seurat_7272h[[1]],list_seurat_7273h[[1]]), add.cell.ids = c("1820", "1822", "7270", "7271", "7272", "7273"), project = "HNSCC")

## add additional metadata to the merged Seurat object 

mergedseurat_samples$log10GenesPerUMI <- log10(mergedseurat_samples$nFeature_RNA) / log10(mergedseurat_samples$nCount_RNA)

metadata <- mergedseurat_samples@meta.data
metadata$cells <- rownames(metadata)
metadata$sample <- NA
metadata$sample[which(str_detect(metadata$cells, "^1820_"))] <- "1820"
metadata$sample[which(str_detect(metadata$cells, "^1822_"))] <- "1822"
metadata$sample[which(str_detect(metadata$cells, "^7270_"))] <- "7270"
metadata$sample[which(str_detect(metadata$cells, "^7271_"))] <- "7271"
metadata$sample[which(str_detect(metadata$cells, "^7272_"))] <- "7272"
metadata$sample[which(str_detect(metadata$cells, "^7273_"))] <- "7273"

metadata <- metadata %>%
  dplyr::rename(seq_folder = orig.ident,
                nUMI = nCount_RNA,
                nGene = nFeature_RNA)

mergedseurat_samples@meta.data <- metadata


## save merged seurat object

save(mergedseurat_samples, file="data/mergedseurat_samples.RData")