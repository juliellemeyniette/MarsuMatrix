#' @name mvector
#' @rdname mvector
#' @title mvector
#'
#' @description A class for manipulation of memory mapped file
#' @exportClass mvector
#'
#'
# DIM should have a vector of mode integer to be compatible with nrow (dim(x)[1]) ncol (dim(x)[2])
setClass("mvector", slots = c(ptr = "externalptr", file = "character", length = "integer", datatype = "character"))

setMethod("show", "mvector",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A mvector with a broken external ptr ! Try using restore()\n")
    } else {
      cat("A mvector of length", object@length, "\n")
      cat("containing data of type : ", object@datatype, "\n")
      cat("File:", object@file, "\n")
    }
  }
)

setMethod("length", "mvector", function(object) object@length)
