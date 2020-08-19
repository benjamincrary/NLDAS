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
assign_zonal_representative <- function(shapefile, zone_field, destination) {

  zone_map <- create_zone_map(shapefile, zone_field)

  identify_zonal_timeseries(zone_map, destination)

}
