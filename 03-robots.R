# =====================================================================================================================
# = robots.txt                                                                                                        =
# =                                                                                                                   =
# = Author: Andrew B. Collier <andrew@exegetic.biz> | @datawookie                                                     =
# =====================================================================================================================

# CONFIGURATION -------------------------------------------------------------------------------------------------------

# LIBRARIES -----------------------------------------------------------------------------------------------------------

library(robotstxt)

# ---------------------------------------------------------------------------------------------------------------------

# Open up the following in your browser:
#
# - https://www.google.com/robots.txt
# - https://en.wikipedia.org/robots.txt
#
# Get an idea of what user agents are allowed to go where.

# Check domain root.
#
paths_allowed("http://google.com/")

# Check specific folder.
#
paths_allowed("http://google.com/search/")

# Check for a specific bot name.
#
paths_allowed("https://en.wikipedia.org/", bot = "SiteSnagger")

# Check for a specific User Agent string.
#
paths_allowed("https://en.wikipedia.org/", user_agent = "Mozilla/5.0")

# ---------------------------------------------------------------------------------------------------------------------

robots <- robotstxt(domain = "http://google.com/")

# Access contents of the robots.txt file.
#
robots$text

# What bots are mentioned in robots.txt?
#
robots$bots

# Details of permissions as a table.
#
robots$permissions

# Links to sitemap files.
#
robots$sitemap

robots$check(paths = "/search/")
robots$check(paths = "/search/about/")
robots$check(paths = "/imgres/")
robots$check(paths = "/imgres/", bot = "Twitterbot")
