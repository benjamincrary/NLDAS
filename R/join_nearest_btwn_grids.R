#' Title
#'
#' @param grid_a
#' @param grid_b
#'
#' @return
#' @export
#'
#' @examples
join_nearest_btwn_grids <- function(grid_a, grid_b) {


  xa <- sf::st_coordinates(grid_a)[,1]
  xb <- sf::st_coordinates(grid_b)[,1]
  ya <- sf::st_coordinates(grid_a)[,2]
  yb <- sf::st_coordinates(grid_b)[,2]

  nearx <- sapply(xa, function(xa, xb) {xb[which.min(abs(xa-xb))]}, xb)
  neary <- sapply(ya, function(ya, yb) {yb[which.min(abs(ya-yb))]}, yb)

  near_points <- data.frame(grid_a = paste0(xa, ",", ya), grid_a_x = xa, grid_a_y = ya, nearest_b_x = nearx, nearest_b_y = neary) %>%
    sf::st_as_sf(., coords = c("nearest_b_x", "nearest_b_y"), crs = 4326) %>%
    mutate( nearest_b_x = nearx, nearest_b_y = neary)

  return(near_points)

}
