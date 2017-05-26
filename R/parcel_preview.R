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
  body <- email$body[1]
  body <- gsub("\n", "<br>", body)
  x <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".html")
  sink(x)
  cat(body)
  sink()
  utils::browseURL(x)
}

