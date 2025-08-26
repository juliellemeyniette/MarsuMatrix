#' In-place arithmetic operations
#' 
#' @name inplace
#' @aliases inplace
#'
#' @param x a memory mapped object
#' @param y a R object or a memory mapped object
#'
#' @details These functions will modify \code{x} in-place, performing
#' the operation indicated by their name.
#'
#' @examples # 
#' @export
inplace.inverse <- function(x) {
  if(x@readonly) stop("Read-only object")
  cw_inverse(x@ptr, x@datatype)
}

#' @rdname inplace
#' @export
inplace.opposite <- function(x) {
  if(x@readonly) stop("Read-only object")
  cw_opposite(x@ptr, x@datatype)
}

#' @rdname inplace
#' @export
inplace.sum <- function(x, y) UseMethod("inplace.sum")

#' @rdname inplace
setMethod("inplace.sum", c(x = "memoryMapped", y = "numeric"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    if(x@datatype == "float" | x@datatype == "double") {
      y <- as.double(y)
    } else if(x@datatype == "int" | x@datatype == "short") {
      y <- as.integer(y)
    } else {
      stop("Unsupported data type")
    }
    cw_sum(x@ptr, x@datatype, y)
  }
)

#' @rdname inplace
setMethod("inplace.sum", c(x = "memoryMapped", y = "memoryMapped"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    cw_sum_mm(x@ptr, x@datatype, y@ptr, y@datatype)
  }
)


#' @rdname inplace
#' @export
inplace.minus <- function(x, y) UseMethod("inplace.minus")

#' @rdname inplace
setMethod("inplace.minus", c(x = "memoryMapped", y = "numeric"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    if(x@datatype == "float" | x@datatype == "double") {
      y <- as.double(y)
    } else if(x@datatype == "int" | x@datatype == "short") {
      y <- as.integer(y)
    } else {
      stop("Unsupported data type")
    }
    cw_minus(x@ptr, x@datatype, y)
  }
)

#' @rdname inplace
setMethod("inplace.minus", c(x = "memoryMapped", y = "memoryMapped"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    cw_minus_mm(x@ptr, x@datatype, y@ptr, y@datatype)
  }
)


#' @rdname inplace
#' @export
inplace.prod <- function(x, y) UseMethod("inplace.prod")

#' @rdname inplace
setMethod("inplace.prod", c(x = "memoryMapped", y = "numeric"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    if(x@datatype == "float" | x@datatype == "double") {
      y <- as.double(y)
    } else if(x@datatype == "int" | x@datatype == "short") {
      y <- as.integer(y)
    } else {
      stop("Unsupported data type")
    }
    cw_prod(x@ptr, x@datatype, y)
  }
)

#' @rdname inplace
setMethod("inplace.prod", c(x = "memoryMapped", y = "memoryMapped"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    cw_prod_mm(x@ptr, x@datatype, y@ptr, y@datatype)
  }
)

#' @rdname inplace
#' @export
inplace.div <- function(x, y) UseMethod("inplace.div")

#' @rdname inplace
setMethod("inplace.div", c(x = "memoryMapped", y = "numeric"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    if(x@datatype == "float" | x@datatype == "double") {
      y <- as.double(y)
    } else if(x@datatype == "int" | x@datatype == "short") {
      y <- as.integer(y)
    } else {
      stop("Unsupported data type")
    }
    cw_div(x@ptr, x@datatype, y)
  }
)

#' @rdname inplace
setMethod("inplace.div", c(x = "memoryMapped", y = "memoryMapped"),
  function(x, y) {
    if(x@readonly) stop("Read-only object")
    cw_div_mm(x@ptr, x@datatype, y@ptr, y@datatype)
  }
)


