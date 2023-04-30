library(shinytest2)

test_that("{shinytest2} recording: hello-barret", {
  app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
  app$set_inputs(name = "Barret")
  app$click("greet")
  app$expect_values()
})
