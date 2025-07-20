# ------------------ replacement is an R object --------------------

replace_value_marray <- function(x, L, value) {
  if(x@readonly) stop("Read only object")
  d <- length(L)
  if(d != length(x@dim)) stop("Incorrect number of dimensions\n")
  tsize <- 1L # target size
  for(i in seq_along(L)) {
    L[[i]] <- as.integer(L[[i]]) - 1L
    tsize <- tsize * length(L[[i]])
  }
  if(x@datatype == "float" | x@datatype == "double") {
    val <- as.double(value)
  } else if(x@datatype == "int" | x@datatype == "short") {
    val <- as.integer(value)
  } else {
    stop("Unsupported data type")
  }
  set_values_marray(x@ptr, x@datatype, L, value)
  x
}

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "numeric", j = "numeric", value = "numeric"),
  function(x, i, j, ..., value) {
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- i
    L[[2]] <- j
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray(x, L, value)
  }
)

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "missing", j = "numeric", value = "numeric"),
  function(x, i, j, ..., value) {
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- 1:x@dim[1]
    L[[2]] <- j
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray(x, L, value)
  }
)

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "numeric", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) {
    if(nargs() == 2L) { # appel de type x[i]
      extract_mvector(x, i)
    } else {
      if(...length() != length(x@dim) - 2L)
        stop("Incorrect number of dimensions")
      L <- vector("list", length(x@dim))
      L[[1]] <- i
      L[[2]] <- 1:x@dim[2]
      for(k in seq_len(...length())) {
        if(myMissing(...elt(k)))
          L[[k + 2L]] <- 1:x@dim[k + 2L]
        else
          L[[k + 2L]] <- ...elt(k)
      }
      replace_value_marray(x, L, value)
    }
  }
)

#' @rdname marray-methods 
setMethod("[<-", c(x = "marray", i = "missing", j = "missing", value = "numeric"),
  function(x, i, j, ..., value) {
    # length = 0 correspond à un appel x[] <- value
    if(...length() == 0) {
      return(copy_values(x, value))
    }
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- 1:x@dim[1]
    L[[2]] <- 1:x@dim[2]
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray(x, L, value)
  }
)
# ------------------ replacement is a memory mapped object  --------------------

replace_value_marray_ma <- function(x, L, value) {
  if(x@readonly) stop("Read only object")
  d <- length(L)
  if(d != length(x@dim)) stop("Incorrect number of dimensions\n")
  tsize <- 1L # target size
  for(i in seq_along(L)) {
    L[[i]] <- as.integer(L[[i]]) - 1L
    tsize <- tsize * length(L[[i]])
  }
  set_values_marray_ma(x@ptr, x@datatype, L, value@ptr, value@datatype)
  x
}

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "numeric", j = "numeric", value = "memoryMapped"),
  function(x, i, j, ..., value) {
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- i
    L[[2]] <- j
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray_ma(x, L, value)
  }
)

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "missing", j = "numeric", value = "memoryMapped"),
  function(x, i, j, ..., value) {
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- 1:x@dim[1]
    L[[2]] <- j
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray_ma(x, L, value)
  }
)

#' @rdname marray-methods
setMethod("[<-", c(x = "marray", i = "numeric", j = "missing", value = "memoryMapped"),
  function(x, i, j, ..., value) {
    if(nargs() == 2L) { # appel de type x[i]
      extract_mvector(x, i)
    } else {
      if(...length() != length(x@dim) - 2L)
        stop("Incorrect number of dimensions")
      L <- vector("list", length(x@dim))
      L[[1]] <- i
      L[[2]] <- 1:x@dim[2]
      for(k in seq_len(...length())) {
        if(myMissing(...elt(k)))
          L[[k + 2L]] <- 1:x@dim[k + 2L]
        else
          L[[k + 2L]] <- ...elt(k)
      }
      replace_value_marray_ma(x, L, value)
    }
  }
)

#' @rdname marray-methods 
setMethod("[<-", c(x = "marray", i = "missing", j = "missing", value = "memoryMapped"),
  function(x, i, j, ..., value) {
    # length = 0 correspond à un appel x[] <- value
    if(...length() == 0) {
      return(copy_values_mm(x, value))
    }
    if(...length() != length(x@dim) - 2L)
      stop("Incorrect number of dimensions")
    L <- vector("list", length(x@dim))
    L[[1]] <- 1:x@dim[1]
    L[[2]] <- 1:x@dim[2]
    for(k in seq_len(...length())) {
      if(myMissing(...elt(k)))
        L[[k + 2L]] <- 1:x@dim[k + 2L]
      else
        L[[k + 2L]] <- ...elt(k)
    }
    replace_value_marray_ma(x, L, value)
  }
)

