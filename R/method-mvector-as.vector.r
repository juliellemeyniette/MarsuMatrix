#' Converting memory mapped vectors (on disk) 
#' to R vectors (in memory)
#' 
#' @exportS3Method as.vector mvector
as.vector.mvector <- function(x, mode = "any") {
  if(isnullptr(x@ptr)) {
    stop("This mvector has a broken ptr, try re-mapping it with restore()")
  } else {
    V <- MMatrixToRMatrix(x@ptr, x@datatype)
    as.vector(V)
  }
}
