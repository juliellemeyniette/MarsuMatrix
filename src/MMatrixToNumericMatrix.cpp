#include "MMatrix_methods.h"
#include <iostream>
#include <Rcpp.h>

// I have to use SEXP as an argument because I don't 
// know which type MMatrix is templated into...
// This will be ugly but don't know how to do it better

// [[Rcpp::export]]
Rcpp::NumericMatrix MMatrixToNumericMatrix(SEXP pM, std::string datatype) {
  if (datatype == "float") { 
    // comment faire un check plus délicat sur la validité du ptr vers la MMatrix ?
    Rcpp::XPtr<MMatrix<float>> instanc(pM);
    unsigned int ncol = instanc->ncol();
    unsigned int nrow = instanc->nrow();
    Rcpp::NumericMatrix R(nrow, ncol);

    for(unsigned int i = 0; i < nrow; i++) {
      for (unsigned int j = 0; j < ncol; ++j) {
        R(i, j) = (*instanc)(i, j); // est-ce que besoin d'un cast ?
      }
    }
    return R;
  } else if (datatype == "double") {
    Rcpp::XPtr<MMatrix<double>> instanc(pM);
    unsigned int ncol = instanc->ncol();
    unsigned int nrow = instanc->nrow();
    Rcpp::NumericMatrix R(nrow, ncol);

    for(unsigned int i = 0; i < nrow; i++) {
      for (unsigned int j = 0; j < ncol; ++j) {
        R(i, j) = (*instanc)(i, j); // est-ce que besoin d'un cast ?
      }
    }
    return R;

  } else if (datatype == "int") {
    // TODO : find a way to return an IntegerMatrix would be cleaner !

    Rcpp::XPtr<MMatrix<int>> instanc(pM);
    unsigned int ncol = instanc->ncol();
    unsigned int nrow = instanc->nrow();
    Rcpp::NumericMatrix R(nrow, ncol);

    for(unsigned int i = 0; i < nrow; i++) {
      for (unsigned int j = 0; j < ncol; ++j) {
        R(i, j) = (*instanc)(i, j); // est-ce que besoin d'un cast ?
      }
    }
    return R;
  } else {
    throw std::runtime_error("Unsupported datatypes for now ! This mmatrix will not be translated.");
  }

}
