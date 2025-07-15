#' Converting memory mapped matrices (on disk) 
#' to R matrices (in memory)
#' 
#' @name as.matrix.mmatrix
#'
#' @exportS3Method as.matrix mmatrix
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
    as.vector(R)
  }
}
