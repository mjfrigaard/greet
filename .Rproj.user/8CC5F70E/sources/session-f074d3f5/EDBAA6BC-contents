library(shiny)
library(magrittr)

ui <- fluidPage(
  textInput("name", "what is your name"),
  actionButton("greet", "Greet"),
  textOutput("greeting"),
  textOutput("first_letter")
)

server <- function(input, output, session) {
    
  output$greeting <- renderText({
    req(input$name)
    paste0("Hello ", input$name, "!")
  }) %>% 
    bindEvent({input$greet})
    
  first_letter <- reactive({
    req(input$name)
    tolower(stringr::str_extract(input$name, "^."))
  }) %>% 
    bindEvent({input$greet})
  
  output$first_letter <- renderText({
    paste0("The first letter in your is ", first_letter(), "!")
  })
  
}

shinyApp(ui, server)