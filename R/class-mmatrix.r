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
      cat("containing datas of type : ", object@datatype, "\n")
      cat("File:", object@file, "\n")
    }
  }
)

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


#' @export
setGeneric("add.descriptor.file", function(object) standardGeneric("add.descriptor.file"))

#' @export
setMethod("add.descriptor.file", "mmatrix",
function(object) {
  # RV's function : mk.descriptor.file <- function(path, nrow, ncol, type)
  mk.descriptor.file(object@file, object@dim[1], object@dim[2], object@datatype)
})


# // TODO : faire une version capable de restore depuis un .desc !! Ce serait malin :)
# // .desc lu côté R et envoyé a restore_mmatrix => une fonction load_mmatrix ?

# // void load_mmatrix(std::string desc_file) {}
