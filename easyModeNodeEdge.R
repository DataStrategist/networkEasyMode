## This function takes inputs and converts them from a data.frame like FROM TO VALUE into two dataframes:
## Nodes and Edges. This is suitable for the packages VisNetwork and network3d. 

## output will be a list containing both dataframes

## The indexing is important. By default, the edges will be 1-indexed (for VisNetwork), but if you're using it with
## network3d, change the indexing to 0

easyMode <- function(df,Index=1){
  df <- as.data.frame(df)
  nodes <- data.frame(name=df[,1:2] %>% unlist %>% as.character() %>% unique())
  nodes[,1] <- as.character(nodes[,1])
  #nodes$id <- row_number(nodes)
  
  ## and match to IDs to make edges
  edges <- data.frame(from= match(as.character(df[,1]),nodes$name),
                      to=   match(as.character(df[,2]),nodes$name),
                      value=df[,3])
  
  ## indexing
  if (Index==0){
    edges$from <- as.integer(edges$from - 1)
    edges$to <- as.integer(edges$to - 1)
  }
  list(nodes=nodes,edges=edges)
}
