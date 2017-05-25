#'  Sends email from notifier object
#'
#' @param secret path to secret.json file
#' @param edat tibble outputted from note_create
#' @param errors Path for file to record error messages
#' @param sent Path for sent emails to be saved. You will need this later as a log of sent emails. Note that successfully sent emails will also be in your Gmail sent folder.
#'
#'@importFrom gmailr send_message
#'@importFrom purrr map safely
#' @export
#'
#' @examples
#' First let's generate a sample output from note_create
#'
#' sample_email <- tibble(To = c("Lucille Bluth <lucille.bluth@gmail.com>", "G.O.B. <gob@imnotoscar.com>"),
#'From = c("Karthik Ram <karthik.ram@gmail.com>"),
#'Subject = "This is the subject",
#' Body = "This is the message")
#' # Now send emails with
#' note_send(sample_email, secret)
note_send <-
  function(edat,
           type = "text",
           secret,
           errors = "errors.csv",
           sent = "sent-emails.rds") {
    browser()

    t_mme <- function(x) { browser(); gmailr::mime(From = x$From, to = x$To, text_body = x$Body) }
    h_mme <-  function(x) { gmailr::mime(From = x$From, to = x$To, html_body = x$Body) }
    if(type == "text") { emails <- pmap(edat, t_mme) }
    if(type == "text") emails <- pmap(edat, h_mme)
    gmailr::use_secret_file(secret)
    safe_send_message <- purrr::safely(send_message)
    sent_mail <- purrr::map(emails, safe_send_message)


    saveRDS(sent_mail,
            paste(gsub("\\s+", "_", subject), "sent-emails.rds", sep = "_"))

    # errors <- sent_mail %>%
    #   transpose() %>%
    #   .$error %>%
    #   map_lgl(Negate(is.null))
    # sent_mail[errors]

    saveRDS(errors,
            paste(gsub("\\s+", "_", subject), "errors.rds", sep = "_"))
  }
