# Collab net
library(igraph)
tu_nodes <- read.csv("data/maps/tu_nodes.csv", header = T, as.is = T, sep = ";")
tu_edges <- read.csv("data/maps/tu_edges.csv", header = T, as.is =T, 
                     sep = ";")

# Convert to graph
tu_net <- graph_from_data_frame(d=tu_edges, vertices=tu_nodes, directed=F)

# Make it pretty
V(tu_net)$size <- 8

V(tu_net)$frame.color <- "white"

V(tu_net)$color <- "orange"

V(tu_net)$label <- "" 

E(tu_net)$arrow.mode <- 0

# Let's look at the network
kamada <- layout_with_kk(tu_net)
lgl <- layout_with_lgl(tu_net)

fr <- layout_with_drl(tu_net)


# Not very informative. We are going to include a threshold. 
# Basically we are deleting those with a weight below the mean of the network.
cut.off <- mean(tu_edges$weight)


tu_net.sp <- delete_edges(tu_net, E(tu_net)[weight<cut.off])
graph <- layout_with_graphopt(tu_net.sp)
nice <- layout_nicely(tu_net.sp)
plot(tu_net.sp, layout = nice)
# Lets try another why to visualize the network which is more informative
netm <- get.adjacency(tu_net.sp, attr = "weight", sparse = F)

colnames(netm) <- V(tu_net)$Id

rownames(netm) <- V(tu_net)$Id

palf <- colorRampPalette(c("gold", "dark orange")) 

heatmap(netm[,17:1], Rowv = NA, Colv = NA, col = palf(100), 
        
        scale="none", margins=c(10,10) )
