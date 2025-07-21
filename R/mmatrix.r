#' @rdname marray
#' @export
mmatrix <- function(type = c("double", "float", "int", "short"), nrow, ncol, filename, readonly) {
  type <- match.arg(type)
  if(missing(filename)) filename <- tempfile("mmatrix")
  if(missing(readonly)) readonly <- file.exists(filename)
  ptr <- link_mmatrix(type, filename, nrow, ncol)
  if(isnullptr(ptr)) stop("Failed to map the mmatrix")
  new("mmatrix", ptr = ptr, file = filename, dim = as.integer(c(nrow, ncol)), datatype = type, readonly = readonly)
}
