# ===============================================================================
#
# PROGRAMMERS:
#
# jean-romain.roussel.1@ulaval.ca  -  https://github.com/Jean-Romain/lidR
#
# COPYRIGHT:
#
# Copyright 2016 Jean-Romain Roussel
#
# This file is part of lidR R package.
#
# lidR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# ===============================================================================



#' Select LAS files interactively
#'
#' Select a set of LAS tiles from a Catalog using the mouse interactively. This function
#' enables the user to select a set of las files from a Catalog by clicking
#' on the map of the file using the mouse. The selected files will be highlighted in red on
#' the plot after selection is complete.
#' @param x A Catalog object
#' @return A Catalog object
#' @export
#' @examples
#' \dontrun{
#' project = catalog("<Path to a folder containing a set of .las files>")
#' selectedFiles = catalog_select(project)
#' }
#' @seealso
#' \link[lidR:catalog]{Catalog}
catalog_select = function(x)
{
  `Min X` <- `Min Y` <- `Max X` <- `Max Y` <- filename <- NULL

  graphics::plot(x)
  selected = with(x, identify_tile(`Min X`, `Max X`, `Min Y`, `Max Y`))
  return(x[selected])
}

identify_tile <- function(minx, maxx, miny, maxy, plot = FALSE, ...)
{
  n <- length(minx)
  x <- (minx + maxx)/2
  y <- (miny + maxy)/2

  sel <- rep(FALSE, n)

  while(sum(sel) < n)
  {
    ans <- graphics::identify(x[!sel], y[!sel], n = 1, plot = FALSE, ...)

    if(!length(ans))
      break

    ans <- which(!sel)[ans]

    graphics::rect(minx[ans], miny[ans], maxx[ans], maxy[ans], col = "forestgreen")

    sel[ans] <- TRUE
  }

  return(which(sel))
}