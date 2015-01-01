#' Snake
#'
#' Play snake on the terminal. Default keys: left (relative) is "a", right (relative) is "d".
#' @param file input file that contains the level to play (without border). Defaults to \code{retro_example("snake_default")}.
#' @param left ASCII code of the key that turns the snake left. Vector of enabled ASCII codes can be used as well. Defaults to \code{chr2asc("a")}.
#' @param right ASCII code of the key that turns the snake right. Vector of enabled ASCII codes can be used as well. Defaults to \code{chr2asc("d")}.
#' @param sp initial speed of the snake, positive integer. Smaller is faster. Defaults to \code{20}.
#' @param h height of the level (without border). Defaults to \code{25}.
#' @param w width of the level (without border). Defaults to \code{50}.
#' @param x0 start position of the snake, x coordinate. Defaults to \code{floor(h/2)}.
#' @param y0 start position of the snake, y coordinate. Defaults to \code{floor(w/2)}.
#' @param v initial direction of the snake, a coordinate pair. Defaults to \code{c(0, 1)}.
#' @export
#' @examples
#' \dontrun{play_snake()}

play_snake <- function(file = retro_example("snake_default"), left = chr2asc('a'), right = chr2asc('d'), sp = 20, h = 25, w = 50, x0 = floor(h/2), y0 = floor(w/2), v = c(0, 1)) {
  d1 <- data.frame0(x = x0, y = y0, ch = 'O', fc = x_colors$yellow, bc = NA)
  d2 <- coordinate(file, fc = x_colors$cyan)
  d3 <- generate_border(fc = x_colors$cyan)
  d4 <- data.frame0(x = x0, y = y0, ch = '@', fc = x_colors$green, bc = NA)
  d <- rbind(d1, d2, d3, d4)
  L <- 0
  repeat {
    dup <- duplicated(d[c('x', 'y')])
    if (sum(dup) == 0) {
      d <- d[-(L+1), ]
    } else if (d$ch[dup] == '@') {
      repeat {
        d$x[dup] <- sample(1:h, 1)
        d$y[dup] <- sample(1:w, 1)
        if (sum(duplicated(d[c('x', 'y')])) == 0) break
      }
      L <- L + 1
    } else {
      cat('GAME OVER\n\n')
      break
    }
    draw(d, text = paste0('Length: ', L, '\n'))
    k <- get_ch(max(1, sp + 1 - L))
    if      (k %in% left ) v <- c(v[2],v[1]) * (1 - 2 * abs(v[2]))
    else if (k %in% right) v <- c(v[2],v[1]) * (1 - 2 * abs(v[1]))
    r1 <- d[1, ]
    r1$x <- r1$x + v[1]
    r1$y <- r1$y + v[2]
    r1$ch <- c('v', '^', '>', '<')[match(paste0(v, collapse = ","), c("1,0", "-1,0", "0,1", "0,-1"))]
    d <- rbind(r1, d)
  }
}
