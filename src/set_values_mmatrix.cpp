#include "MMatrix_methods.h"
#include <iostream>
#include <cstdint> // for int16_t
#include <Rcpp.h>

// ici values est un R vector
// [[Rcpp::export]]
void set_values_mmatrix(SEXP pM, std::string datatype, Rcpp::IntegerVector I, Rcpp::IntegerVector J, SEXP values) {
  if (datatype == "float") { 
    Rcpp::XPtr<MMatrix<float>> instanc(pM);
    Rcpp::NumericVector val(values);
    instanc->set_values_matrix(I, J, val);
  } else if (datatype == "double") {
    Rcpp::XPtr<MMatrix<double>> instanc(pM);
    Rcpp::NumericVector val(values);
    instanc->set_values_matrix(I, J, val);
  } else if (datatype == "int") {
    Rcpp::XPtr<MMatrix<int>> instanc(pM);
    Rcpp::IntegerVector val(values);
    instanc->set_values_matrix(I, J, val);
  } else if (datatype == "int16_t") {
    Rcpp::XPtr<MMatrix<int16_t>> instanc(pM);
    Rcpp::IntegerVector val(values);
    instanc->set_values_matrix(I, J, val);
   }
  else {
    throw std::runtime_error("Unsupported datatype for now !");
  }
}

// ici values est un pointeur vers une mmatrix
// [[Rcpp::export]]
void set_values_mmatrix_mm(SEXP pM, std::string datatype, Rcpp::IntegerVector I, Rcpp::IntegerVector J, SEXP values, std::string valtype) {
  if (datatype == "float") { 
    Rcpp::XPtr<MMatrix<float>> instanc(pM);
    if(valtype == "float") {
      Rcpp::XPtr<MMatrix<float>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "double") {
      Rcpp::XPtr<MMatrix<double>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "int") {
      Rcpp::XPtr<MMatrix<int>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if (valtype == "int16_t") {
      Rcpp::XPtr<MMatrix<int16_t>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else {
    throw std::runtime_error("Unsupported datatype for values for now !");
    }
  } else if (datatype == "double") {
    Rcpp::XPtr<MMatrix<double>> instanc(pM);
    if(valtype == "float") {
      Rcpp::XPtr<MMatrix<float>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "double") {
      Rcpp::XPtr<MMatrix<double>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "int") {
      Rcpp::XPtr<MMatrix<int>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if (valtype == "int16_t") {
      Rcpp::XPtr<MMatrix<int16_t>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else {
    throw std::runtime_error("Unsupported datatype for values for now !");
    }
  } else if (datatype == "int") {
    Rcpp::XPtr<MMatrix<int>> instanc(pM);
    if(valtype == "float") {
      Rcpp::XPtr<MMatrix<float>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "double") {
      Rcpp::XPtr<MMatrix<double>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "int") {
      Rcpp::XPtr<MMatrix<int>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if (valtype == "int16_t") {
      Rcpp::XPtr<MMatrix<int16_t>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else {
    throw std::runtime_error("Unsupported datatype for values for now !");
    }
  } else if (datatype == "int16_t") {
    Rcpp::XPtr<MMatrix<int16_t>> instanc(pM);
    if(valtype == "float") {
      Rcpp::XPtr<MMatrix<float>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "double") {
      Rcpp::XPtr<MMatrix<double>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if(valtype == "int") {
      Rcpp::XPtr<MMatrix<int>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else if (valtype == "int16_t") {
      Rcpp::XPtr<MMatrix<int16_t>> val(values);
      instanc->set_values_matrix(I, J, *val);
    } else {
    throw std::runtime_error("Unsupported datatype for values for now !");
    }
  } else {
    throw std::runtime_error("Unsupported datatype for now !");
  }
}


