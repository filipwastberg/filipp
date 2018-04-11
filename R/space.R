#' Function for adding space between thousands in ggplot legens
#'

space <- function(x, ...) {
  format(x, ..., big.mark = " ", scientific = FALSE, trim = TRUE)
}
