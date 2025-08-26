copy_values <- function(x, value) {
  if(x@readonly) stop("Read-only object")
  if(x@datatype == "float" | x@datatype == "double") val <- as.double(value)
  if(x@datatype == "int" | x@datatype == "short" ) val <- as.integer(value)
  copy_values_(x@ptr, x@datatype, value)
  invisible(x)
}

copy_values_mm <- function(x, value) {
  if(x@readonly) stop("Read-only object")
  copy_values_mm_(x@ptr, x@datatype, value@ptr, value@datatype)
  invisible(x)
}
