#' Terminal Color Constants
#'
#' Terminal color constants.
#' @export
#' @examples
#' x_colors$red

x_colors <- list(
  black   = 0,
  red     = 1,
  green   = 2,
  yellow  = 3,
  blue    = 4,
  magenta = 5,
  cyan    = 6,
  white   = 7
)


#' Colorize Text
#'
#' Colorize text with ANSI escape codes for the *nix terminal.
#' @param s text to colorize
#' @param fc foreground color constant. Defaults to \code{NA} which results in the terminal default.
#' @param bc background color constant. Defaults to \code{NA} which results in the terminal default.
#' @param force if \code{TRUE}, adds color codes even on Windows (see e.g. ConEmu or ansicon). Defaults to \code{FALSE}.
#' @export
#' @examples
#' cat(colorize(0:7, fc = x_colors$black, bc = 0:7))

colorize <- function(s, fc = NA, bc = NA, force = FALSE) {
  if (!force & .Platform$OS.type == 'windows') return(s)
  f  <- ifelse(is.na(fc), '', paste0('\x1b[3', fc, 'm'))
  b  <- ifelse(is.na(bc), '', paste0('\x1b[4', bc, 'm'))
  fb <- ifelse(is.na(fc) & is.na(bc), '', '\x1b[0m')
  paste0(f, b, s, fb)
}


#' Clear Screen
#'
#' Clear the terminal screen. (Console is not supported.)
#' @export
#' @examples
#' clear_screen()

clear_screen <- function() {
  if (.Platform$OS.type == "windows") shell('cls')
  else system('clear')
}


#' Convert Character to ASCII Code
#'
#' Convert character to ASCII code.
#' @param x character to convert
#' @export
#' @examples
#' chr2asc("x")
#' @references See \url{http://datadebrief.blogspot.com/2011/03/ascii-code-table-in-r.html}

chr2asc <- function(x) {
  strtoi(charToRaw(x), 16L)
}


#' Convert ASCII Code to Character
#'
#' Convert ASCII code to character.
#' @param x ASCII code to convert
#' @export
#' @examples
#' asc2chr(120)
#' @references See \url{http://datadebrief.blogspot.com/2011/03/ascii-code-table-in-r.html}

asc2chr <- function(x) {
  rawToChar(as.raw(x))
}


#' Non-Blocking Keyboard Input
#'
#' Non-blocking keyboard input with 10 ms delay. Works only on the terminal (and not on the console).
#' @param n number of loops to wait at most. Defaults to \code{50} (which is 500 ms).
#' @return Returns the ASCII code of the key pressed, or 0 if there was no key pressed.
#' @export 
#' @examples
#' get_ch()
#' @references See \url{http://stackoverflow.com/a/6665815} and \url{http://stackoverflow.com/a/13129698}

get_ch <- function(n = 50) {
  for (i in 1:n) {
    k <- unlist(.C('get_ch', as.integer(1)))
    if (k > 0) break
  }
  k
}
