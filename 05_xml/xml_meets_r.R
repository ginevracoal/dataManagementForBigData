# Work with XML files using a simple, consistent interface. Built on top of the 'libxml2' C library.
library(xml2)

# read XML and validate against a DTD
# Use xml_validate to validate against a XML Schema
doc = read_xml("06_xml/dream.xml", options = "DTDVALID")

# query with XPath
xml_find_all(doc, xpath = "/PLAY/PERSONAE/PERSONA")
xml_find_all(doc, xpath = "/PLAY/PERSONAE/PERSONA/text()")

# find path of a node
xml_path(xml_find_first(doc, xpath = "/PLAY/PERSONAE/PERSONA"))

# get a list from a node set
persona = xml_find_all(doc, xpath = "/PLAY/PERSONAE/PERSONA/text()")
as_list(persona)
# get a vector
unlist(as_list(persona))

# A larger package for working with XML
library(XML)
f = system.file("exampleData", "size.xml", package = "XML")
# get a data frame from a shallow XML
# Each node corresponds to an observation and each of its sub-elements correspond to a variable. 
xmlToDataFrame(f, c("integer", "integer", "numeric"))
