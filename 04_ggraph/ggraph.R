library(utils)
library(tidyverse)
library(ggraph)
library(igraph)
library(visNetwork)

# read edges and nodes
edges = read_csv("dolphin_edges.csv")
nodes = read_csv("dolphin_nodes.csv", na=c("", "NA"))

## Which are the most social dolphins?

n_nodes = nrow(nodes) # number of dolphins
count(nodes, sex) # count number of nodes for each sex
n_edges = nrow(edges) # number of edges

# degree of nodes is the number of edges for each node

# I have to count each edge twice (also in reverse order)
x2 = c(edges$x, edges$y)
y2 = c(edges$y, edges$x)
edges2 = tibble(x = x2, y = y2)

count(edges2, x) # number of edges from x
degree = count(edges2, x)$n # create degree vector
nodes = mutate(nodes, degree) # add degree column

# most social dolphins are ones with higher degree
arrange(nodes, desc(degree))

## Are female dolphins more social than male dolphins?

# I have to compare the average degree for males and females 
nodes %>% group_by(sex) %>% 
  summarize(avg_degree=mean(degree)) %>% 
  arrange(desc(avg_degree))

## What is the type of the relationship among dolphins (friendship or sexual)?

# boolean vectors for checking sex
sexM = nodes$sex == "M"
sexF = nodes$sex == "F"
sexU = nodes$sex == "U"

# checking that each element falls in a certain category
sexM | sexF | sexU

# creating sex columns corresponding to edges indexes
edges = edges %>% 
  select(x,y) %>% 
  mutate(x_sex = nodes$sex[x]) %>% 
  mutate(y_sex = nodes$sex[y]) 

# I have to count the total number of couples of edges based 
# on sex distinction

# total number of male to male edges
m2m = nrow(edges %>% filter(x_sex == "M" & y_sex == "M"))
f2f = nrow(edges %>% filter(x_sex == "F" & y_sex == "F"))
m2f = nrow(edges %>% filter(x_sex == "M" & y_sex == "F"))
f2m = nrow(edges %>% filter(x_sex == "F" & y_sex == "M"))

# total number of edges connecting males and females
mf_edges = count(edges %>% filter(x_sex != "U" & y_sex != "U"))

# just checking
m2m + f2f + m2f + f2m == mf_edges

# assuming that heterosexual ties correspond to love 
# relashionships, while homosexual ones to friendship 
# relationships 

homo = (m2m + f2f) / mf_edges
homo

hetero = (m2f + f2m) / mf_edges
hetero
