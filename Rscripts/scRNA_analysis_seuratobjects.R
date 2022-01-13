library(Matrix)
library(Matrix.utils)
library(tidyverse)
library(Seurat)
## load and prepare data ----
fname <- list.files("data", "Unfiltered.st.gz", full.names = TRUE)
list.files("data", "Unfiltered.st.gz", full.names = FALSE) %>% 
  str_split(pattern = "_", simplify = T) %>% .[,1] -> names.exp

# ToDo: make sure the pattern for mt works for human/mouse
list_seurat <- lapply(1:length(fname), function(id){
  df_expression <- read.table(fname[id], sep= "\t", header=TRUE)
  df_expression <- df_expression[,-(3:4),drop=FALSE]
  
  df_expression %>% 
    mutate(Cell_Index = as.character(Cell_Index)) %>% 
    dMcast(Gene~Cell_Index, value.var = "RSEC_Adjusted_Molecules") -> sparse_matrix
  
  exp <- CreateSeuratObject(sparse_matrix, project = names.exp[id], min.cells = 3, min.features = 200)
  exp[["percent.mt"]] <- PercentageFeatureSet(exp, pattern = "^MT-")
  
  return(exp)
})
names(list_seurat) <- names.exp

# save seurat-objects
save(list_seurat, file = "data/unfilteredSeurat_full.Rdata")

## compare number of cells with filtered list ----
fname <- "data/1822_Expression_Data.st"
df_expression <- read.table(fname, sep= "\t", header=TRUE)
df_expression %>% 
  summarize(n = n_distinct(Cell_Index))

colnames(list_seurat[[2]]) %>% 
  enframe(value = "Cell_Index") %>% 
  mutate(Cell_Index = str_remove(string = Cell_Index, pattern = "Cell_Index")) %>% 
  left_join(df_expression %>% select(Cell_Index) %>% 
              distinct() %>% mutate(Cell_Index = as.character(Cell_Index),
                                    test = TRUE)) %>% 
  filter(is.na(test)) 

