# =====================================================================================================================
# = User Agent String                                                                                                 =
# =                                                                                                                   =
# = Author: Andrew B. Collier <andrew@exegetic.biz> | @datawookie                                                     =
# =====================================================================================================================

# CONFIGURATION -------------------------------------------------------------------------------------------------------

# LIBRARIES -----------------------------------------------------------------------------------------------------------

library(httr)
library(rvest)

# ---------------------------------------------------------------------------------------------------------------------

# What is the User Agent String for your browser? Browse to https://httpbin.org/user-agent.
#
# You can get more detailed information here: http://www.useragentstring.com/.

# What is the User Agent String for rvest?
#
html_session("http://example.org/")$response$request$options$useragent
#
# Where does that come from? It's the default from the httr package.
#
httr:::default_ua()

# Masquerade as a different browser.
#
UA <- "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
#
html_session("http://example.org/", user_agent(UA))$response$request$options$useragent

# These are some useful User Agent strings:
#
# - Lynx/2.8.8dev.3 libwww-FM/2.14 SSL-MM/1.4.1
# - Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36
#
# [!!!] http://www.useragentstring.com/pages/useragentstring.php is an extensive list of User Agent strings
# (including those for many known crawlers).

# Provide clear identification in the User Agent string.
#
UA <- "Andrew collier | andrew@exegetic.biz"
#
html_session("http://example.org/", user_agent(UA))$response$request$options$useragent
