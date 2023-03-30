readMetricsSummary <- function(fname){
  input <- readLines(fname)
  meta <- input[startsWith(input, "##")]
  metrics <- input[!startsWith(input, "##")]
  
  metrics <- metrics[metrics != ""]
  data.frame(metrics = metrics) %>% 
    dplyr::mutate(group = ifelse(startsWith(metrics, "#"), metrics, NA)) %>% 
    tidyr::fill(group, .direction = "down") -> df.metrics
  
  df.metrics <- df.metrics[!startsWith(df.metrics$metrics, "#"),]
  list.metrics <- split(df.metrics$metrics, df.metrics$group)
  
  lapply(list.metrics, function(x){
    measure <- unlist(strsplit(x[1], split = ","))
    value <- unlist(strsplit(x[2], split = ","))
    data.frame(measure = measure, value = as.numeric(value[1:length(measure)]))
  }) %>% 
    dplyr::bind_rows(.id = "quality")
}

