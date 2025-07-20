#' Class \code{"mmatrix"}
#' @name mmatrix-class
#' @docType class
#' 
#' @description  S4 class for memory-mapped matrices of type \code{double}, \code{float}, \code{int} and \code{int16_t}
#' 
#' @section Objects from the Class:
#' Objects can be created by calls of the form \code{mmatrix(...)}.
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
#' 
#' @section Methods:
#' \describe{
#' \item{[}{\code{signature(x = "mmatrix", i = "numeric" or "logical" or "missing",}\cr\code{j = "numeric" or "logical" or "missing", drop = "missing")}:
#' \cr Extract a sub-matrix (a new \code{mmatrix}). }
#' 
#' \item{as.matrix}{\code{signature(x = "mmatrix")}:
#' \cr Convert a \code{mmatrix} into a \code{matrix}.
#' The whole point of this package was to NOT have an enormous matrix object,
#' but you can use this method for a small mmatrix or a snippet !}
#' 
#' \item{add.descriptor.file}{\code{signature(x = "mmatrix")}:
#' \cr create a .desc file linked to the mmatrix. 
#' Having this file coupled with the mmatrix file allows you 
#' to re-open the mmatrix elsewhere, and works essentially
#' as a keep for all the information present in the slots.
#' This is compatible with the package \code{big.memory} and its function \code{attach.big.matrix()}
#' }
#' 
#' \item{read.mmatrix}{\code{signature(x = "basename")}:
#' \cr Takes a descriptor.file and use it to open an mmatrix.
#' }
#' }
#' @seealso \link{marray-class}, \link{mvector-class}
#' @seealso \link{read.mmatrix}, \link{as.matrix.mmatrix}, \link{create.descriptor.file}
#'
#' @exportClass mmatrix
setClass("mmatrix", slots = c(ptr = "externalptr", file = "character", dim = "integer", datatype = "character", readonly = "logical"))

setMethod("show", "mmatrix",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A mmatrix with a broken external ptr ! Try using restore()\n")
    } else {
      if(object@readonly)
        cat("A read only ")
      else
        cat("A ")
      cat("mmatrix with", nrow(object), "rows and", ncol(object), "cols\n")
      cat("data type: ", object@datatype, "\n")
      cat("File:", object@file, "\n")
      cat("--- excerpt\n")
      if( (savevalue <- houba("max.size")) < 25 )
        houba(max.size = 25)
      n <- min(5,nrow(object))
      m <- min(5,ncol(object))
      print(object[seq_len(n), seq_len(m)])
      houba(max.size = savevalue)
    }
  }
)
