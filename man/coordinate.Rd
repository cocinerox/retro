% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/draw.R
\name{coordinate}
\alias{coordinate}
\title{Coordinate Text}
\usage{
coordinate(file, text = readLines(file), x0 = 1, y0 = 1, fc = NA,
  bc = NA)
}
\arguments{
\item{file}{input file}

\item{text}{input text. Defaults to \code{readLines(file)}.}

\item{x0}{minimal x coordinate to use. Defaults to \code{1}.}

\item{y0}{minimal y coordinate to use. Defaults to \code{1}.}

\item{fc}{foreground color constant. Defaults to \code{NA} which results in the terminal default.}

\item{bc}{background color constant. Defaults to \code{NA} which results in the terminal default.}
}
\description{
Create a coordinated data frame from a file or text vector.
}
\examples{
coordinate(retro_example("hello_world"))
}

