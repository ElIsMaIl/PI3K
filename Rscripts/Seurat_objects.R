library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data ----
#Human
fname <- list.files("data/Human_unfiltered/", pattern = "*.st.gz", full.names = T)
names.exp <- list.files("data/Human_unfiltered/","*.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1]


list_seurat <- lapply(1:length(fname), function(id){
  df_expression <- read.table(fname[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
sparse_matrix <- df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules")

exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")

return(exp)
})

#Mouse
fname_mouse <- list.files("data/Mouse_unfiltered/", pattern = "*.st.gz", full.names = T)
names.exp_mouse <- list.files("data/Mouse_unfiltered/","*.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1]


list_seurat <- lapply(1:length(fname_mouse), function(id){
  df_expression <- read.table(fname_mouse[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  sparse_matrix <- df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules")
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp_mouse[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")
  
  return(exp)
})


# save seurat-objects
save(list_seurat, file = "data/unfilteredSeurat_full.Rdata")
save(list_seurat, file = "data/unfilteredSeurat_full_mouse.Rdata")
