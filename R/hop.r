#' Set maxsize for R objects 
#'
#' @param max.size maximum size of a R object created by subsetting an mvector or an mmatrix
#'  
#'
#' @details when subsetting an mvector or an mmatrix, if the size of the resulting object 
#' is greater than `max.size`, then the result will be a memory mapped object (mvector or mmatrix),
#' else if will be a R object (vector or matrix).
#' The default value is 1e6.
#' Set `max.size` to `0` to always get a memory mapped object and to `Inf` to always get a R object.
#'
#' @export
houba <- function(max.size) {
  if(missing(max.size))
    return(get("maxSize", envir = houba.hop))
  else
    assign("maxSize", max.size, envir = houba.hop)
}

houba.hop <- new.env()
assign("maxSize", 1e6, envir = houba.hop)
