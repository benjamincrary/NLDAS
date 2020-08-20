#' read all timeseries df
#'
#' @param destination
#'
#' @return
#' @export
#'
#' @examples
read_all_timeseries_df <- function(destination) {

  df <- read.csv(paste0(destination, "all_timeseries_df.csv"))

  return(df)

}
