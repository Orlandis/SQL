rm(list=ls())
library(XML)
# @ramnarasimhan

# for additional help please refer to :
# http://statistics.berkeley.edu/classes/s133/XML-a.html


#Recursive Function to visit the XML tree (depth first)
visitNode <- function(node) {
  if (is.null(node)) {
    #leaf node reached. Turn back
    return()
  }
  print(paste("Node: ", xmlName(node)))
  num.children = xmlSize(node)  
  if(num.children == 0 ) {
    # Add your code to process the leaf node here
    
    print( paste("   ", xmlValue(node)))
  }
  #Go one level deeper
  for (i in 1 : num.children) {
    visitNode(node[[i]]) #the i-th child of node
  }
}

xmlfile <- "books.xml"

#read the XML tree into memory
xtree <- xmlInternalTreeParse(xmlfile)
root <- xmlRoot(xtree)
visitNode(root)
