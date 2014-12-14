#' Concatenate Strings
#'
#' Concatenate vectors into a single string.
#' @param ... passed to \code{paste0} with \code{collapse = ""}
#' @keywords internal

paste1 <- function(...) {
  paste0(..., collapse = '')
}


#' Replicate Elements of Vectors
#'
#' Replicate elements of vectors and concatenate the result into a single string.
#' @param s vector to replicate
#' @param n number of times to repeat
#' @keywords internal

reps <- function(s, n) {
  paste1(rep(s, n))
}


#' Data Frames
#'
#' Create a data frame with \code{stringsAsFactors = FALSE}.
#' @param ... passed to \code{data.frame} with \code{stringsAsFactors = FALSE}
#' @keywords internal

data.frame0 <- function(...) {
  data.frame(..., stringsAsFactors = FALSE)
}


#' Path to Package Examples
#'
#' Returns the path to \code{retro} example text files.
#' @param file filename of the example without ".txt"
#' @export
#' @examples
#' retro_example("hello_world")

retro_example <- function(file) {
  system.file(package = "retro", "examples", paste1(file, ".txt"))
}
