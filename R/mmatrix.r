#' @export
mmatrix <- function(type = c("double", "float", "int", "int16_t"), nrow, ncol, filename) {
  type <- match.arg(type)
  if(missing(filename)) filename <- tempfile("mmatrix")
  readonly <- file.exists(filename)
  ptr <- link_mmatrix(type, filename, nrow, ncol)
  if(isnullptr(ptr)) stop("Failed to map the mmatrix")
  new("mmatrix", ptr = ptr, file = filename, dim = as.integer(c(nrow, ncol)), datatype = type, readonly = readonly)
}
