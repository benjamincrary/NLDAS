#' create zone map
#'
#' @param shapefile
#' @param point_cloud
#'
#' @return
#' @export
#'
#' @examples
create_zone_map <- function(path_to_shapefile, zone_field) {

  shapefile <- import_shapefile(path_to_shapefile)
  point_cloud <- create_nldas_point_cloud(shapefile)

  zonal_cloud <- sf::st_intersection(shapefile, point_cloud)
  nldas_grid_shp <- create_nldas_shape(point_cloud)


  a <- sf::st_coordinates(point_cloud)[,1]
  b <- nldas_long_grid$Longitude
  xpoint_centroid <- sapply(a, function(a,b) {b[which.min(abs(a-b))]}, b)
  a <- sf::st_coordinates(point_cloud)[,2]
  b <- nldas_lat_grid$Latitude
  ypoint_centroid <- sapply(a, function(a,b) {b[which.min(abs(a-b))]}, b)

  zonal_df <- data.frame(Longitude = xpoint_centroid) %>%
    dplyr::left_join(nldas_long_grid, by="Longitude") %>%
    cbind(cloudx= sf::st_coordinates(zonal_cloud)[,1]) %>%
    cbind(data.frame(Latitude = ypoint_centroid)) %>%
    dplyr::left_join(nldas_lat_grid, by = "Latitude") %>%
    cbind(cloudy =  sf::st_coordinates(zonal_cloud)[,2]) %>%
    cbind(zone = zonal_cloud[[zone_field]])

  zone_count <- zonal_df %>%
    dplyr::group_by(zone, NLDAS_X_Grid, NLDAS_Y_Grid) %>%
    dplyr::summarize(count = n())

  zone_weight <- zone_count %>%
    dplyr::group_by(zone) %>%
    dplyr::summarize(size = sum(count)) %>%
    dplyr::right_join(zone_count, by = "zone") %>%
    dplyr::mutate(weight = count/size)

  zone_map <- zone_weight %>%
    dplyr::group_by(zone) %>%
    dplyr::filter(weight == max(weight)) %>%
    dplyr::mutate(term = paste0("X", NLDAS_X_Grid, "-Y", NLDAS_Y_Grid))

  return(zone_map)

}




