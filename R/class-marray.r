#' Class \code{"marray"}
#' @name marray-class
#' @docType class
#' 
#' @description  S4 class for memory-mapped arrays 
#' 
#' @section Objects from the Class:
#' Objects can be created by calls of the form \code{marray(...)}.
#'
#' @slot ptr
#' \code{externalptr} to an instance of the C++ \code{MMatrix} class, itself handling
#' the internal memory structure of the file.
#' @slot file
#' \code{character} with the path (absolute) of the file used to store the mmatrix. 
#' @slot dim
#' \code{vector} keeping the dimensions of the matrix. Using \code{ncol(x = mmatrix)} or \code{nrow(x = mmatrix)}
#' will respectively link to \code{dim[1]} and \code{dim[2]}
#' because the size of mapping depends on this dim, changing it should not be possible nor effective
#' @slot datatype
#' \code{character} with the C++ underlying datatype.
#' @slot readonly \code{logical} Indicates if the matrix if read only.
#' 
#' @seealso \link{mmatrix-class}, \link{mvector-class}
#' @seealso \link{read.mmatrix}, \link{as.matrix.mmatrix}, \link{create.descriptor.file}
#'
#' @exportClass marray
setClass("marray", slots = c(ptr = "externalptr", file = "character", dim = "integer", datatype = "character", readonly = "logical"))

setMethod("show", "marray",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A marray with a broken external ptr ! Try using restore()\n")
    } else {
      if(object@readonly)
        cat("A read only ")
      else 
        cat("A ")
      cat("marray with dimensions", paste(object@dim, sep =", "), "\n")
      cat("data type: ", object@datatype, "\n")
      cat("File:", object@file, "\n")
    }
  }
)
