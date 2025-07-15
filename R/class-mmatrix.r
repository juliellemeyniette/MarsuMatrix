#' @name mmatrix
#' @rdname mmatrix
#' @title mmatrix
#'
#' @description A class for manipulation of memory mapped file
#' @exportClass mmatrix
#'
#'
# DIM should have a vector of mode integer to be compatible with nrow (dim(x)[1]) ncol (dim(x)[2])
setClass("mmatrix", slots = c(ptr = "externalptr", file = "character", dim = "integer", datatype = "character"))

setMethod("show", "mmatrix",
  function(object) {
    if(isnullptr(object@ptr)) {
      cat("A mmatrix with a broken external ptr ! Try using restore()\n")
    } else {
      cat("A mmatrix with", nrow(object), "rows and", ncol(object), "cols\n")
      cat("data type: ", object@datatype, "\n")
      cat("File:", object@file, "\n")
      cat("--- excerpt\n")
      n <- min(5,nrow(object))
      m <- min(5,ncol(object))
      print(as.matrix(object[seq_len(n), seq_len(m)]))
    }
  }
)

# # TODO : MAYBE add an param excpected type ! (not always numeric ?)
# #' @export
# setGeneric("as.matrix", function(object) standardGeneric("as.matrix"))

# #' @export
# setMethod("as.matrix", "mmatrix",
#   function(object) {
#     if(!isnullptr(object@ptr)) {
#       stop("This mmatrix has a broken ptr, try reloading it with restore()")
#     } else {
#       return(MMatrixToNumericMatrix(object@ptr, object@datatype))
#     }
#   }
# )
