#' @export
read.mmatrix <- function(basename) {
    desc <- path.expand(paste0(basename, ".desc"))
    if(!file.exists(basename)) stop("file ", basename, " not found")
    if(!file.exists(desc)) stop("file ", bdesc, " not found")

    z <- scan(desc, character(), Inf, quote = "", quiet = TRUE)
    parsed_desc <- eval(parse(text = paste( c( "(", z[ -(1:3) ] ), collapse = " " )))
    # TODO : think of array, is keeping the dim like that a good idea ?

    datatype = parsed_desc$type
    file = parsed_desc$file
    if (file != basename) {
        #stop("wtf \n file in f° :", basename, "\n file in descriptor file : ", file)
        file = basename
    }
    dim= as.integer(c(parsed_desc$ncol, parsed_desc$nrow))
    # I chose to send basename (and not file) bcos a check was made on it
    ptr <- restore_mmatrix_(datatype, basename, dim[2], dim[1])
    if (isnullptr(ptr)) stop("Something went very wrong while mapping the mmatrix")
    new("mmatrix", ptr = ptr, file = basename, dim = dim, datatype = datatype)
}