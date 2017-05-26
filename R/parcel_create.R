#' Create a parcel to email
#'
#' @param df data frame, information to be fed to the template (required)
#' @param sender_name character, the sender's name (required)
#' @param sender_email character, the sender's email (required)
#' @param subject character, the email's subject
#' @param bcc character, email address to bcc
#' @param template character, template for email, using glue syntax (see example)
#' @importFrom stringr str_match
#'
#' @return data frame with information to email
#'
#' @examples
#' df <- data.frame(
#' name = c("Lucy", "Karthik"),
#' email = c("example@email.com", "example@email.com")
#' )
#'
#' template <- "
#' Dear {name},
#'
#' This is a friendly email from me.
#'
#' XO,
#' Lucy"
#'
#' parcel_create(df,
#'             sender_name = "Lucy",
#'             sender_email = "lucydagostino@gmail.com",
#'             subject = "Happy email!",
#'             template = template)
#'
#' @export
parcel_create <- function(df,
                        sender_name = NULL,
                        sender_email = NULL,
                        subject = NULL,
                        bcc = NULL,
                        template = NULL) {
  emails <- NULL
  if (is.null(df) || is.null(sender_name) || is.null(sender_email) || is.null(template)) {
    stop("You must supply a value for: df, sender_name, sender_email, and template")
  }
  valid_emails <- length(stringr::str_match(df$email, "^[[:alnum:].-_]+@[[:alnum:].-]+$"))
  if(valid_emails != nrow(df)) {
    stop("Found some invalid email addresses")
  }
  email <- df
  email$To <- glue::glue_data(df,"{name} <{email}>")
  email$Bcc <- bcc
  email$From <- glue::glue("{sender_name} <{sender_email}>")
  email$Subject <- subject
  email$body <- glue::glue_data(df, template)
  email <- email[, names(email) %in% c("To", "Bcc", "From", "Subject", "body")]
  structure(email, class = c("parcel", "data.frame"))
}

