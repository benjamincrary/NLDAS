#' Title
#'
#' @param point_cloud
#'
#' @return
#' @export
#'
#' @examples
create_nldas_shape <- function(point_cloud) {

  a <- sf::st_coordinates(point_cloud)[,1]
  b <- nldas_long_grid$Longitude
  xpoint_centroid <- sapply(a, function(a,b) {b[which.min(abs(a-b))]}, b)
  a <- sf::st_coordinates(point_cloud)[,2]
  b <- nldas_lat_grid$Latitude
  ypoint_centroid <- sapply(a, function(a,b) {b[which.min(abs(a-b))]}, b)

  nldas_grid_shp <- data.frame(Longitude = xpoint_centroid, Latitude = ypoint_centroid) %>%
    sf::st_as_sf(., coords = c("Longitude", "Latitude"), crs = 4326)

  return(nldas_grid_shp)
}


#' Title
#'
#' @param point_cloud
#'
#' @return grid
#' @export
#'
#' @examples
lookup_nldas_grid <- function(point_cloud) {

  nldas_shp <- create_nldas_shape(point_cloud) %>%
    sf::st_coordinates()

  xpoints <- data.frame(Longitude = nldas_shp[,1]) %>% dplyr::left_join(nldas_long_grid, by="Longitude") %>% dplyr::select("NLDAS_X_Grid") %>% rename("xpoints" = "NLDAS_X_Grid")
  ypoints <- data.frame(Latitude = nldas_shp[,2]) %>% dplyr::left_join(nldas_lat_grid, by = "Latitude") %>% dplyr::select("NLDAS_Y_Grid") %>% rename("ypoints" = "NLDAS_Y_Grid")

  grid <- dplyr::distinct(data.frame(xpoints = xpoints, ypoints = ypoints))

  return(grid)

}


zonal_assignment <- function(shapefile, point_cloud, zonefield) {

  #unique zone list
  zones <- dplyr::distinct(data.frame(zone = shapefile[[zonefield]]))
  #pull in zone info
  zonal_cloud <- sf::st_intersection(shapefile, point_cloud)
  #bring in nldas grid shapefile
  nldas_grid_shp <- create_nldas_shape(point_cloud)
  #nearest point to grid
  nearest <- sf::st_nearest_points(zonal_cloud, nldas_grid_shp)
  nearest2 <- sf::st_distance(zonal_cloud, nldas_grid_shp)


}







