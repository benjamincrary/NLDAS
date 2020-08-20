#' Title
#'
#' @param destination
#' @param parameter
#'
#' @return
#' @export
#'
#' @examples
plot_nldas_zones <- function(multi_timeseries_df) {

  #create plot directory if it does not exist
  dir.create(paste0(destination, "Plots/"))

  #Summarize Total Precip and Plot
  totals <- df %>%
    dplyr::group_by(grid, zone, weight) %>%
    dplyr::summarize(total_in = sum(precipitation_in)) %>%
    dplyr::left_join(zone_map, by = c("zone", "grid")) %>%
    dplyr::mutate(zonal_rep = tidyr::replace_na(zonal_rep, "no"))


  ggplot2::ggplot(totals) +
    ggplot2::geom_col(aes(x=grid, y=total_in, fill=zonal_rep)) +
    ggplot2::facet_wrap(zone~., scales="free_x") +
    ggplot2::scale_fill_manual(values = c("grey70", "firebrick3")) +
    ggplot2::ylab("precipitation (inches)") +
    ggplot2::xlab("NLDAS Grid") +
    ggplot2::ggtitle("NLDAS Grids by Precipiation Zone") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = element_text(angle = 90),
          panel.background = element_rect(color = "grey98", fill = "grey98")) +
    ggplot2::ggsave(paste0(destination, "Plots/Total_Zonal_Precip_Bar_Chart.pdf"), height = 11, width = 11)



  #Summarize annaul Average Precip and Plot

  annual_avg <- df %>%
    dplyr::group_by(grid, year, zone, weight) %>%
    dplyr::summarize(annual_sum_in = sum(precipitation_in)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(grid, zone, weight) %>%
    dplyr::summarize(annual_avg_in = mean(annual_sum_in)) %>%
    dplyr::left_join(zone_map, by = c("zone", "grid")) %>%
    dplyr::mutate(zonal_rep = tidyr::replace_na(zonal_rep, "no"))


  ggplot2::ggplot(annual_avg) +
    ggplot2::geom_col(aes(x=grid, y=annual_avg_in, fill=zonal_rep)) +
    ggplot2::facet_wrap(zone~., scales="free_x") +
    ggplot2::scale_fill_manual(values = c("grey70", "firebrick3")) +
    ggplot2::ylab("precipitation (inches)") +
    ggplot2::xlab("NLDAS Grid") +
    ggplot2::ggtitle("NLDAS Grids by Precipiation Zone") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = element_text(angle = 90),
          panel.background = element_rect(color = "grey98", fill = "grey98")) +
    ggplot2::ggsave(paste0(destination, "Plots/Annual_Avg_Zonal_Precip_Bar_Chart.pdf"), height = 11, width = 11)

}
