## Matrix inversion is usually a costly computation and their may be some benefit
## to caching the inverse of a matrix rather than compute it repeatedly.

## The following two functions creates a object that stores a numeric
## matrix and cache's its inverse.

## This function creates a special "matrix" object that can cache its inverse.
# 1. set the value of the vector
# 2. get the value of the vector
# 3. set the value of the mean
# 4. get the value of the mean

## Complete Example: 
#
# > x <- matrix(1:4,nrow = 2, ncol = 2)
# > matrix <- matrix(1:4,nrow = 2, ncol = 2)
# > cache_matrix <- makeCacheMatrix(matrix)
# > cacheSolve(cache_matrix)
#     [,1] [,2]
# [1,] -2  1.5
# [2,]  1 -0.5
# > cacheSolve(cache_matrix)
# getting cached data
#       [,1] [,2]
# [1,]   -2  1.5
# [2,]    1 -0.5

makeCacheMatrix <- function(x = matrix()) {
  
  # initialize the variable matrix_inv to NULL 
  matrix_inv <- NULL
  
  # set the value of the matrix
  set <- function(y) {
    # assign y value to x object from another enviroment
    x <<- y
    # matrix_inv has changed, reassign to NULL
    matrix_inv <<- NULL 
  }
  
  # get the value of the matrix
  get <- function() x
  
  # set  the inverse of the matrix
  set_matrix_inverse <- function(inverse) matrix_inv <<- inverse
  
  # get the inverse of the matrix
  get_matrix_inverse <- function() matrix_inv
  
  # return a list containing all functions defined above
  list(set = set, get = get,
       set_matrix_inverse = set_matrix_inverse,
       get_matrix_inverse = get_matrix_inverse)
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated 
## (and the matrix has not changed), then the cachesolve retrieves 
## the inverse from the cache.


cacheSolve <- function(x, ...) { # 'x': 'makeCacheMatrix' object
  
  # get inverse matrix
  matrix_inv <- x$get_matrix_inverse()
  
  # in case the inverse matrix exists -> check if has been cached
  # if exists -> return the cached inverse matrix
  if(!is.null(matrix_inv)) {
    message("getting cached data")
    return(matrix_inv)
  }
  
  # in case the inverse matrix do not exist -> get matrix
  data <- x$get()
  
  # calculate the inverse of the given matrix
  matrix_inv <- solve(data, ...)
  
  # cache the inverse matrix
  x$set_matrix_inverse(matrix_inv)
  
  # return the inverse matrix
  matrix_inv
}