## ---- addition ----

#' @rdname Arithmetic
setMethod("+", c(e1 = "mvector", e2 = "mvectorOrNumeric"), 
  function(e1, e2) {
    a <- mvector(e1@datatype, max(e1@length, length(e2)))
    copy_values_mm(a, e1)
    inplace.sum(a, e2)
    a
  }
)

#' @rdname Arithmetic
setMethod("+", c(e1 = "numeric", e2 = "mvector"),
  function(e1, e2) {
    a <- mvector(e2@datatype, max(length(e1), e2@length))
    copy_values(a, e1)
    inplace.sum(a, e2)
    a
  }
)

## ---- substraction  ----

#' @rdname Arithmetic
setMethod("-", c(e1 = "mvector", e2 = "mvectorOrNumeric"), 
  function(e1, e2) {
    a <- mvector(e1@datatype, max(e1@length, length(e2)))
    copy_values_mm(a, e1)
    inplace.minus(a, e2)
    a
  }
)

#' @rdname Arithmetic
setMethod("-", c(e1 = "numeric", e2 = "mvector"), 
  function(e1, e2) {
    a <- mvector(e2@datatype, max(length(e1), e2@length))
    copy_values(a, e1)
    inplace.minus(a, e2)
    a
  }
)

## ---- unary minus ----

#' @rdname Arithmetic
setMethod("-", c(e1 = "mvector", e2 = "missing"), 
  function(e1, e2) {
    a <- mvector(e1@datatype, e1@length)
    copy_values_mm(a, e1)
    inplace.opposite(a)
    a
  }
)

## ---- multiplication ----

#' @rdname Arithmetic
setMethod("*", c(e1 = "mvector", e2 = "mvectorOrNumeric"), 
  function(e1, e2) {
    a <- mvector(e1@datatype, max(e1@length, length(e2)))
    copy_values_mm(a, e1)
    inplace.prod(a, e2)
    a
  }
)

#' @rdname Arithmetic
setMethod("*", c(e1 = "numeric", e2 = "mvector"), 
  function(e1, e2) {
    a <- mvector(e2@datatype, max(length(e1), e2@length))
    copy_values(a, e1)
    inplace.prod(a, e2)
    a
  }
)

## ---- division ----

#' @rdname Arithmetic
setMethod("/", c(e1 = "mvector", e2 = "mvectorOrNumeric"), 
  function(e1, e2) {
    a <- mvector(e1@datatype, max(e1@length, length(e2)))
    copy_values_mm(a, e1)
    inplace.div(a, e2)
    a
  }
)

#' @rdname Arithmetic
setMethod("/", c(e1 = "numeric", e2 = "mvector"), 
  function(e1, e2) {
    a <- mvector(e2@datatype, max(length(e1), e2@length))
    copy_values(a, e1)
    inplace.div(a, e2)
    a
  }
)


