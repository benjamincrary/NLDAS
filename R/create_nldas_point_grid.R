#' Title
#'
#' @param shapefile
#'
#' @return
#' @export
#'
#' @examples
create_nldas_point_cloud <- function(shapefile) {
  points <- shapefile %>%
    sf::st_make_grid(cellsize = .125/10, what = "centers")

  cloud <- sf::st_intersection(shapefile, points) %>%
    sf::st_transform(4326)
}
