context("note_create")

test_that("note_create behaves", {
  df <- data.frame(
    name = c("Lucy", "Karthik"),
    email = c("example@email.com", "example@email.com")
  )

  template <- "Dear {name},

   This is a friendly email from me.

   XO,
   Lucy"

  note <- note_create(df,
              sender_name = "Lucy",
              sender_email = "lucydagostino@gmail.com",
              subject = "Happy email!",
              template = template)
  expect_is(note, "data.frame")
  expect_identical(names(note), c("To","From","Subject","body"))
})
