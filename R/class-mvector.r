#' Class \code{"mvector"}
#' @name mvector-class
#' @docType class
#' 
#' @description  S4 class for memory-mapped vector of type \code{double}, \code{float}, \code{int} and \code{short}
#' 
#' @section Objects from the Class:
#' Objects can be created by calls of the form \code{ mvector(x = "datatype", y = "length")}.
#' @seealso \link{mvector}
#'
#' @slot ptr
#' \code{externalptr} to an instance of the C++ \code{MMatrix} class, itself handling
#' the internal memory structure of the file.
#' @slot file
#' \code{character} with the path (absolute) of the file used to store the mvector. 
#' @slot length
#' \code{vector} keeping the size of the vector.
#' Once it is initiated  it cannot be changed because the size of mapping depends on it. 
#' (more exactly, changing this slot won't have any effect...)
#' @slot datatype
#' \code{character} with the C++ underlying datatype. For now only \code{short}, \code{int}, \code{float} and \code{double} are recognized.
#' 
#' @details
#' Because the backend of \code{mvector} also uses the C++ \code{MMatrix} class,
#' it is only a shortcut to a \code{MMatrix} of \code{nrow == length} and \code{ncol == 1}.
#' If you need to have more than 1 column, try looking into \link{mmatrix-class}
#' 
#' @section Methods:
#' \describe{
#' \item{[}{\code{signature(x = "mvector", i = "numeric" or "logical" or "missing",}\cr\code{j = "numeric" or "logical" or "missing", drop = "missing")}:
#' \cr Extract a sub-vector (a new \code{mvector}).}
#' 
#' \item{as.vector}{\code{signature(x = "mvector")}:
#' \cr Convert a \code{mvector} into an R \link{vector}.
#' The whole point of this package was to NOT have an enormous object loaded,
#' but you can use this method for a small mvector or a snippet !}
#' 
#' \item{restore}{\code{signature(x = "mvector")}:
#' \cr Regain access to the \code{mvector} content when the \code{ptr} to it is broken / null
#' by remapping the file.
#' }
#' }
#' 
#' @seealso \link{as.matrix.mvector}, \link{create.descriptor.file}, \link{restore.mvector}

#' @exportClass mvector
#'
#'
setClass("mvector", slots = c(ptr = "externalptr", file = "character", length = "integer", datatype = "character"))

setMethod("show", "mvector",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A mvector with a broken external ptr ! Try using restore()\n")
    } else {
      cat("A mvector of length", object@length, "\n")
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
