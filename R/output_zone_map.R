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
output_zone_map <- function(zone_map, variable, destination) {

  zone_map_ext <- zone_map %>%
    dplyr::mutate(file = paste0(destination, variable, "-X", NLDAS_X_Grid, "-Y", NLDAS_Y_Grid, ".txt"))

  write.csv(zone_map_ext, paste0(destination, "zone_map.csv"), quote="")

}
