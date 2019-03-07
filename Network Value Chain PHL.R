library(networkD3)
library(magrittr)
library(htmlwidgets)
library(htmltools)

setwd("~/R projects/GVC project")
phnodes <- read.csv("PHI_NODES OUT_2011.csv", header=T, as.is=T)
phlinks <- read.csv("PHI_EDGES OUT_2011.csv", header=T, as.is=T)



# nodes need to be in the same order as the "source" column in links:
phnodes <- cbind(idn=factor(phnodes$sector, levels=phnodes$sector), phnodes)

network <- forceNetwork(Links = phlinks, Nodes = phnodes, Source = "ï..from", 
                        Target = "to", Value="value", NodeID = "idn", Group = "type.label",
                        linkColour = "#afafaf", fontSize = 12, zoom = T, legend = T, Nodesize = 6, 
                        opacity = 1, charge = -600, opacityNoHover = 1, arrows=T)

network <- htmlwidgets::prependContent(network, htmltools::tags$h1("Philippine Domestic Value Chains 2011"))

network

detach("package:networkD3")

