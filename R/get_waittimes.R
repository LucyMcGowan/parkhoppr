token_url <- "https://authorization.go.com/token";
token_body <- "grant_type=assertion&assertion_type=public&client_id=WDPRO-MOBILE.MDX.WDW.ANDROID-PROD";
app_id <- "WDW-MDX-ANDROID-4.6.1";
base_url = "https://api.wdpro.disney.go.com/";

x <- httr::POST(url = token_url,
                body = token_body)
access_token <- httr::content(x)$access_token
url <- paste0(base_url, "facility-service/theme-parks/")
h <-
  x <- httr::GET(url, httr::add_headers(
    Authorization = paste("BEARER", access_token),
    Accept = "application/json;apiversion=1",
    "X-Conversation-Id" = "WDPRO-MOBILE.MDX.CLIENT-PROD",
    "X-App-Id" = app_id,
    "X-Correlation-ID" = Sys.Date()
  ))

httr::content(h)
