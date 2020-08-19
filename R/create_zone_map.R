#' create zone map
#'
#' @param zone_weight
#'
#' @return
#' @export
#'
#' @examples
create_zone_map <- function(zone_weight) {

  zone_map <- zone_weight %>%
    dplyr::group_by(zone) %>%
    dplyr::filter(weight == max(weight)) %>%
    dplyr::mutate(term = paste0("X", NLDAS_X_Grid, "-Y", NLDAS_Y_Grid))

  return(zone_map)

}




