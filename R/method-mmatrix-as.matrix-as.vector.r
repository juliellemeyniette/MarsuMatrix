#' Converting memory mapped matrices (on disk) 
#' to R matrices (in memory)
#'
#' @exportS3Method as.matrix mmatrix
#' @export
as.matrix.mmatrix <- function(x) {
  if(isnullptr(x@ptr)) {
    stop("This mmatrix has a broken ptr, try re-mapping it with restore()")
  } else {
    MMatrixToRMatrix(x@ptr, x@datatype)
  }
}

#' @exportS3Method as.vector mmatrix
as.vector.mmatrix <- function(x, mode = "any") {
  if(isnullptr(x@ptr)) {
    stop("This mmatrix has a broken ptr, try re-mapping it with restore()")
  } else {
    R <- MMatrixToRMatrix(x@ptr, x@datatype)
    as.vector(R, mode)
  }
}
