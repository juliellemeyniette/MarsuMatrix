#' Add a Descriptor File to an mmatrix Object
#'
#' This generic function adds a descriptor file to an `mmatrix` object.
#'
#' @param object An object of class `mmatrix`. Must contain the slots `file`, `dim`, and `datatype`.
#'
#' @return Invisibly returns `NULL`. The function is called for its side effect of writing a descriptor file.
#'
#' @details This function wraps around an internal helper `mk.descriptor.file()` that creates a descriptor
#' file for a matrix stored on disk.
#'
#' @seealso \link{mk.descriptor.file}
#'
#' @export
#'
#' @export
setGeneric("add.descriptor.file", function(object) standardGeneric("add.descriptor.file"))

#' @export
setMethod("add.descriptor.file", "mmatrix",
function(object) {
  mk.descriptor.file(object@file, object@dim[1], object@dim[2], object@datatype)
})