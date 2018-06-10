library(xml2)

# define a DTD for the XML output and validate it 
doc <- read_xml("06_xml/count_query.xml", options = "DTDVALID")

# read the XML document into a data frame
library(XML)
df <- xmlToDataFrame("06_xml/count_query.xml", c("character", "integer", "integer", "integer"))
df

# visualize the statistics using ggplot
library(ggplot2)
ggplot(df, aes(TITLE)) + geom_histogram(aes(nscenes))

ggplot(df, aes(TITLE)) + 
  geom_bar(aes(fill=nscenes)) +
  geom_bar(aes(fill=nspeeches)) +
  geom_bar(aes(fill=nlines))
