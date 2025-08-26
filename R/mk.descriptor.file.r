mk.descriptor.file <- function(path, nrow, ncol, type) {
  dir <- dirname(path)
  fil <- basename(path)
  
  d <- sprintf("new(\"big.matrix.descriptor\", description = list(sharedType = \"FileBacked\",\n filename = \"%s\", ", fil)
  d <- paste0(d, sprintf("dirname = \"%s\",\n ", dir))
  d <- paste0(d, sprintf("totalRows = %dL, totalCols = %dL,\n ", nrow, ncol))
  d <- paste0(d, sprintf("rowOffset = c(0, %dL), colOffset = c(0, %dL),\n ", nrow, ncol))
  d <- paste0(d, sprintf("nrow = %d, ncol = %d,\n ", nrow, ncol))
  d <- paste0(d, sprintf("rowNames = NULL, colNames = NULL, type = \"%s\", separated = FALSE))\n", type))

  desc.file <- paste0(path, ".desc")
  if(file.exists(desc.file)) {
    warning(desc.file, " already exists, won't erase")
    return(invisible(NULL))
  }
  cat(d, file = desc.file)
}