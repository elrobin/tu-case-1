# cluster assignments to macro categories

# Import TU profile map
library(readr)
tu_profile <- read_delim("data/maps/tu_profile.txt",
                         "\t",
                         escape_double = FALSE,
                         trim_ws = TRUE)

# Count by cluster number of publications
aggregate(tu_profile$`weight<No. of pub. (econ.)>`, 
          by=list(Cluster=tu_profile$cluster), 
          FUN = sum)
# Cluster 3 has a total of 128180 pubs. This is Physics and Engineering.
# Match clusters with cluster_id1
tu_cl <- subset(tu_profile, select=c(id, cluster))
write.table(tu_cl, 
            file="data/LW_field_macro_clusters.txt", 
            sep = ";",
            row.names = FALSE)
          