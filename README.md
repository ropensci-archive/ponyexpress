
[![Coverage Status](https://img.shields.io/codecov/c/github/ropenscilabs/notifier/master.svg)](https://codecov.io/github/ropenscilabs/notifier?branch=master)

ponyexpress 🐴
=============

This package builds on the `gmailr` package and code from Jenny Bryan to automate sendining Gmail from R with data from a spreadsheet (local csv, Excel sheet, or a Google sheet). With nothing more than a list of names and email addresses, you can send templated emails (grades, conference acceptances etc)

Functionality
-------------

-   `parcel_create(df, sender_name, sender_email, subject, template)` - Creates a template of the messages that need to be sent.
-   `parcel_preview()` - will preview the emails
-   `parcel_send()` - Send the emails

![](http://rs181.pbsrc.com/albums/x148/brandi47_2007/4942733.gif~c200)

Example
-------

**1. Read in data frame**

``` r
 df <- data.frame(
    name = c("Lucy", "Karthik"),
    email = c("ld.mcgowan@vanderbilt.edu", "kram@berkeley.edu")
  )
  df
```

    ##      name                     email
    ## 1    Lucy ld.mcgowan@vanderbilt.edu
    ## 2 Karthik         kram@berkeley.edu

**2. Template up**

``` r
library(ponyexpress)
 emplate <- "Dear {name},

   This is a friendly email from me.

  XO,
   Lucy"

 # Or write a rich template!

rich_template <- "Dear {name},

   This is a friendly email from me.
  \\<img src='http://bukk.it/wut.jpg'>
   XO,
   Lucy"
```

**3. Parcel & Preview**

``` r
  parcel <- parcel_create(df,
              sender_name = "Lucy",
              sender_email = "lucydagostino@gmail.com",
              subject = "Happy email!",
              template = rich_template)

 parcel_preview(parcel)            
```

**4. Send**

``` r
parcel_send(parcel)
```

![](https://i.imgur.com/Ij60FhR.gif)
