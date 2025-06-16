#' Extract an object from .RData
#'
#' @param file .RData file
#' @param object object name
#' @return the object
#' @references https://stackoverflow.com/questions/65964064/programmatically-extract-an-object-from-collection-of-rdata-files
#' @export

extractorRData = function(file, object) {
  #' Function for extracting an object from a .RData file created by R's save() command
  #' Inputs: RData file, object name
  E <- new.env()
  load(file=file, envir=E)

  return(get(object, envir=E, inherits=F))
}
