# retro

[![Build Status](https://travis-ci.org/cocinerox/retro.png?branch=master)](https://travis-ci.org/cocinerox/retro)

Tools for having fun on the R terminal, including snake or ASCII animation. R Console is not supported. Colorful characters can be used under *nix. Windows terminal flashes, unfortunately. Initial release.

## Installation

Install from github with devtools:

```
library(devtools)
install_github("cocinerox/retro")
library(retro)
```

## Play snake

Play snake on the default level (left turn: "a"; right turn: "d"):

```
play_snake()
```

## Animate

ASCII animation examples:

```
draw_effect(retro_example('hello_world'))
draw_effect(retro_example('hello_world'), effect = "random_order")
draw_effect(retro_example('hello_world'), effect = "from_right")
```
