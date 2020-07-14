#' Title
#'
#' @param shapefile
#'
#' @return
#' @export
#'
#' @examples
create_nldas_point_cloud <- function(shapefile) {
  shapefile %>%
    sf::st_make_grid(cellsize = .125/10, what = "centers") %>%
    sf::st_intersection(shapefile) %>%
    sf::st_transform(4326)
}
