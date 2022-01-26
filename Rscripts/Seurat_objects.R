library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data & prepare ----
fnames <- list.files("data/Mouse_unfiltered/", pattern = "7271_Expression_Data_Unfiltered_mouse.st.gz", full.names = T)
list.files("data/Mouse_unfiltered/","7271_Expression_Data_Unfiltered_mouse.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp


list_seurat_7271m <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix

exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^mt-")

return(exp)
})
names(list_seurat_7271m) <- names.exp

str(list_seurat_7271m)

## save seurat-objects ----
save(list_seurat_7271m, file = "data/unfilteredSeurat_7271_mouse.Rdata")



# load data & prepare ----
fnames <- list.files("data/7271_unfiltered/", pattern = "*.st.gz", full.names = T)
list.files("data/7270_unfiltered/","*.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp


list_seurat_7271 <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")
  
  return(exp)
})
names(list_seurat_7271) <- names.exp

str(list_seurat_7271)
## save seurat-objects ----
save(list_seurat_7271, file = "data/unfilteredSeurat_7271.Rdata")
