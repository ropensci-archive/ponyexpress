#' Create a note to email
#'
#' @param df data frame, information to be fed to the template (required)
#' @param sender_name character, the sender's name (required)
#' @param sender_email character, the sender's email (required)
#' @param subject character, the email's subject
#' @param bcc character, email address to bcc
#' @param template character, template for email, using glue syntax (see example)
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
#' note_create(df,
#'             sender_name = "Lucy",
#'             sender_email = "lucydagostino@gmail.com",
#'             subject = "Happy email!",
#'             template = template)
#'
#' @export
note_create <- function(df,
                        sender_name = NULL,
                        sender_email = NULL,
                        subject = NULL,
                        bcc = NULL,
                        template = NULL) {
  if (is.null(df) || is.null(sender_name) || is.null(sender_email) || is.null(template)) {
    stop("You must supply a value for: df, sender_name, sender_email, and template")
  }
  email <- df
  email$To <- glue::glue_data(df,"{name} <{email}>")
  email$Bcc <- bcc
  email$From <- glue::glue("{sender_name} <{sender_email}>")
  email$Subject <- subject
  email$body <- glue::glue_data(df, template)
  email[, names(email) %in% c("To", "Bcc", "From", "Subject", "body")]
}

