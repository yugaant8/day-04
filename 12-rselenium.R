# =====================================================================================================================
# = Using RSelenium                                                                                                   =
# =                                                                                                                   =
# = Author: Andrew B. Collier <andrew@exegetic.biz> | @datawookie                                                     =
# =====================================================================================================================

# A helpful vignette: https://github.com/ropensci/RSelenium/blob/master/vignettes/RSelenium-docker.Rmd

# CONFIGURATION -------------------------------------------------------------------------------------------------------

# LIBRARIES -----------------------------------------------------------------------------------------------------------

# CRAN
#
# > install.packages("RSelenium")
#
# GitHub
#
# > devtools::install_github("ropensci/RSelenium")                   # Bleeding edge
# > devtools::install_github("ropensci/RSelenium@v1.7.1")            # Release

library(dplyr)
library(RSelenium)

# DOCKER SETUP --------------------------------------------------------------------------------------------------------

# Pull and run the current version of Firefox.
#
# $ docker pull selenium/standalone-firefox
# $ docker run -d -p 4445:4444 selenium/standalone-firefox

# Pull and run a specific version of Chrome (with debug).
#
# Selenium will be running inside a container. In order to actually see a browser window you need to use a debug image
# and then connect to it via VNC (on port 5900).
#
# $ docker pull selenium/standalone-chrome-debug:3.11
# $ docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug:3.11
#
# Then use vinagre or tightvnc to connect to 127.0.0.1:5900 (if you are running on localhost). Password is "secret".

# * LINUX
#
# VNC clients:
#
# - vinagre
# - xtightvncviewer
# - RealVNC

# * WINDOWS
#
# Get address with
#
# $ docker-machine ip
#
# Use this with the remoteServerAddr argument of remoteDriver().
#
# VNC clients:
#
# - RealVNC

# * MAC
#
# VNC clients:
#
# - RealVNC

# CONNECTION ----------------------------------------------------------------------------------------------------------

BROWSER_OPTIONS = list(
  chromeOptions = list(
    args = c(
      '--disable-gpu',
      # '--headless',
      '--window-size=1280,800')
  )
)

browser <- remoteDriver(browserName = "chrome",
                        extraCapabilities = BROWSER_OPTIONS,
                        remoteServerAddr = "localhost",
                        port = 4444L)
browser$open()

# Extend timeout on script from 10 s to 30 s.
#
browser$setTimeout("script", 30000)

browser$navigate("http://www.google.com")
#
class(browser)
#
?remoteDriver
#
# The most important methods for remoteDriver are
#
# - getPageSource()
# - executeScript()
# - findElement() and
# - findElements().

# Some other interesting functionality:
#
# - getTitle() and
# - getWindowSize().

# LOCATING ELEMENTS ---------------------------------------------------------------------------------------------------

search_box <- browser$findElement(using = "id", "lst-ib")
search_button <- browser$findElement(using = "css selector", ".jsb input:nth-child(1)")
#
class(search_box)
#
?webElement
#
# The most important methods for interacting with webElement are
#
# - clearElement()
# - sendKeysToElement()
# - clickElement()
# - findChildElement() and
# - findChildElements().

# INTERACTING WITH ELEMENTS -------------------------------------------------------------------------------------------

# Enter "Data Science" into the search box and then send the Tab key to shift focus.
#
search_box$sendKeysToElement(list("Data Science", key = "tab"))
#
# If you don't send through the tab key then the popup list of options will remain visible.
#
# There is a mapping for all available "special" keys.
#
?selKeys

# Now click on the "Google Search" button.
#
search_button$clickElement()

# We could have short circuited the last two steps by simply sending the "enter" key rather than the "tab".

# MORE ELEMENTS -------------------------------------------------------------------------------------------------------

# The most important methods for extracting information from webElement are
#
# - getElementText() and
# - getElementAttribute().

# This selector will only match actual hits, not the promoted content at the top of the page.
#
hits <- browser$findElements(using = "css selector", ".srg .r a")
#
class(hits)

# Retrieve data for first element in list.
#
hits[[1]]$getElementText()
hits[[1]]$getElementAttribute("href")

# Systematically retrieve data for all elements in the list.
#
sapply(hits, function(tag) tag$getElementText()) %>% unlist()
sapply(hits, function(tag) tag$getElementAttribute("href")) %>% unlist()
#
# We can arrange these in a neat table.
#
lapply(hits, function(tag) {
  tibble(
    title = tag$getElementText()[[1]],
    url = tag$getElementAttribute("href")[[1]]
  )
}) %>% bind_rows()
