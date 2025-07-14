#include "MMatrix_methods.h"
#include <stdexcept> // for std::runtime_error
#include <Rcpp.h>

// [[Rcpp::export]]
SEXP link_mmatrix(std::string datatype, std::string file, size_t nrow, size_t ncol) {
    if (datatype == "float") {
        //std::cout << "float\n";
        Rcpp::XPtr<MMatrix<float>> MMatrix_ptr(new MMatrix<float>(file, nrow, ncol));
        return MMatrix_ptr;
    } else if (datatype == "double") {
        //std::cout << "double\n";
        Rcpp::XPtr<MMatrix<double>> MMatrix_ptr(new MMatrix<double>(file, nrow, ncol));
        return MMatrix_ptr;
    } else if (datatype == "int") {
        //std::cout << "int\n";
        Rcpp::XPtr<MMatrix<int>> MMatrix_ptr(new MMatrix<int>(file, nrow, ncol));
        return MMatrix_ptr;
    } else {
        throw std::runtime_error("Type of mmatrix (" + datatype + ") is unimplemented");
    }
}
