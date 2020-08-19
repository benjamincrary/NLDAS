#' assign_zonal_representatie
#'
#' @param path_to_shapefile
#' @param point_cloud_zone_field
#' @param destination
#'
#' @return
#' @export
#'
#' @examples
assign_zonal_representative <- function(path_to_shapefile, zone_field, parameter, destination) {

  zone_weight <- create_zone_weight(path_to_shapefile, zone_field)

  zone_map <- create_zone_map(zone_weight)

  output_zone_map(zone_map, zone_weight, parameter, destination)

  identify_zonal_timeseries(zone_map, destination)

}
