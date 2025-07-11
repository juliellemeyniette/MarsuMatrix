#' @export
setGeneric("restore", function(object) standardGeneric("restore"))

#' @export
setMethod("restore", "mmatrix",
  function(object) {
    if(!isnullptr(object@ptr)) {
      # maybe a stop is excessive
      stop("This mmatrix doesn't need to be restored !")
    } else {
      object@ptr = restore_mmatrix_(object@datatype, object@file, object@dim[2], object@dim[1])
    }
    # this retunr is very important else object is just a local copy !!
    object
  }
)