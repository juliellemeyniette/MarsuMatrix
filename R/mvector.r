#' @export
mvector <- function(type = c("double", "float", "int"), length, filename) {
  type <- match.arg(type)
  if(missing(filename)) filename <- tempfile("mmatrix")
  # on the C++ size mvector are mmatrices with ncol = 1
  ptr <- link_mmatrix(type, filename, length, 1L)
  if(isnullptr(ptr)) stop("Failed to map the mvector")
  new("mvector", ptr = ptr, file = filename, length = as.integer(length), datatype = type)
}
