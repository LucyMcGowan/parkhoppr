#' Get Magic Kingdom Wait Times
#'
#' @return tibble with Magic Kingdom wait times
#' @export
#'
#' @examples
#' \dontrun{
#' get_wait_times()
#' }
get_wait_times <- function() {
  token_url <- "https://authorization.go.com/token";
  token_body <- "grant_type=assertion&assertion_type=public&client_id=WDPRO-MOBILE.MDX.WDW.ANDROID-PROD";
  app_id <- "WDW-MDX-ANDROID-4.6.1";
  base_url = "https://api.wdpro.disney.go.com/";

  x <- httr::POST(url = token_url,
                  body = token_body)
  access_token <- httr::content(x)$access_token
  ## magic kingdon
  park_id <- 80007944
  resort_id <- 80007798
  url <- glue::glue("{base_url}facility-service/theme-parks/{park_id};destination\u003d{resort_id}/wait-times")
  h <- httr::GET(url, httr::add_headers(
    Authorization = paste("BEARER", access_token),
    Accept = "application/json;apiversion=1",
    "X-Conversation-Id" = "WDPRO-MOBILE.MDX.CLIENT-PROD",
    "X-App-Id" = app_id,
    "X-Correlation-ID" = Sys.Date()
  ))

  out_lst <- httr::content(h)

  out_lst <- out_lst[["entries"]]

  out_tbl <- tibble::tibble(
    name = purrr::map_chr(out_lst, "name"),
    wait_time_lst = purrr::map(out_lst, "waitTime"),
    type = purrr::map_chr(out_lst, "type")
  )

  out_tbl[["status"]] <- purrr::map_chr(out_tbl$wait_time_lst, "status")
  out_tbl[["single_rider"]] <- purrr::map_lgl(out_tbl$wait_time_lst, "singleRider")
  out_tbl[["wait_time"]] <- purrr::map_int(out_tbl$wait_time_lst, "postedWaitMinutes", .null = NA)
  out_tbl[["fast_pass"]] <- purrr::map_lgl(out_tbl$wait_time_lst, c("fastPass", "available"))

  out_tbl <- out_tbl[ , c(1, 6, 7, 4, 5, 3, 2)]
  return(out_tbl)
}

