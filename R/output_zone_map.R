#' Title
#'
#' @param zone_map
#' @param variable
#' @param destination
#'
#' @return
#' @export
#'
#' @examples
output_zone_map <- function(zone_map, zone_weight, parameter, destination) {

  zone_map_ext <- zone_map %>%
    dplyr::mutate(file = paste0(destination, parameter, "-X", NLDAS_X_Grid, "-Y", NLDAS_Y_Grid, ".txt"))

  zone_weight_ext <- zone_weight %>%
    dplyr::mutate(file = paste0(destination, parameter, "-X", NLDAS_X_Grid, "-Y", NLDAS_Y_Grid, ".txt"))

  write.csv(zone_map_ext, paste0(destination, parameter, "-zone_map.csv"), quote=FALSE, row.names=F)
  write.csv(zone_weight_ext, paste0(destination, parameter, "-zone_weight.csv"), quote=FALSE, row.names=F)

}
