#' @export
marray <- function(type = c("double", "float", "int", "int16_t"), dim, filename) {
  type <- match.arg(type)
  if(missing(filename)) filename <- tempfile("mmatrix")
  readonly <- file.exists(filename)
  ptr <- link_marray(type, filename, dim)
  if(isnullptr(ptr)) stop("Failed to map the marray")
  new("marray", ptr = ptr, file = filename, dim = as.integer(dim), datatype = type, readonly = readonly)
}
