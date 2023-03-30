library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)


# load data & preparing Seurat objects for mouse samples----
# to create the individual seurat objects for the different samples change the pattern in list.files() by changing the sample number (1820,1822,7270,7271,7272,7273)
fnames <- list.files("E://CCCC/PI3K/data/SuplementaryFiles/ExpressionData/Mouse/", pattern = "1822_Expression_Data_Unfiltered_mouse.st", full.names = T)
list.files("E://CCCC/PI3K/data/SuplementaryFiles/ExpressionData/Mouse/","1822_Expression_Data_Unfiltered_mouse.st", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp

#change suffix sample number in list_seurat_samplenumber
list_seurat_1822m <- lapply(1:length(fnames), function(id){
  df_expression <- read.table(fnames[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^mt-")
  
  return(exp)
})
names(list_seurat_1822m) <- names.exp

str(list_seurat_1822m)

## save seurat-objects
save(list_seurat_1822m, file = "E://CCCC/PI3K/data/SeuratObjects/unfiltered/Mouse/unfilteredSeurat_1822_mouse.Rdata")