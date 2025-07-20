#' Converting memory mapped vectors (on disk) 
#' to R vectors (in memory)
#' 
#' @exportS3Method as.array marray
as.array.marray <- function(x) {
  if(isnullptr(x@ptr)) {
    stop("This mvector has a broken ptr, try re-mapping it with restore()")
  } else {
    MMatrixToRArray(x@ptr, x@datatype)
  }
}

#' @exportS3Method as.vector marray
as.vector.marray <- function(x, mode = "any") {
  if(isnullptr(x@ptr)) {
    stop("This mmatrix has a broken ptr, try re-mapping it with restore()")
  } else {
    R <- MMatrixToRArray(x@ptr, x@datatype)
    as.vector(R, mode)
  }
}
