#'  Sends email from notifier object
#'
#' @param secret path to secret.json file
#' @param edat tibble outputted from note_create
#' @param type Type of email. Either text or html.
#' @param errors Path for file to record error messages
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
#' note_send(sample_email, secret)
parcel_send <-
  function(edat,
           type = "text",
           secret,
           errors = "errors.csv",
           sent = "sent-emails.rds") {
    emails <- NULL
    subject <- NULL

    if(type == "text") {
        names(edat)[which(names(edat) == "Body")] = "text_body"
    }
    if(type == "html") {
        names(edat)[which(names(edat) == "Body")] = "html_body"
    }

    gmailr::use_secret_file(secret)
    safe_send_message <- purrr::safely(send_message)
    sent_mail <- purrr::map(emails, safe_send_message)

    saveRDS(sent_mail,
            paste(gsub("\\s+", "_", subject), "sent-emails.rds", sep = "_"))
  }
