# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

MMatrixAccess <- function(pM, datatype, L) {
    .Call(`_MarsuMatrix_MMatrixAccess`, pM, datatype, L)
}

MMatrixToNumericMatrix <- function(pM, datatype) {
    .Call(`_MarsuMatrix_MMatrixToNumericMatrix`, pM, datatype)
}

isnullptr <- function(pointer) {
    .Call(`_MarsuMatrix_isnullptr`, pointer)
}

array_access <- function(A, I) {
    .Call(`_MarsuMatrix_array_access`, A, I)
}

array_extract <- function(A, L) {
    .Call(`_MarsuMatrix_array_extract`, A, L)
}

restore_mmatrix_ <- function(datatype, file, nrow, ncol) {
    .Call(`_MarsuMatrix_restore_mmatrix_`, datatype, file, nrow, ncol)
}

