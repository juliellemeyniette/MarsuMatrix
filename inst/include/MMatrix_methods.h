#ifndef MMATRIX_METHOD_H
#define MMATRIX_METHOD_H

#include <cassert>
#include <fstream> // for ofstream, loading the file
#include <iostream> // for std::cout
#include <stdexcept>
#include <system_error> // for std::error_code

#include "mio.hpp"
#include "MMatrix.h"


// Constructor opening the file containing the matrix if path exists, else
// creating one.
template <typename T>
MMatrix<T>::MMatrix(std::string path, size_t nrow, size_t ncol, bool verbose)
    : ncol_(ncol), nrow_(nrow), path_(path), verbose_(verbose)
{
    size_ = ncol * nrow;
    if (!size_) throw std::invalid_argument("Ncol or Nrow is equal to 0, cannot map an empty file !");
    size_t matrix_size = size_ * sizeof(T);


  /* FIRST : check if file exists, if it does not, create one of the good size*/
    const char * path_c = path.c_str();
    FILE *check = fopen(path_c, "rb"); // open en readonly 

    if (!check)
    {
        if (verbose_ == true) std::cout << "The file " << path << " does not exist, creating one ...  ";
        std::ofstream newfile(path, std::ios::binary); // to load with \0
        if (!newfile || !newfile.is_open())
        {
            throw std::runtime_error("Failed to open the file;");
        }
        /* Writing a null byte to the end of the file
        after using seekp to the before last byte will
        ensure we have a non-empty file of the desired size
        without loading it into memory */
        newfile.seekp(matrix_size - 1);
        newfile.put('\0');
        // mio will reopen it
        newfile.close();
        if (verbose_ == true) std::cout << "Done !" << std::endl;
    }
    else {
        if (verbose_ == true) {
            std::cout << "Using and potentially overwritting already existing " << path << std::endl;
        }
        fclose(check);

        // from https://stackoverflow.com/questions/238603/how-can-i-get-a-files-size-in-c
        struct stat buf;
        if (stat(path_c, &buf) != 0) {
            throw std::runtime_error("Failed to analyse file: " + path);
        }
        off_t file_size = buf.st_size;
        if (file_size != matrix_size) {
            if (verbose_) {
                std::cout << "Resizing file from " << file_size << " to " << matrix_size << " bytes." << std::endl;
            }

            if (matrix_size > file_size) {
                std::fstream resize_file(path, std::ios::binary | std::ios::in | std::ios::out );
                if (!resize_file.is_open()) {
                    throw std::runtime_error("Failed to reopen file for resizing.");
                }
                //same as creating one with good size
                resize_file.seekp(matrix_size - 1);
                resize_file.put('\0');
                resize_file.close();
            } else {
                // TRIM IT DOWN !!
                if (truncate(path_c, matrix_size) != 0) {
                    throw std::runtime_error("Failed to truncate file: " + path);
                }
            }
        }
    }

    std::error_code error;
    matrix_file_ = mio::make_mmap_sink(path, 0, mio::map_entire_file, error);
    
    if (error)
    {
        std::string errMsg = "Error code " + std::to_string(error.value())
            + ", Failed to map the file : " + error.message();
        throw std::runtime_error(errMsg);
    }

    if (matrix_file_.empty() || matrix_file_.data() == nullptr) {
        throw std::runtime_error("Memory mapping failed: no data mapped.");
    }

    data_ptr_ = reinterpret_cast<T *>(matrix_file_.data());
}

// Destructor flushing changes to disk before unmapping
template <typename T>
MMatrix<T>::~MMatrix()
{
    if (verbose_ == true) std::cout << "Unmapping mmatrix " << path_ << std::endl;
    std::error_code error;
    if (matrix_file_.is_mapped())
    {
        matrix_file_.sync(error);
        if (error)
        {
            // here no exception not to disturb the unstacking
            std::cerr << "Failed to unsync the file " << path_ << ": " << error.message()
                      << '\n';
        }
        matrix_file_.unmap();
    }
}

// Getters :
template <typename T>
size_t MMatrix<T>::nrow() const
{
    return nrow_;
}
template <typename T>
size_t MMatrix<T>::ncol() const
{
    return ncol_;
}
template <typename T>
std::string MMatrix<T>::path() const
{
    return path_;
}
template <typename T>
T *MMatrix<T>::data() const
{
    return data_ptr_;
}

// Operator [] gives back the data at index, UNSAFE.
template <typename T>
T &MMatrix<T>::operator[](size_t ind)
{
    return data_ptr_[ind];
}
template <typename T>
const T &MMatrix<T>::operator[](size_t ind) const
{
    return data_ptr_[ind];
}

// Operator () gives back data at row i, col j
template <typename T>
T &MMatrix<T>::operator()(size_t i, size_t j)
{
    return data_ptr_[(j * nrow_) + i];
}
template <typename T>
const T &MMatrix<T>::operator()(size_t i, size_t j) const
{
    return data_ptr_[(j * nrow_) + i];
}
template <typename T>
bool MMatrix<T>::verbose() const
{
    return verbose_;
}

// Same as operators but safe, with bound checking.
// Can be used with one (like []) or two parameters.
template <typename T>
T &MMatrix<T>::at(size_t ind) const
{
    if (ind >= size_)
    {
        throw std::out_of_range("Index out of range");
    }
    return data_ptr_[ind];
}
template <typename T>
T &MMatrix<T>::at(size_t i, size_t j) const
{
    if (i > nrow_ || j > ncol_)
    {
        std::string errMsg = "Matrix indices out of range, only goes up to "
            + std::to_string(ncol_) + " columns and " + std::to_string(nrow_)
            + " rows";
        throw std::out_of_range(errMsg);
    }
    return data_ptr_[(j * nrow_) + i];
}

// UNSAFE, calling ()
template <typename T>
template <typename U>
std::vector<U> MMatrix<T>::sum() const
{
    std::vector<U> results(ncol_); // Allocates AND initialises w/ zero

    for (size_t i = 0; i < ncol_; ++i)
    {
        for (size_t j = 0; j < nrow_; ++j)
        {
            // Add the element in column i, row j.
            results[i] += static_cast<U>((*this)(j, i));
        }
    }
    return results;
}

// HELPER FUNCTIONS :

// get_type_name() is to get the template type by comparing it to known types
// was formally used to complete the descriptor file
template <typename T>
inline std::string get_type_name()
{
    if (std::is_same<T, int>::value)
    {
        return "integer"; // written in full cos need for descfile
    }
    else if (std::is_same<T, float>::value)
    {
        return "float";
    }
    else if (std::is_same<T, double>::value)
    {
        return "double";
    }
    else if (std::is_same<T, char>::value)
    {
        return "char";
    }
    else
    {
        return "unknown"; // to expand later ?
    }
}

#endif