#' Class \code{mvector}
#' @name mvector-class
#' @docType class
#'
#' @description A class for manipulation of memory mapped file
#'
#' @slot ptr
#' \code{externalptr} to an instance of the C++ \code{MMatrix} class, itself handling
#' the internal memory structure of the file.
#' @slot file
#' \code{character} with the path (absolute) of the file used to store the mmatrix. 
#' @slot length \code{integer} the length of the vector
#' @slot datatype
#' \code{character} with the C++ underlying datatype.
#' @slot readonly \code{logical} Indicates if the matrix if read only.
#'
#' @seealso \link{marray-class}, \link{mmatrix-class}
#'
#' @exportClass mvector
setClass("mvector", slots = c(ptr = "externalptr", file = "character", length = "integer", datatype = "character", readonly = "logical"))

setMethod("show", "mvector",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A mvector with a broken external ptr ! Try using restore()\n")
    } else {
      if(object@readonly)
        cat("A read only ")
      else
        cat("A ")
      cat("mvector of length", object@length, "\n")
      cat("data type: ", object@datatype, "\n")
      cat("File:", object@file, "\n")
      cat("--- excerpt\n")
      if( (savevalue <- houba("max.size")) < 5 )
        houba(max.size = 5)
      n <- min(5,object@length)
      print(object[seq_len(n)])
      houba(max.size = savevalue)
    }
  }
)

setMethod("length", "mvector", function(x) x@length)
