use
# NLDAS

<!-- badges: start -->
<!-- badges: end -->ins

The goal of NLDAS is to ...

## Installation

You can install the released version of NLDAS from [CRAN](https://CRAN.R-project.org) with:

``` r
devtools::install.github("benjamincrary/NLDAS")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(NLDAS)
## get_nldas_from_shp(path_to_shapefile, startdate, enddate, nldas_parameters, destination)
get_nldas_from_shp("Data/CRW_NewPrecipZones.shp", "2019-05-28", "2019-05-28", "APCPsfc", "Output/")


## assign_zonal_representative(path_to_shapefile, zone_field, destination)
assign_zonal_representative("Data/CRW_NewPrecipZones.shp", "NewGrpID", "Output/")


```

