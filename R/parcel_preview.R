#' Parcel Preview
#'
#' Preview the parcel in a new browser window.
#'
#' @param email object of class `ponyexpress`, can be obtained from the
#'   `parcel_create()` function.
#'
#' @export
parcel_preview <- function(email = NULL) {
  if (!inherits(email, "parcel")){
    stop("`email` must be of class `parcel` (see `parcel_create()`)")
  }
  body <- email[[1]]$body
  x <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".html")
  file_con <- file(x)
  writeLines(body, file_con)
  close(file_con)
  utils::browseURL(x)
}

