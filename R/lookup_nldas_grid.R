#' Title
#'
#' @param point_cloud
#'
#' @return grid
#' @export
#'
#' @examples
lookup_nldas_grid <- function(point_cloud) {

  xpoints <- nldas_long_grid[findInterval(sf::st_coordinates(point_cloud)[,1], nldas_long_grid$Longitude),2]
  ypoints <- nldas_lat_grid[findInterval(sf::st_coordinates(point_cloud)[,2], nldas_lat_grid$Latitude),2]

  grid <- dplyr::distinct(data.frame(xpoints,ypoints))

  return(grid)
}


