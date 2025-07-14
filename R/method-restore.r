#' @export
setGeneric("restore", function(object) standardGeneric("restore"))

#' @export
setMethod("restore", "mmatrix",
  function(object) {
    if(!isnullptr(object@ptr)) {
      stop("This mmatrix doesn't need to be restored !")
    } else {
      object@ptr = link_mmatrix(object@datatype, object@file, object@dim[1], object@dim[2])
    }
    object
  }
)

#' @export
setMethod("restore", "mvector",
  function(object) {
    if(!isnullptr(object@ptr)) {
      stop("This mvector doesn't need to be restored !")
    } else {
      object@ptr = link_mmatrix(object@datatype, object@file, object@length, 1L)
    }
    object
  }
)
