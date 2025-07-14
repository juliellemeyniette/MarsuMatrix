replace_value_mvector <- function(x, i, value) {
  I <- as.integer(i) - 1L
  if(x@datatype == "float" | x@datatype == "double") val <- as.double(value)
  if(x@datatype == "int") val <- as.integer(value)
  set_values_mmatrix(x@ptr, x@datatype, I, 0L, value)
  x
}

#' @rdname extract 
setMethod("[<-", c(x = "mvector", i = "numeric", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mvector(x, i, value)
)

#' @rdname extract 
setMethod("[<-", c(x = "mvector", i = "missing", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) replace_value_mvector(x, 1:length(x), value)
)
