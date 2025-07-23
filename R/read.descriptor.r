#' Read big memory descriptor file
#' 
#' @param basename basename of the file 
#' 
#' @details Creates a mmatrix by reading a 'bigmemory' descriptor file.
#' The descriptor file name is obtained by appending ".desc" to the basename.
#' 
#' @seealso \link{add.descriptor.file}
#' 
#' @export
read.descriptor <- function(basename) {
    desc <- path.expand(paste0(basename, ".desc"))
    if(!file.exists(basename)) stop("file ", basename, " not found")
    if(!file.exists(desc)) stop("file ", desc, " not found")

    z <- scan(desc, character(), Inf, quote = "", quiet = TRUE)
    parsed_desc <- eval(parse(text = paste( c( "(", z[ -(1:3) ] ), collapse = " " )))
    # TODO : think of array, is keeping the dim like that a good idea ?

    datatype <- parsed_desc$type
    file <- parsed_desc$file
    if (file != basename) {
        #stop("wtf \n file in f° :", basename, "\n file in descriptor file : ", file)
        file = basename
    }
    dim <- as.integer(c(parsed_desc$nrow, parsed_desc$ncol))
    # I chose to send basename (and not file) bcos a check was made on it
    ptr <- link_mmatrix(datatype, basename, dim[1], dim[2])
    if (isnullptr(ptr)) stop("Failed to map the mmatrix")
    new("mmatrix", ptr = ptr, file = basename, dim = dim, datatype = datatype)
}
