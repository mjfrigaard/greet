library(testthat)
library(shinytest2)

# initial record_test() ----
# testthat::test_that("{shinytest2} recording: hello-barret", {
#   app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
#   app$set_inputs(name = "Barret")
#   app$click("greet")
#   app$expect_values()
# })

testthat::test_that(desc = "export test values", code = {
  
  app <- AppDriver$new(name = "export values", height = 483, width = 862) 
  app$set_inputs(name = "Barret")
  app$click("greet")
  
  first_letter_phrase <- app$get_value(output = "first_letter")
  
  testthat::expect_equal(object = first_letter_phrase, 
    expected = "The first letter in your name is b!")
  
  testthat::expect_equal(
    object = app$get_value(export = "first_letter"),
    expected = "b"
  )
  
  testthat::expect_equal(
    object = app$get_value(export = "penguin_count"),
    expected = 68
  )
  
})

