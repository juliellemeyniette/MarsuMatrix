require(MarsuMatrix)

A <- mmatrix("float", 10, 20)
a <- as.matrix(A)
stopifnot(typeof(a) == "double")

A[1,1] <- 12
A[3,] <- 1.34
as.matrix(A)

T <- matrix(NA_real_, 4, 3)
MarsuMatrix:::extract_mmatrix_to_R(A@ptr, "float", 0:3, 0:2, T)

A[1:4, 1:3]

B <- mmatrix("int", 10, 20)
b <- as.matrix(B)
stopifnot(typeof(b) == "integer")

B[1,1] <- 12
B[3,] <- 1.34
as.matrix(B)

V <- mvector("double", 10)
v <- as.vector(V)
V[1:4] <- 2
as.vector(V)
