library(plumber)
library(jsonlite)

#* @apiTitle Email

#* Send out an email message
#* @param req request body
#* @post /email
function(req) {
  
  ## get the message body
  body <- jsonlite::fromJSON(req$postBody)
  
  email <- body$email
  name <- body$name
  subject <- body$subject
  to <- body$to
  message <- body$message
  
  ## need a recipient to send an email
  if (!is.null(to)) {
    
    if (is.null(message)) {
      message <- ""
    } else {
      message <- gsub("\\r", "", message)
    }
    
    ## add sender's name
    if (!is.null(name)) {
      message <- paste0(message, "\n\nFrom: ", name)
    }
    
    ## build up email string
    email_string <- "echo -e "
    email_string <- paste0(email_string, "\"", message, "\" | mail ")
    
    if (!is.null(subject)) {
      email_string <- paste0(email_string, "-s \"", subject, "\" ")
    } else {
      email_string <- paste0(email_string, "-s \"no subject\" ")
    }
    
    if (!is.null(email)) {
      email_string <- paste0(email_string, "-S from=", email, " ")
    }
    
    email_string <- paste0(email_string, to)
    
    system(email_string)
    return(email_string)
  }
}
