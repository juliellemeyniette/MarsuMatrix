replace_value_mmatrix <- function(x, i, j, value) {
  I <- as.integer(i) - 1L
  J <- as.integer(j) - 1L
  if(x@datatype == "float" | x@datatype == "double") {
    val <- as.double(value)
  } else if(x@datatype == "int") {
    val <- as.integer(value)
  } else {
    stop("Unsupported data type")
  }
  set_values_mmatrix(x@ptr, x@datatype, I, J, value)
  x
}

#' @rdname extract 
setMethod("[<-", c(x = "mmatrix", i = "numeric", j = "numeric", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mmatrix(x, i, j, value)
)

#' @rdname extract 
setMethod("[<-", c(x = "mmatrix", i = "missing", j = "numeric", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mmatrix(x, 1:nrow(x), j, value)
)

#' @rdname extract 
setMethod("[<-", c(x = "mmatrix", i = "numeric", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mmatrix(x, i, 1:ncol(x), value)
)

#' @rdname extract 
setMethod("[<-", c(x = "mmatrix", i = "missing", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mmatrix(x, 1:nrow(x), 1:ncol(x), value)
)
