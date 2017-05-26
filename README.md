
ponyexpress
===========

Package sends email notifications from a sheet (local csv, Excel, or Googlesheet) that contains, at the very least a name and email a ddress. A message can be formatted using nice templates using the `glue` package.

Functionality
-------------

-   `parcel_create(df, sender_name, sender_email, subject, template)` - Creates a template of the messages that need to be sent.
-   `parcel_preview()` - will preview the emails
-   `parcel_send()` - Send the emails

![](http://rs181.pbsrc.com/albums/x148/brandi47_2007/4942733.gif~c200)
