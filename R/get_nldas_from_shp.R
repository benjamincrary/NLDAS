#' Title
#'
#' @param shapefile
#' @param daterange
#'
#' @return
#' @export
#'
#' @examples
get_nldas_from_shp <- function(shapefile, startdate, enddate, parameters, destination) {
t
  #read shapefile
  shp <- import_shapefile(shapefile)

  #create lookup point cloud
  cloud <- create_nldas_point_cloud(shp)

  #get NLDAS grid
  grid <- lookup_nldas_grid(cloud)

  #build queries
  queries <- build_nldas_query(grid, parameters, startdate, enddate, destination)

  #query data
  query_nldas(queries)

  }
