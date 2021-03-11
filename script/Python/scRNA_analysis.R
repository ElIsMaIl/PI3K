# Load librarys

library(scran)
library(Matrix)
library(plyr)
library(dplyr)
library(tidyr)
library(RColorBrewer)
library(slingshot)
library(monocle)
library(gam)
library(clusterExperiment)
library(ggplot2)
library(MAST)
library(data.table)
library(readr)
library(purrr)

# reading in the data
#df_read_per_gene <- read.csv2("/home/elismail/Dokumente/scRNA-Data/scRNA_Tutorial/Human_expression_data/untreated/Combined_1820_RSEC_ReadsPerCell.csv", comment = '#')
#df_mols_per_gene <- read.csv2("/home/elismail/Dokumente/scRNA-Data/scRNA_Tutorial/Human_expression_data/untreated/Combined_1820_RSEC_MolsPerCell.csv", comment = '#')
df_expression <- read.table("/home/elismail/Dokumente/scRNA-Data/scRNA_Tutorial/1820_Expression_Data.st", sep= "\t", header=TRUE)

#df_split <- split(df_mols_per_gene, f = names(df_mols_per_gene))

#removes the columns RSEC_Reads and Molecules
df_expression <- df_expression[,-(3:4),drop=FALSE]

# transpose the dataframe before: Cell_Index = rows & Gene = columns, after: Cell_Index = columns and Gene = rows
#df_mols_per_gene_transpose <- transpose(df_mols_per_gene)
#rownames(df_mols_per_gene_transpose) <- colnames(df_mols_per_gene)
#colnames(df_mols_per_gene_transpose) <- rownames(df_mols_per_gene)

# convert the dataframe in long format (increasing the number of columns and decreasing the number of rows) and set the gene column as #rownames first
#mat <- df_expression %>% pivot_wider(id_cols = Gene,values_from = RSEC_Adjusted_Molecules,names_from = Cell_Index,values_fill = 0) %>% tibble::column_to_rownames("Gene")

sparse_matrix <- Reduce(cbind2, lapply(df_expression[,-1], Matrix, sparse=TRUE))
rownames(sparse_matrix) <- df_expression[,1]
