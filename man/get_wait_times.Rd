% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_wait_times.R
\name{get_wait_times}
\alias{get_wait_times}
\title{Get Disney World wait times.}
\usage{
get_wait_times(park = "magic_kingdom")
}
\arguments{
\item{park}{Character. The name of the park you are interested in
receiving wait times for. Must be one of the following:
\itemize{
\item \code{magic_kingdom}
\item \code{hollywood_studios}
\item \code{epcot}
\item \code{animal_kingdom}
}}
}
\value{
\code{tibble} containing the following columns:
\itemize{
\item \code{name}: Character. The name of the attraction.
\item \code{wait_time}: Integer. The posted wait time (in minutes).
\item \code{fast_pass}: Logical. Can you obtain a fast pass for this
attraction?
\item \code{status}: Character: The current status of the attraction.
\item \code{single_rider}: Logical. Does the ride have a single rider queue?
\item \code{type}: Character. The type of attraction.
\item \code{wait_time_list}: List. A list containing all wait time data
obtained from the API.
}
}
\description{
Get Disney World wait times.
}
\examples{
\dontrun{
## Get a tibble of Epcot wait times
get_wait_times(park = "epcot")

## Get a tibble of Hollywood Studios wait times
get_wait_times(park = "hollywood_studios")
}
}
