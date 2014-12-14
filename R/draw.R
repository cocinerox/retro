#' Coordinate Text
#'
#' Create a coordinated data frame from a file or text vector.
#' @param file input file
#' @param text input text. Defaults to \code{readLines(file)}.
#' @param x0 minimal x coordinate to use. Defaults to \code{1}.
#' @param y0 minimal y coordinate to use. Defaults to \code{1}.
#' @param fc foreground color constant. Defaults to \code{NA} which results in the terminal default.
#' @param bc background color constant. Defaults to \code{NA} which results in the terminal default.
#' @export
#' @examples
#' coordinate(retro_example("hello_world"))

coordinate <- function(file, text = readLines(file), x0 = 1, y0 = 1, fc = NA, bc = NA) {
  ch <- strsplit(paste0(text, ' '), '')
  x <- as.list(seq_along(ch))
  y <- lapply(ch, seq_along)
  D <- Map(function(x, y, ch) data.frame0(x = x - 1 + x0 , y = y - 1 + y0, ch = ch, fc = fc, bc = bc), x, y, ch)
  d <- do.call(rbind, D)
  d[d$ch != ' ', ]
}


#' Generate Border
#'
#' Generates a border (rectangle) as a coordinated data frame.
#' @param h height of the border. Defaults to \code{27}.
#' @param w width of the border. Defaults to \code{52}.
#' @param fc foreground color constant. Defaults to \code{NA} which results in the terminal default.
#' @param bc background color constant. Defaults to \code{NA} which results in the terminal default.
#' @export
#' @examples
#' generate_border()

generate_border <- function(h = 27, w = 52, fc = NA, bc = NA) {
  data.frame0(
    x  = c(rep(0, w), 1:(h - 2), rep(h - 1, w), (h - 2):1),
    y  = c((w - 1):0, rep(0, h - 2), 0:(w - 1), rep(w - 1, h - 2)),
    ch = c('+', rep('-', w - 2), '+', rep('|', h - 2), '+', rep('-', w - 2), '+', rep('|', h - 2)),
    fc = fc,
    bc = bc
  )    
}


#' Draw
#'
#' Draw on the terminal. The source is a coordinated data frame.
#' @param d data frame to draw. Columns required: \code{x} and \code{y} with coordinates (top left is (0,0), \code{x} increases downwards, \code{y} increases rightwards). Warning: duplicated rows (regarding \code{x} and \code{y}) are excluded. Columns optional: \code{ch} with the characters to draw, \code{fc} and \code{bc} with the foreground and background color constants. 
#' @param ch the character to use if not given in the data frame. Defaults to \code{"o"}.
#' @param fc the foreground color constant to use if not given in the data frame. Defaults to \code{NA} which results in the terminal default.
#' @param bc the background color constant to use if not given in the data frame. Defaults to \code{NA} which results in the terminal default.
#' @param h the height of the space where the drawing is placed. Defaults to \code{28}.
#' @param t seconds to wait after drawing. Defaults to \code{0.01}. 
#' @param text text to write at the end of the drawing. Defaults to empty string. 
#' @export
#' @examples
#' draw(data.frame(x = c(1:20, 20:1), y = c(1:20, 1:20)))
#' draw(coordinate(retro_example("hello_world")))

draw <- function(d, ch = 'o', fc = NA, bc = NA, h = 28, t = 0.01, text = '') {
  d <- d[!duplicated(d[c('x', 'y')]), ]
  d <- d[order(d$x, d$y), ]
  N <- nrow(d)
  if (is.null(d$ch)) d$ch <- ch
  if (is.null(d$fc)) d$fc <- fc
  if (is.null(d$bc)) d$bc <- bc
  dx <- diff(c(0, d$x))
  dy <- d$y - (dx == 0) * c(0, d$y[-N] + 1)
  z <- paste1(
    sapply(dx, function(e) reps('\n', e)),
    sapply(dy, function(e) reps(' ', e)),
    colorize(d$ch, fc = d$fc, bc = d$bc)
  )
  p <- paste1(z, reps('\n', h - d$x[N]), text)
  clear_screen()
  cat(p)
  flush.console()
  Sys.sleep(t)
}


#' Draw with Effects
#'
#' Draw with effects on the terminal.
#' @param file input file
#' @param coords input coordinates. Defaults to \code{coordinate(file)}.
#' @param effect effect to apply. Possible values: \code{"default"}, \code{"random_order"}, \code{"from_right"}.
#' @param w width of drawing used with effect \code{"from_right"}. Defaults to \code{20}.
#' @param t seconds between frames, passed to function \code{draw}. Defaults to \code{0.01}.
#' @export
#' @examples
#' \dontrun{draw_effect(retro_example('hello_world'), effect = "from_right")}

draw_effect <- function(file, coords = coordinate(file), effect = 'default', w = 20, t = 0.01) {
  d <- coords
  if (effect == 'default') {
    for (i in 1:nrow(d)) {
        draw(d[1:i, ], t = t)
    }
  } else if (effect == 'random_order') {
    d <- d[sample(1:nrow(d)), ]
    for (i in 1:nrow(d)) {
        draw(d[1:i, ], t = t)
    }
  } else if (effect == 'from_right') {
    for (i in 1:nrow(d)) {
      e <- d[1:i, ]
      for (j in w:d$y[i]) {
        e$y[i] <- j
        draw(e, t = t)
      }
    }
  }
}
