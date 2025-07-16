// small test function
// sends back as an R object (NOT mmatrix)
// the data specified in List
#include "MMatrix_methods.h"
#include <iostream>
#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::NumericVector MMatrixAccess(SEXP pM, std::string datatype, Rcpp::List L) {
    // the default verbose true should 
    // prove that the c° is not called
    if (datatype == "float") { 
        Rcpp::XPtr<MMatrix<float>> instanc(pM);
        return Rcpp::wrap(instanc->at(L));
    }
    else if (datatype == "double") { 
        Rcpp::XPtr<MMatrix<double>> instanc(pM);
        return Rcpp::wrap(instanc->at(L));
    }
    else if (datatype == "int") {
        Rcpp::XPtr<MMatrix<int>> instanc(pM);
        return Rcpp::wrap(instanc->at(L));
    }
    else if (datatype == "int16_t") {
        Rcpp::XPtr<MMatrix<int16_t>> instanc(pM);
        return Rcpp::wrap(instanc->at(L));
    }
    else return Rcpp::wrap(-1);
}