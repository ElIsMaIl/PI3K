library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data & prepare ----
fnames <- list.files("data/Mouse_unfiltered/", pattern = "1820_Expression_Data_Unfiltered_mouse.st.gz", full.names = T)
list.files("data/Mouse_unfiltered/","1820_Expression_Data_Unfiltered_mouse.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp


list_seurat_1820m <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix

exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")

return(exp)
})
names(list_seurat_1820m) <- names.exp

## save seurat-objects ----
save(list_seurat_1820m, file = "data/unfilteredSeurat_1820_mouse.Rdata")



# load data & prepare ----
fnames <- list.files("data/Mouse_unfiltered/", pattern = "1822_Expression_Data_Unfiltered_mouse.st.gz", full.names = T)
list.files("data/Mouse_unfiltered/","1822_Expression_Data_Unfiltered_mouse.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp


list_seurat_1822m <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")
  
  return(exp)
})
names(list_seurat_1822m) <- names.exp

## save seurat-objects ----
save(list_seurat_1822m, file = "data/unfilteredSeurat_1822_mouse.Rdata")
