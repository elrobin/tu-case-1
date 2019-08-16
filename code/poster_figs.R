# Polar chart --------------------------

# example for SSCI using this code:
# https://medium.com/optima-blog/using-polar-coordinates-for-better-visualization-1d337b6c9dec

# Variables can be the following:
  # - OA share is Open practices
  # - Capacity building: funded pubs, number of collabs in first year
  # - Scientific engagement: number of distinct collaborators, pubs
# - Social engagement: mentions in policy, mentions in news media
# - Trajectory: years

# import data
library(readxl)
poster <- read_excel("data/data_cases.xlsx", 
                     sheet = "poster_data")

# Choose variables
poster_vars <- poster[,c("my_id", "age", "p", "fund_p", "co_aut", "p_w_young", 
                         "news_m", "pol_m", "oa_p")]
# From wide to long format
library(reshape2)
poster_long <- melt(poster_vars, id.vars = "my_id")
poster_long$color <- ifelse(poster_long$variable=="age", "Trajectory",
  ifelse(poster_long$variable=="p","Trajectory",
    ifelse(poster_long$variable=="fund_p", "Capacity building",
      ifelse(poster_long$variable=="co_aut", "Scientific engagement",
        ifelse(poster_long$variable=="p_w_young", "Capacity building",
          ifelse(poster_long$variable=="news_m", "Social engagement",
            ifelse(poster_long$variable=="pol_m", "Social engagement",
              ifelse(poster_long$variable=="oa_p", "Open practices", NA
              ))))))))
# Choose cases
tu14 <- subset(poster_long, my_id=="soctu014")

#plot
library(ggplot2)

seniora <- ggplot(tu14, aes(x=variable, y=value, fill=color)) +
  scale_fill_brewer(palette="Dark2") +
  geom_histogram(binwidth=1, stat="identity") +
  theme_bw() +
  labs(x=element_blank(), y=element_blank(), title = "Researcher A") +
#  scale_fill_gradient(low="red", high="white", limits=c(5,40)) +
  theme(axis.title.y=element_text(angle=0), 
        axis.text.x = element_text(angle=45, vjust = 1, hjust=1), 
        legend.position = "none") +
  scale_x_discrete(labels=c("Age", "Pubs", "Funded pubs", "Coauthors", 
                            "1st pub coauthors", "Mentions in news",
                            "Mentions in policy docs", "OA pubs")) +
  coord_polar()

soc1 <- subset(poster_long, my_id=="socle001")

#plot
seniorb <- ggplot(soc1, aes(x=variable, y=value, fill=color)) +
  scale_fill_brewer(palette="Dark2") +
  geom_histogram(binwidth=1, stat="identity") +
  theme_bw() +
  labs(x=element_blank(), y=element_blank(), title = "Researcher B") +
  #  scale_fill_gradient(low="red", high="white", limits=c(5,40)) +
  theme(axis.title.y=element_text(angle=0), 
        axis.text.x = element_text(angle=45, vjust = 1, hjust=1)) +
  scale_x_discrete(labels=c("Age", "Pubs", "Funded pubs", "Coauthors", 
                            "1st pub coauthors", "Mentions in news",
                            "Mentions in policy docs", "OA pubs")) +
  coord_polar()

