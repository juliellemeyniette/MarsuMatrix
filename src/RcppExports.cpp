// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// MMatrixAccess
Rcpp::NumericVector MMatrixAccess(SEXP pM, std::string datatype, Rcpp::List L);
RcppExport SEXP _MarsuMatrix_MMatrixAccess(SEXP pMSEXP, SEXP datatypeSEXP, SEXP LSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type pM(pMSEXP);
    Rcpp::traits::input_parameter< std::string >::type datatype(datatypeSEXP);
    Rcpp::traits::input_parameter< Rcpp::List >::type L(LSEXP);
    rcpp_result_gen = Rcpp::wrap(MMatrixAccess(pM, datatype, L));
    return rcpp_result_gen;
END_RCPP
}
// MMatrixToNumericMatrix
Rcpp::NumericMatrix MMatrixToNumericMatrix(SEXP pM, std::string datatype);
RcppExport SEXP _MarsuMatrix_MMatrixToNumericMatrix(SEXP pMSEXP, SEXP datatypeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type pM(pMSEXP);
    Rcpp::traits::input_parameter< std::string >::type datatype(datatypeSEXP);
    rcpp_result_gen = Rcpp::wrap(MMatrixToNumericMatrix(pM, datatype));
    return rcpp_result_gen;
END_RCPP
}
// isnullptr
bool isnullptr(SEXP pointer);
RcppExport SEXP _MarsuMatrix_isnullptr(SEXP pointerSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type pointer(pointerSEXP);
    rcpp_result_gen = Rcpp::wrap(isnullptr(pointer));
    return rcpp_result_gen;
END_RCPP
}
// array_access
double array_access(NumericVector A, IntegerVector I);
RcppExport SEXP _MarsuMatrix_array_access(SEXP ASEXP, SEXP ISEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type A(ASEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type I(ISEXP);
    rcpp_result_gen = Rcpp::wrap(array_access(A, I));
    return rcpp_result_gen;
END_RCPP
}
// array_extract
NumericVector array_extract(NumericVector A, List L);
RcppExport SEXP _MarsuMatrix_array_extract(SEXP ASEXP, SEXP LSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type A(ASEXP);
    Rcpp::traits::input_parameter< List >::type L(LSEXP);
    rcpp_result_gen = Rcpp::wrap(array_extract(A, L));
    return rcpp_result_gen;
END_RCPP
}
// restore_mmatrix_
SEXP restore_mmatrix_(std::string datatype, std::string file, size_t nrow, size_t ncol);
RcppExport SEXP _MarsuMatrix_restore_mmatrix_(SEXP datatypeSEXP, SEXP fileSEXP, SEXP nrowSEXP, SEXP ncolSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type datatype(datatypeSEXP);
    Rcpp::traits::input_parameter< std::string >::type file(fileSEXP);
    Rcpp::traits::input_parameter< size_t >::type nrow(nrowSEXP);
    Rcpp::traits::input_parameter< size_t >::type ncol(ncolSEXP);
    rcpp_result_gen = Rcpp::wrap(restore_mmatrix_(datatype, file, nrow, ncol));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_MarsuMatrix_MMatrixAccess", (DL_FUNC) &_MarsuMatrix_MMatrixAccess, 3},
    {"_MarsuMatrix_MMatrixToNumericMatrix", (DL_FUNC) &_MarsuMatrix_MMatrixToNumericMatrix, 2},
    {"_MarsuMatrix_isnullptr", (DL_FUNC) &_MarsuMatrix_isnullptr, 1},
    {"_MarsuMatrix_array_access", (DL_FUNC) &_MarsuMatrix_array_access, 2},
    {"_MarsuMatrix_array_extract", (DL_FUNC) &_MarsuMatrix_array_extract, 2},
    {"_MarsuMatrix_restore_mmatrix_", (DL_FUNC) &_MarsuMatrix_restore_mmatrix_, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_MarsuMatrix(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
