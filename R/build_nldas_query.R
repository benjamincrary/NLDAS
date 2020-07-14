#' Title
#'
#' @param grid
#' @param parameters
#'
#' @return
#' @export
#'
#' @examples
build_nldas_query <- function(grid, parameters, startdate, enddate, destination) {

  parameters <- parameters
  grid <- grid

  xgrids <- grid$xpoints
  ygrids <- grid$ypoints

  gridterms <- paste0("X",xgrids, "-Y", ygrids)

  #loop through and build queries
  queries <- NULL
  destinations <- NULL

  for(param in parameters) {
    for(grid in gridterms) {
      url <- paste0("https://hydro1.gesdisc.eosdis.nasa.gov/daac-bin/access/timeseries.cgi?variable=NLDAS:NLDAS_FORA0125_H.002:", param,"&location=NLDAS:", grid, "&startDate=", startdate,"T00&endDate=", enddate, "T23&type=asc2")
      dest <- paste0(destination, param, "-", grid, ".txt")
      queries <- c(queries, url)
      destinations <- c(destinations, dest)
      }
  }

  built_queries<- data.frame(query = queries, destination = destinations)
  return(built_queries)

}
