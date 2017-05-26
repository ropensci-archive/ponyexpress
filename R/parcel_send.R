#'  Sends email from notifier object
#'
#' @param secret path to secret.json file
#' @param edat tibble outputted from note_create
#' @param type Type of email. Either text or html.
#' @param sent Path for sent emails to be saved. You will need this later as a log of sent emails.
#'
#'@importFrom gmailr send_message
#'@importFrom purrr map safely
#' @export
#'
#' @examples
#' # First let's generate a sample output from note_create
#'
#' sample_email <-
#' data.frame(To = c("N. Bluth <lucille.bluth@gmail.com>", "G.O.B. <gob@imoscardotcom.com>"),
#'From = c("Karthik Ram <karthik.ram@gmail.com>"),
#'Subject = "This is the subject",
#' Body = "This is the message")
#' # Now send emails with
#' \dontrun{parcel_send(sample_email, secret)}
parcel_send <-
  function(edat,
           type = "text",
           secret = NULL,
           sent = "sent-emails.rds") {

    subject <- NULL

  if(!is.null(secret)) {
    gmailr::use_secret_file(secret)
  }
    mime2 <- function(To, From, Subject, body) {
    z <- gmailr::mime(to = To, from = From, subject = Subject)
    body <- gsub("\n", "<br>", body)
    gmailr::html_body(z, body = body)
    }
    emails <- purrr::pmap(edat, mime2)
    safe_send_message <- purrr::safely(gmailr::send_message)
    sent_mail <- purrr::map(emails, safe_send_message)
    error_list <- gmail_errors(sent_mail)
    saveRDS(sent_mail,paste(gsub("\\s+", "_", subject), sent , sep = "_"))
  }

# @noRd
gmail_errors <- function(x) {
# Soon we will catch and processs errrors
NULL
}
