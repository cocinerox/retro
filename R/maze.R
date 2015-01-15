#' Generate a random basic maze
#' @param w width
#' @param h height
#' @return \code{data.frame} ready to be passed to \code{draw}
#' @export
#' @examples
#' draw(generate_maze())
#' draw(generate_maze(10, 10))
#' draw(generate_maze(80, 25))
#' @references \url{http://10print.org/}
generate_maze <- function(w = 25, h = 25)
    data.frame(
        x  = 1:w,
        y  = rep(1:h, each = w),
        ch = sample(c('\u2571', '\u2572'), w * h, TRUE),
        stringsAsFactors = FALSE
    )
