read_raw_NLDAS_timeseries <- function(file) {

  read_length <- length(readLines(file)) - 39 - 2
  data <- read.table(file, skip = 39, nrows = read_length, sep = "Z", row.names=NULL)
  colnames(data) <- c("date_time", "precipitation_mm")

  df <- data %>%
    dplyr::mutate(date = as.Date(date_time, format="%Y-%m-%d %H"),
           hour = stringr::str_sub(date_time, -2,-1)) %>%
    dplyr::mutate(date_time_gmt = as.POSIXct(paste0(date," ", hour, ":00"), format = "%Y-%m-%d %H:%M", tz = "GMT")) %>%
    dplyr::mutate(date_time_local = format(date_time_gmt, tz="America/Chicago", usetz=TRUE)) %>%
    dplyr::select(-date_time, date, hour) %>%
    dplyr::mutate(file = file) %>%
    dplyr::select(file, date_time_gmt, date_time_local, precipitation_mm) %>%
    dplyr::mutate(precipitation_in = precipitation_mm*0.0393701)

}
