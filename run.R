# remotes::install_github("rstudio/chromote")
library(chromote)
chromote::find_chrome()
Sys.setenv(CHROMOTE_CHROME = "/Applications/Chromium.app/Contents/MacOS/Chromium")
# verify
chromote::find_chrome()
b <- ChromoteSession$new()
b$view()


# PART 1 ------------------------------------------------------------------
library(shinytest2)
# record_test()
# in console 
# app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
# app$view()
# app$set_inputs(name = "Barret")
# app$click("greet")
# app$get_values()
# app$get_value(output = "greeting")

# PART 2 ------------------------------------------------------------------
# https://www.youtube.com/watch?v=7KLv6HdIxvU
# 
# ## export test values ----
# 
# test_that(desc = "export test values", {
#   app <- AppDriver$new(name = "export values", height = 483, width = 862)
#   # without height/width
#   app <- AppDriver$new(name = "export values")
#   app$set_inputs(name = "Barret")
#   app$click("greet")
#   first_letter_phrase <- app$get_value(output = "first_letter")
#   expect_equal(object = first_letter_phrase, 
#     expected = "The first letter in your name is b!")
# })
# 
# Add exportTestValues() to app.R ----
# 
# shiny::exportTestValues(
#   first_letter = 
#     first_letter()
#   )
#
### Reset AppDriver ----
# 
# app$stop()
# app <- AppDriver$new(name = "export values")
# app$set_inputs(name = "Barret")
# app$click("greet")
# 
## view exported values ----
# app$get_values()
# 
## test exported values ----
#
# test_that(desc = "export test values", code = {
#   # use default height/width
#   app <- AppDriver$new(name = "export values") 
#   app$set_inputs(name = "Barret")
#   app$click("greet")
#   
#   # extract value from output$first_letter
#   first_letter_phrase <- app$get_value(output = "first_letter")
#   
#   expect_equal(object = first_letter_phrase, 
#     expected = "The first letter in your name is b!")
#   
#   expect_equal(
#     object = app$get_value(export = "first_letter"),
#     expected = "b"
#   )
#   
# })

# PART 3 ------------------------------------------------------------------
# Using shiny.testmode
# https://youtu.be/xDxa_mDwN04
# 
## update ui with penguins ----
# textOutput("penguins")
# 
# update server with simulated authenticated_database_request() ----
# authenticated_database_request <- isolate({
#     reactive({
#       data.frame(x = vector(
#         mode = "integer",
#         length = sample(
#           x = c(320:340),
#           size = 1,
#           replace = TRUE
#         )
#       ))
#     })
#   }) %>% 
#     bindEvent({input$greet})
#     
# the original penguin_count()
#  penguin_count <- reactive({
#     penguin_data <- authenticated_database_request()
#     nrow(penguin_data)})  %>% 
#     bindEvent({input$greet})
# 
# output for penguins text
# output$penguins <- renderText({
#   paste0("There are ", penguin_count(), " penguins coming for dinner")
# })
# update server with simulated test_database_request() ----
#  test_database_request <- isolate({
#     reactive({
#       data.frame(x = vector(
#         mode = "integer",
#         length = 68L
#       ))
#     })
#   }) %>%
#     bindEvent({input$greet})
# the updated penguins_count()
# penguin_count <- reactive({
#   penguin_data <- 
#   if (getOption("shiny.testmode", FALSE)) {
#     test_database_request()
#   } else {
#     authenticated_database_request()
#   }
#   nrow(penguin_data)
# })  %>% 
#   bindEvent({input$greet})
