#' Title
#'
#' @param built_queries
#'
#' @return
#' @export
#'
#' @examples
query_nldas <- function(queries) {

  query_vector <- as.character(queries$query)
  queries$query <- paste(as.character(queries$query))
  queries$destination <- paste(as.character(queries$destination))

  for(query_n in query_vector) {
    dest <- queries %>%
      filter(query == query_n) %>%
      select(destination)
    download.file(url = query_n, destfile = dest[1,1])
  }
}
