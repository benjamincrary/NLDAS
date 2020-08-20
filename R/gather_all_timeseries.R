#' gather all timeseries
#'
#' @param destination
#' @param parameter
#'
#' @return
#' @export
#'
#' @examples
gather_all_timeseries <- function(destination, parameter) {

  ## read zonae maps to join with files
  zone_map <- read.csv(paste0(destination, parameter, "-zone_map.csv")) %>%
    dplyr::mutate(grid = paste0(NLDAS_X_Grid, "-", NLDAS_Y_Grid),
                  zonal_rep = "yes") %>%
    dplyr::select(zone, grid, zonal_rep)
  zone_weight <- read.csv(paste0(destination, parameter, "-zone_weight.csv"))


  #Read in raw data files as timeseries
  file_list <- as.character(unique(zone_weight$file))

  timeseries <- file_list %>%
    purrr::map_dfr(read_raw_NLDAS_timeseries)

  multi_timeseries_df <- zone_weight %>%
    dplyr::left_join(timeseries, by="file") %>%
    dplyr::mutate(year = lubridate::year(date_time_local),
                  grid = paste0(NLDAS_X_Grid, "-", NLDAS_Y_Grid))

  write.csv(multi_timeseries_df, paste0(destination, "all_timeseries_df.csv"), row.names=F, quote=F)

  return(multi_timeseries_df)

}
