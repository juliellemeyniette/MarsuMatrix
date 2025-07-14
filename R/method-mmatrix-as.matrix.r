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
    return(MMatrixToRMatrix(x@ptr, x@datatype))
  }
}
