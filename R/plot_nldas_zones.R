#' Title
#'
#' @param destination
#' @param parameter
#'
#' @return
#' @export
#'
#' @examples
plot_nldas_zones <- function(destination, parameter) {


  zone_map <- read.csv(paste0(destination, parameter, "-zone_map.csv")) %>%
    dplyr::mutate(grid = paste0(NLDAS_X_Grid, "-", NLDAS_Y_Grid),
                  zonal_rep = "yes") %>%
    dplyr::select(zone, grid, zonal_rep)
  zone_weight <- read.csv(paste0(destination, parameter, "-zone_weight.csv"))


  #Read in raw data files as timeseries
  file_list <- as.character(unique(zone_weight$file))

  timeseries <- file_list %>%
    purrr::map_dfr(read_raw_NLDAS_timeseries)

  df <- zone_weight %>%
    left_join(timeseries, by="file") %>%
    mutate(year = lubridate::year(date_time_local),
           grid = paste0(NLDAS_X_Grid, "-", NLDAS_Y_Grid))


  dir.create(paste0(destination, "Plots/"))

#Summarize Total Precip and Plot
  totals <- df %>%
    dplyr::group_by(grid, zone, weight) %>%
    dplyr::summarize(total_in = sum(precipitation_in)) %>%
    dplyr::left_join(zone_map, by = c("zone", "grid")) %>%
    dplyr::mutate(zonal_rep = tidyr::replace_na(zonal_rep, "no"))


  ggplot(totals) +
    geom_col(aes(x=grid, y=total_in, fill=zonal_rep)) +
    facet_wrap(zone~., scales="free_x") +
    scale_fill_manual(values = c("grey70", "firebrick3")) +
    ylab("precipitation (inches)") +
    xlab("NLDAS Grid") +
    ggtitle("NLDAS Grids by Precipiation Zone") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90),
          panel.background = element_rect(color = "grey98", fill = "grey98")) +
    ggsave(paste0(destination, "Plots/Total_Zonal_Precip_Bar_Chart.pdf"), height = 11, width = 8.5)



  #Summarize annaul Average Precip and Plot

  annual_avg <- df %>%
    dplyr::group_by(grid, year, zone, weight) %>%
    dplyr::summarize(annual_sum_in = sum(precipitation_in)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(grid, zone, weight) %>%
    dplyr::summarize(annual_avg_in = mean(annual_sum_in)) %>%
    dplyr::left_join(zone_map, by = c("zone", "grid")) %>%
    dplyr::mutate(zonal_rep = tidyr::replace_na(zonal_rep, "no"))


  ggplot(annual_avg) +
    geom_col(aes(x=grid, y=annual_avg_in, fill=zonal_rep)) +
    facet_wrap(zone~., scales="free_x") +
    scale_fill_manual(values = c("grey70", "firebrick3")) +
    ylab("precipitation (inches)") +
    xlab("NLDAS Grid") +
    ggtitle("NLDAS Grids by Precipiation Zone") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90),
          panel.background = element_rect(color = "grey98", fill = "grey98")) +
    ggsave(paste0(destination, "Plots/Annual_Avg_Zonal_Precip_Bar_Chart.pdf"), height = 11, width = 8.5)

}
