#' @export
setGeneric("add.descriptor.file", function(object) standardGeneric("add.descriptor.file"))

#' @export
setMethod("add.descriptor.file", "mmatrix",
function(object) {
  mk.descriptor.file(object@file, object@dim[1], object@dim[2], object@datatype)
})