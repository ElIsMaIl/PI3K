library("tidyverse")
library("rtracklayer")
library("readr")


## load data ----
# is there a more elegant way to import the data?
#fnames <- list.files("data/Gtf_Annotation/Human/", pattern = "*.gtf", full.names = T)
# gtfs <- lapply(fnames, read_csv)


# Human data
gtf_nlc <- as.data.frame(import("data/Gtf_Annotation/Human/gencode.v29.long_noncoding_RNAs.gtf"))
gtf_pri <- as.data.frame(import("data/Gtf_Annotation/Human/gencode.v29.primary_assembly.annotation.gtf"))
gtf_chr <- as.data.frame(import("data/Gtf_Annotation/Human/gencode.v29.annotation.gtf"))

# Mouse data
nlc_mouse <- as.data.frame(import("data/Gtf_Annotation/Mouse/gencode.vM19.long_noncoding_RNAs.gtf"))
pri_mouse <- as.data.frame(import("data/Gtf_Annotation/Mouse/gencode.vM19.primary_assembly.annotation.gtf"))
chr_mouse <- as.data.frame(import("data/Gtf_Annotation/Mouse/gencode.vM19.annotation.gtf"))

## select gene_type column and count the appearance of the different gene_types
# Human
gtf_nlc <- select(gtf_nlc, gene_type) %>% count(gene_type)
gtf_pri <- select(gtf_pri, gene_type) %>% count(gene_type)
gtf_chr <- select(gtf_chr, gene_type) %>% count(gene_type)

# Mouse
nlc_mouse <- select(nlc_mouse, gene_type) %>% count(gene_type)
pri_mouse <- select(pri_mouse, gene_type) %>% count(gene_type)
chr_mouse <- select(chr_mouse, gene_type) %>% count(gene_type)

## combine dataframes to one table ----
# Human
table_gtfs <- full_join(gtf_nlc, gtf_pri, by = 'gene_type', all=TRUE) %>%
 full_join(., gtf_chr, by = 'gene_type', all=TRUE)

names(table_gtfs) <- c("Gene_Type", "gtf_nlc", "gtf_pri", "gtf_chr")

# Mouse

table_mouse <- full_join(nlc_mouse, pri_mouse, by = 'gene_type', all=TRUE) %>%
  full_join(., chr_mouse, by='gene_type', all=TRUE)

names(table_mouse) <- c("Gene_Type", "gtf_nlc", "gtf_pri", "gtf_chr")


# doesnt work - why?
#table_gtfs <- as_tibble(table_gtfs)

#table_gtfs <- rename(
                #n.x = gtf_nlc,
                #n.y = gtf_pri,
                #n   = gtf_chr
                #)

## safe table

write.csv2(table_gtfs, file='E:\\PI3k/data/Gtf_Annotation/gtf_table.csv')
write.csv2(table_mouse, file='E:\\PI3K/data/Gtf_Annotation/gtf_table_mouse.csv')