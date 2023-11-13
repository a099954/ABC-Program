Source: [2014 World Health Organization Global Tuberculosis Report](http://www.who.int/tb/country/data/download/en/)

This data is a mess and contains redundant columns, odd variable codes, and many missing values. There is no sign of bias though.

who
#> # A tibble: 7,240 x 60
|#>   |country | iso2  | iso3   | year | new_sp_m014 | new_sp_m1524 | new_sp_m2534 | new_sp_m3544|
|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|
|#> |  <chr>  | <chr>| <chr>| <int>     |  <int>     |   <int>      |  <int>     |   <int>|
|#> |1 |Afghan… |AF   | AFG   | 1980       |   NA      |     NA      |     NA      |     NA|
|#> |2 |Afghan… |AF   | AFG  |  1981       |   NA      |     NA     |      NA      |     NA|
|#> |3 |Afghan… |AF   | AFG  |  1982      |    NA      |     NA     |      NA      |     NA|
|#> |4 |Afghan… |AF   | AFG   | 1983       |   NA      |     NA     |      NA      |     NA|
|#>| 5 |Afghan… |AF   | AFG   | 1984       |   NA      |     NA      |     NA      |     NA|
|#> |6 |Afghan… |AF   | AFG   | 1985       |   NA      |     NA      |     NA      |     NA|
|#> |# |… with 7,234 more rows |and 52 more variables |new_sp_m4554 <int> |
|#> |# |  new_sp_m5564 <int> |new_sp_m65 <int> |new_sp_f014 <int>|
|#> |#  | new_sp_f1524 <int> |new_sp_f2534 <int> |new_sp_f3544 <int>|
|#> |# |  new_sp_f4554 <int> |new_sp_f5564 <int> |new_sp_f65 <int>|
|#> |# |  new_sn_m014 <int>|new_sn_m1524 <int> |new_sn_m2534 <int>|
|#> |# |  new_sn_m3544 <int> |new_sn_m4554 <int> |new_sn_m5564 <int>|
|#> |# |  new_sn_m65 <int> |new_sn_f014 <int> |new_sn_f1524 <int>|
|#> |# |  new_sn_f2534 <int> |new_sn_f3544 <int>| new_sn_f4554 <int>|
|#>| # |  new_sn_f5564 <int> |new_sn_f65 <int> |new_ep_m014 <int>|
|#>| # |  new_ep_m1524 <int> |new_ep_m2534 <int> |new_ep_m3544 <int>|
|#> |# |  new_ep_m4554 <int> |new_ep_m5564 <int> |new_ep_m65 <int>|
|#>| # |  new_ep_f014 <int> |new_ep_f1524 <int> |new_ep_f2534 <int>|
|#>| #  | new_ep_f3544 <int> |new_ep_f4554 <int> |new_ep_f5564 <int>|
|#>| #  | new_ep_f65 <int> |newrel_m014 <int> |newrel_m1524 <int>|
|#>| #  | newrel_m2534 <int> |newrel_m3544 <int> |newrel_m4554 <int>|
|#> |#  | newrel_m5564 <int> |newrel_m65 <int> |newrel_f014 <int>|
|#>| #  | newrel_f1524 <int> |newrel_f2534 <int> |newrel_f3544 <int>|
|#> |# |  newrel_f4554 <int> |newrel_f5564 <int> |newrel_f65 <int>|
