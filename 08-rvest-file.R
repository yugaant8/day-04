# =====================================================================================================================
# = Using rvest (HTML from file)                                                                                      =
# =                                                                                                                   =
# = Author: Andrew B. Collier <andrew@exegetic.biz> | @datawookie                                                     =
# =====================================================================================================================

# CONFIGURATION -------------------------------------------------------------------------------------------------------

FILE = "08-rvest-file.html"

# LIBRARIES -----------------------------------------------------------------------------------------------------------

library(rvest)

# ---------------------------------------------------------------------------------------------------------------------

# First set working directory to the location of this file!
#
html <- read_html(FILE)

# html_nodes() and html_node() are the work horses of the rvest package.
#
# html_node()    - matches a single node
# html_nodes()   - matches one or more nodes

html %>% html_node("H1")            # No matches: evidently it's case sensitive!
html %>% html_node("h1")

html %>% html_node("h2")            # Returns only first node
html %>% html_nodes("h2")           # Returns all matching nodes

# Ways to interrogate nodes:
#
# - html_name()
# - html_text()
# - html_attr()  - get value of specific attribute
# - html_attrs() - get all attributes

# Grab the node types.
#
html %>% html_nodes("h2") %>% html_name()

# Grab the text content of the h2 nodes.
#
html %>% html_nodes("h2") %>% html_text()

# IMAGE ---------------------------------------------------------------------------------------------------------------

# Get a list of attributes.
#
html %>% html_nodes("img") %>% html_attrs()

# Extract the src attribute.
#
html %>% html_nodes("img") %>% html_attr("src")

# LINKS ---------------------------------------------------------------------------------------------------------------

# Find all outbound links.
#
html %>% html_nodes("a")

# Find text content of the links.
#
html %>% html_nodes("a") %>% html_text()

# Find URLs they're pointing to.
#
html %>% html_nodes("a") %>% html_attr("href")

# PARAGRAPH -----------------------------------------------------------------------------------------------------------

# Using CSS.
#
html %>% html_nodes(css = "body > p:nth-child(9)") %>% html_text()

# Using XPath.
#
html %>% html_nodes(xpath = "/html/body/p[5]") %>% html_text()

# ID ------------------------------------------------------------------------------------------------------------------

# Why doesn't this work?
#
html %>% html_node("#contact") %>% html_attr("href")

# Why does this solve the problem?
#
html %>% html_node("#contact") %>% html_children() %>% html_attr("href")
#
html %>% html_node("#contact a") %>% html_attr("href")
html %>% html_node("#contact > a") %>% html_attr("href")

# TABLE ---------------------------------------------------------------------------------------------------------------

html %>% html_node("table") %>% html_table(trim = TRUE)

# EXERCISES -----------------------------------------------------------------------------------------------------------

# 1. Get the URLs for each of the packages in the unordered list.
# 2. Extract the text from all of the paragraphs.