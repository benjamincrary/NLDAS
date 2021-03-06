#' indentify_zonal_timeseries
#'
#' @param zone_map
#' @param destination
#'
#' @return
#' @export
#'
#' @examples
identify_zonal_timeseries <- function(zone_map, destination) {

  timeseries <- list.files(path = paste0(destination))

  dir.create(paste0(destination, "Zones/"))

  zoneterms <- zone_map$term
  zones <- zone_map$zone

  for(term in zoneterms) {

      file <- paste0(destination, grep(term, timeseries, value=TRUE))
      zone <- zone_map$zone[zone_map$term == term]
      newname <- gsub(".txt", paste0("-zone-", zone, ".txt"), file)
      newname <- gsub(destination, paste0(destination, "Zones/"), newname)
      file.copy(from=file, to=newname)

    }

}
