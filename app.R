library(shiny)
library(magrittr)

ui <- fluidPage(
  textInput("name", "what is your name"),
  actionButton("greet", "Greet"),
  textOutput("greeting"),
  textOutput("first_letter"),
  # penguins ----
  textOutput("penguins")
)

server <- function(input, output, session) {
  
  # authenticated_database_request ----
  authenticated_database_request <- isolate({
    reactive({
      data.frame(x = vector(
        mode = "integer",
        length = sample(
          x = c(320:340),
          size = 1,
          replace = TRUE
        )
      ))
    })
  }) %>%
    bindEvent({
      input$greet
    })

  # test_database_request ----
  test_database_request <- isolate({
    reactive({
      data.frame(x = vector(
        mode = "integer",
        length = 68L
      ))
    })
  }) %>%
    bindEvent({
      input$greet
    })


  output$greeting <- renderText({
    req(input$name)
    paste0("Hello ", input$name, "!")
  }) %>%
    bindEvent({
      input$greet
    })

  first_letter <- reactive({
    req(input$name)
    tolower(stringr::str_extract(input$name, "^."))
  }) %>%
    bindEvent({
      input$greet
    })

  # penguin_count ----
  penguin_count <- reactive({
    penguin_data <-
      if (getOption("shiny.testmode", FALSE)) {
        test_database_request()
      } else {
        authenticated_database_request()
      }
    nrow(penguin_data)
  }) %>%
    bindEvent({
      input$greet
    })

  output$first_letter <- renderText({
    paste0("The first letter in your name is ", first_letter(), "!")
  })

  output$penguins <- renderText({
    paste0("There are ", penguin_count(), " penguins coming for dinner")
  })

  # exportTestValues ----
  shiny::exportTestValues(
    first_letter =
      first_letter(),
    penguin_count =
      penguin_count()
  )
}

shinyApp(ui, server)
