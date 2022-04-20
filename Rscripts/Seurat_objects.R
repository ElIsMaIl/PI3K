library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data & prepare ----
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

## save seurat-objects ----
save(list_seurat_7273m, file = "data/unfilteredSeurat_7273_mouse.Rdata")



# load data & prepare ----
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
## save seurat-objects ----
save(list_seurat_7273h, file = "data/unfilteredSeurat_7273_human.Rdata")
