library(networkD3)
library(magrittr)
library(htmlwidgets)
library(htmltools)

setwd("~/R projects/GVC project")
nodes <- read.csv("GVC NODES_by country.csv", header=T, as.is=T)
links <- read.csv("GVC EDGES_by country.csv", header=T, as.is=T)

# nodes need to be in the same order as the "source" column in links:
nodes <- cbind(idn=factor(nodes$country, levels=nodes$country), nodes)
nodes$imports.2 <- (nodes$imports)/10000
links <- subset(links, exports.log>4, select=c(from:exports.log))

network <- forceNetwork(Links = links, Nodes = nodes, Source = "from", 
                        Target = "to", Value="exports.log", NodeID = "idn", Group = "region",
                        linkColour = "#C0C0C0",fontSize = 12, zoom = T, legend = T, Nodesize = "imports.2", 
                        opacity = 1, charge = -600, opacityNoHover = 1, arrows=T)

network <- htmlwidgets::prependContent(network, htmltools::tags$h1("Global Trade 2017"))

network

detach("package:networkD3")

