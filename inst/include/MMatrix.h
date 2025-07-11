#ifndef MMATRIX_H
#define MMATRIX_H

#include <fstream>
#include <iostream>
#include <string>
#include <system_error>
#include <vector>

#include "mio.hpp"

/*
 The goal of this class is to add the possibility for big matrices
 to become a memory mapped file using mio library 
 IT IS COLUMN MAJOR !
 */
template <typename T>
class MMatrix
{
public:
    // Constructor opening the file containing the matrix
    // if path exists else creating one.
    MMatrix(std::string path, size_t nrow, size_t ncol, bool verbose = false);
    // Constructor for a multidimensional matrix / R-style array
    MMatrix(std::string path, std::vector<size_t> dims, bool verbose = false);
    // Destructor flushing changes to disk before unmapping
    ~MMatrix();

    void FileHandler(std::string path, size_t matrix_size, bool verbose);

    size_t nrow() const;
    size_t ncol() const;
    std::string path() const;
    std::vector<size_t> dim() const;
    T *data() const;
    bool verbose() const;

    // IN BASE 0 :
    T &operator[](size_t ind);
    const T &operator[](size_t ind) const;
    T &operator()(size_t i, size_t j);
    const T &operator()(size_t i, size_t j) const;
    T &at(size_t ind) const;
    T &at(size_t i, size_t j) const;
    template <typename U>
    std::vector<U> sum() const;


protected:
    // Number of columns of the matrix, (base 1).
    // hardcoded to simplify the "matrix" use
    // but equivalent to dim[1]
    size_t ncol_;
    // Number of rows of the matrix (base 1).
    // hardcoded to simplify the "matrix" use
    // but equivalent to dim[0]
    size_t nrow_;
    // product of all dimensions 
    // (not mapped size as this also needs sizeof(datatype))
    size_t size_;
    // A vector containing all the dimension sizes
    // to mimic an R-style array
    // TO THINK : should dim_ be a template ? 
    std::vector<size_t> dim_;
    // (Relative ?) path of the file containing the matrix
    std::string path_;
    // Mio object handling the matrix.
    mio::mmap_sink matrix_file_;
    // type T pointer to the first byte of data in matrix_file_
    T *data_ptr_;
    // Boolean used to silence the class 
    //(useful when doing multithreading for example)
    bool verbose_;
};

#endif // MMATRIX_H
