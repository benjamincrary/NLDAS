#' assign_zonal_representatie
#'
#' @param shapefile
#' @param point_cloud_zone_field
#' @param destination
#'
#' @return
#' @export
#'
#' @examples
assign_zonal_representative <- function(shapefile, zone_field, parameter, destination) {

  zone_map <- create_zone_map(shapefile, zone_field)

  output_zone_map <- output_zone_map(zone_map, parameter, destination)

  identify_zonal_timeseries(zone_map, destination)

}
