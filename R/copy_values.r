
copy_values <- function(x, value) {
  if(x@datatype == "float" | x@datatype == "double") val <- as.double(value)
  if(x@datatype == "int" | x@datatype == "int16_t" ) val <- as.integer(value)
  copy_values_(x@ptr, x@datatype, value)
  x
}

copy_values_mm <- function(x, value) {
  copy_values_mm_(x@ptr, x@datatype, value@ptr, value@datatype)
  x
}
