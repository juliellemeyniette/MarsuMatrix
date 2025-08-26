#' Converting memory-mapped objects to R objects
#'
#' @rdname as-array
#' 
#' @param x memory-mapped object to convert
#' @param mode the mode oh the created vector
#' @param ... extra parameters (ignored)
#'
#' @exportS3Method as.array marray
as.array.marray <- function(x, ...) {
  if(isnullptr(x@ptr)) {
    stop("This mvector has a broken ptr, try re-mapping it with restore()")
  } else {
    MMatrixToRArray(x@ptr, x@datatype)
  }
}

#' @rdname as-array
#' @exportS3Method as.vector marray
as.vector.marray <- function(x, mode = "any") {
  if(isnullptr(x@ptr)) {
    stop("This mmatrix has a broken ptr, try re-mapping it with restore()")
  } else {
    R <- MMatrixToRArray(x@ptr, x@datatype)
    as.vector(R, mode)
  }
}
