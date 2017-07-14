
<!-- README.md is generated from README.Rmd. Please edit that file -->
parkhoppr
=========

The goal of parkhoppr is to allow access to Disney World wait times.

Installation
------------

You can install parkhoppr from github with:

``` r
# install.packages("devtools")
devtools::install_github("LucyMcGowan/parkhoppr")
```

Example
-------

There is currently just one function - you can get wait times for rides at Magic Kingdom. More to come very soon!

``` r
library("parkhoppr")
get_wait_times()
#> # A tibble: 78 x 7
#>                                             name wait_time fast_pass
#>                                            <chr>     <int>     <lgl>
#>  1                        Stitch's Great Escape!        20     FALSE
#>  2                    Monsters, Inc. Laugh Floor        20      TRUE
#>  3     Walt Disney World Railroad - Frontierland        NA     FALSE
#>  4             Walt Disney's Enchanted Tiki Room        NA     FALSE
#>  5                Sorcerers of the Magic Kingdom        NA     FALSE
#>  6                               The Barnstormer        35      TRUE
#>  7      Walt Disney World Railroad - Fantasyland        NA     FALSE
#>  8             Casey Jr. Splash 'N' Soak Station        NA     FALSE
#>  9                             Cinderella Castle        NA     FALSE
#> 10 Under the Sea - Journey of The Little Mermaid        20      TRUE
#> # ... with 68 more rows, and 4 more variables: status <chr>,
#> #   single_rider <lgl>, type <chr>, wait_time_lst <list>
```
