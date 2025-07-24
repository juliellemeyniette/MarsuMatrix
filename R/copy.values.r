#' Copy values to memory mapped object
#'
#' @rdname copy.values
#' @aliases copy.values
#' 
#' @param x a memory mapped object
#' @param values a R object or a memory mmaped object
#' 
#' @details Copy \code{values} to \code{x}, recycling if necessary. This
#' function modifies \code{x} in-place.
#' 
#' @export 
copy.values <- function(x, values) UseMethod("copy")

#' @rdname copy.values
setMethod("copy.values", c(x = "memoryMapped", values = "numericOrArray"), 
  function(x, values) {
    copy_values(x, values)
  }
)

#' @rdname copy.values
setMethod("copy.values", c(x = "memoryMapped", values = "memoryMapped"), 
  function(x, values) {
    copy_values_mm(x, values)
  }
)


