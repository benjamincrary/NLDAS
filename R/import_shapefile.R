#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
import_shapefile <- function(path) {
  shp <- sf::st_read(path)
  shp <- sf::st_transform(shp, 4326)
}
