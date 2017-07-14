#' Get Disney World wait times.
#'
#' @param park Character. The name of the park you are interested in
#'   receiving wait times for. Must be one of the following:
#'
#'   * `magic_kingdom`
#'   * `hollywood_studios`
#'   * `epcot`
#'   * `animal_kingdom`
#'
#' @return `tibble` containing the following columns:
#'
#'   * `name`: Character. The name of the attraction.
#'   * `wait_time`: Integer. The posted wait time (in minutes).
#'   * `fast_pass`: Logical. Can you obtain a fast pass for this
#'     attraction?
#'   * `status`: Character: The current status of the attraction.
#'   * `single_rider`: Logical. Does the ride have a single rider queue?
#'   * `type`: Character. The type of attraction.
#'   * `wait_time_list`: List. A list containing all wait time data
#'     obtained from the API.
#' @export
#'
#' @examples
#' \dontrun{
#' ## Get a tibble of Epcot wait times
#' get_wait_times(park = "epcot")
#'
#' ## Get a tibble of Hollywood Studios wait times
#' get_wait_times(park = "hollywood_studios")
#' }
get_wait_times <- function(park = "magic_kingdom") {
  token_url <- "https://authorization.go.com/token";
  token_body <- "grant_type=assertion&assertion_type=public&client_id=WDPRO-MOBILE.MDX.WDW.ANDROID-PROD";
  base_url = "https://api.wdpro.disney.go.com/facility-service/theme-parks/";

  token <- httr::POST(url = token_url,
                  body = token_body)
  access_token <- httr::content(token)$access_token

  park_info <- .park_lookup[[park]]
  park_id <- park_info$park_id
  resort_id <- park_info$resort_id

  url <- glue::glue("{base_url}{park_id};destination={resort_id}/wait-times")
  response <- httr::GET(url, httr::add_headers(
    Authorization = paste("BEARER", access_token),
    Accept = "application/json;apiversion=1",
    "X-Conversation-Id" = "WDPRO-MOBILE.MDX.CLIENT-PROD",
    "X-Correlation-ID" = Sys.Date()
  ))

  out_lst <- httr::content(response)[["entries"]]

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

