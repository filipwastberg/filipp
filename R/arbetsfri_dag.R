#' Get arbetsfria dagar
#'
#' @param year year that you want to know arbetsfria dagar for
#' @examples
#' \dontrun{
#' arbetsfri_dag(2019)
#' }
#' @import data.table
#' @importFrom magrittr %>% 
#' @export

arbetsfri_dag <- function(year){
  df <- httr::GET(paste0("http://api.dryg.net/dagar/v2.1/", year)) %>%
    httr::content(type = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(simplifyDataFrame = TRUE) %>%
    tibble::as_tibble() %>%
    jsonlite::flatten() %>%
    janitor::clean_names() %>%
    data.table::as.data.table()
  
  cols = c("dagar_datum", "dagar_arbetsfri_dag", "dagar_helgdag")
  
  df <- df[, ..cols]
  
  df <- df[, `:=` (datum = as.Date(dagar_datum),
                   arbetsfri_dag = ifelse(dagar_arbetsfri_dag == "Ja", TRUE, FALSE))]
  
  cols <- c("datum", "arbetsfri_dag", "dagar_helgdag")
  
  df <- df[, ..cols]
  
  return(df)
}