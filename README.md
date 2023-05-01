`greet` app for ‘Getting Started with {`shinytest2`}’
================

- <a href="#shinytest2-part-1"
  id="toc-shinytest2-part-1"><code>shinytest2</code> part 1</a>
  - <a href="#the-application" id="toc-the-application">The application</a>
  - <a href="#record-test" id="toc-record-test">Record test</a>
  - <a href="#test" id="toc-test">Test</a>
  - <a href="#debugging-in-console" id="toc-debugging-in-console">Debugging
    in console</a>
- <a href="#shinytest2-part-2"
  id="toc-shinytest2-part-2"><code>shinytest2</code> part 2</a>
  - <a href="#exporting-values" id="toc-exporting-values">Exporting
    values</a>
- <a href="#shinytest2-part-3"
  id="toc-shinytest2-part-3"><code>shinytest2</code> part 3</a>
  - <a href="#test-with-shinytestmode" id="toc-test-with-shinytestmode">Test
    with <code>shiny.testmode</code></a>
- <a href="#final-test-shinytest2r" id="toc-final-test-shinytest2r">Final
  <code>test-shinytest2.R</code></a>
- <a href="#final-appr" id="toc-final-appr">Final <code>app.R</code></a>

# `shinytest2` [part 1](https://www.youtube.com/watch?v=Gucwz865aqQ)

**Example + basics**

<!-- [HackMD](https://hackmd.io/@mfrigaard/Syag4ij72) -->

1.  Install Chromium via
    [homebrew](https://formulae.brew.sh/cask/chromium) and dev version
    of `chromote`

``` bash
==> Downloading https://download-chromium.appspot.com/dl/Mac?type=snapshots
==> Downloading from https://commondatastorage.googleapis.com/chromium-browser-s
######################################################################### 100.0%
Warning: No checksum defined for cask 'chromium', skipping verification.
==> Installing Cask chromium
==> Moving App 'Chromium.app' to '/Applications/Chromium.app'
==> Linking Binary 'chromium.wrapper.sh' to '/usr/local/bin/chromium'
🍺  chromium was successfully installed!
```

``` r
remotes::install_github("rstudio/chromote")
library(chromote)
```

2.  Located Chromium

``` r
chromote::find_chrome()
# [1] "/Applications/Chromium.app/Contents/MacOS/Chromium"
```

3.  Created new session

``` r
Sys.setenv(CHROMOTE_CHROME = "/Applications/Chromium.app/Contents/MacOS/Chromium")
b <- ChromoteSession$new()
b$view()
```

## The application

From [this example](https://www.youtube.com/watch?v=Gucwz865aqQ)

``` r
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
    paste0("The first letter in your name is ", first_letter(), "!")
  })
  
}

shinyApp(ui, server)
```

## Record test

``` r
shinytest2::record_test()
```

1.  Enter a name and click “Greet”

2.  Enter name for test (i.e., `hello-barret`)

3.  Click **Expect Shiny values**

4.  Save and exit

## Test

1.  The following folders/files are created:

<!-- -->

    ├── app.R
    ├── greet.Rproj
    └── tests
        ├── testthat
        │   ├── _snaps
        │   │   └── shinytest2
        │   │       ├── hello-barret-001.json
        │   │       └── hello-barret-001_.png
        │   ├── setup-shinytest2.R
        │   └── test-shinytest2.R
        └── testthat.R

    5 directories, 7 files

2.  Contents of `test-shinytest2.R`:

``` r
library(shinytest2)

test_that("{shinytest2} recording: hello-barret", {
  app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
  app$set_inputs(name = "Barret")
  app$click("greet")
  app$expect_values()
})
```

## Debugging in console

Create `app` with `AppDriver$new()` in the console

``` r
app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
```

``` r
app$view()
```

*Opens Chromium with app*

``` r
app$set_inputs(name = "Barret")
```

*Sets value in `input$name`*

``` r
app$click("greet")
```

*Runs `actionButton(input$click)`*

``` r
app$get_values()
```

    #>> $input
    #>> $input$greet
    #>> [1] 2
    #>> attr(,"class")
    #>> [1] "shinyActionButtonValue" "integer"               

    #>> $input$name
    #>> [1] "Barret"


    #>> $output
    #>> $output$first_letter
    #>> [1] "The first letter in your is b!"

    #>> $output$greeting
    #>> [1] "Hello Barret!"


    #>> $export
    #>> named list()

``` r
app$get_value(output = "greeting")
```

    #>> [1] "Hello Barret!"

# `shinytest2` [part 2](https://www.youtube.com/watch?v=7KLv6HdIxvU)

**Exporting values**

1.  Create new test in `test-shinytest2.R`

- This doesn’t require `height = 483, width = 862`, but it makes the
  size eaiser to deal with.

  - Add the `first_letter_phrase` as the output from
    `app$get_value(output = "first_letter")`

  - Create test using the `first_letter_phrase` and the expected output
    in `output$first_letter`

  ``` r
  testthat::test_that(desc = "export test values", {
    app <- AppDriver$new(name = "export values")
    app$set_inputs(name = "Barret")
    app$click("greet")
    first_letter_phrase <- app$get_value(output = "first_letter")
    testthat::expect_equal(
      object = first_letter_phrase,
      expected = "The first letter in your name is b!")
  })
  ```

### Exporting values

To export values, we can use the `shiny::exportTestValues()` in the
`server`:

``` r
shiny::exportTestValues(
  first_letter =
    first_letter()
  )
```

- Then access this in the `AppDriver`:

  - Reset the values

  ``` r
  app$stop()
  app <- AppDriver$new(name = "export values")
  app$view()
  app$set_inputs(name = "Barret")
  app$click("greet")
  ```

  - View exported values

  ``` r
  app$get_values()
  ```

  - Test exported values

  ``` r
  test_that(desc = "export test values", code = {
    app <- AppDriver$new(name = "export values")
    app$set_inputs(name = "Barret")
    app$click("greet")

    # extract value from output$first_letter
    first_letter_phrase <- app$get_value(output = "first_letter")

    expect_equal(object = first_letter_phrase,
      expected = "The first letter in your name is b!")

    expect_equal(
      object = app$get_value(export = "first_letter"),
      expected = "b"
    )

  })
  ```

# `shinytest2` [part 3](https://www.youtube.com/watch?v=xDxa_mDwN04)

**Using `shiny.testmode`**

1.  Update the `ui` with a `textOutput()`

``` r
textOutput("penguins")
```

2.  Update the server with a simulated
    `authenticated_database_request()`

``` r
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
    bindEvent({input$greet})
```

- This is used in `penguin_count()`

  ``` r
   penguin_count <- reactive({
      penguin_data <- authenticated_database_request()
      nrow(penguin_data)})  %>%
      bindEvent({input$greet})
  ```

  - The output is below:

  ``` r
  output$penguins <- renderText({
    paste0("There are ", penguin_count(), " penguins coming for dinner")
  })
  ```

When we use `shiny.testmode`, we add the simulated
`test_database_request()` to the control flow for `penguins_count()`:

- The `test_database_request()`

  ``` r
   test_database_request <- isolate({
      reactive({
        data.frame(x = vector(
          mode = "integer",
          length = 68L
        ))
      })
    }) %>%
      bindEvent({input$greet})
  ```

  - The updated server with `penguins_count()`

  ``` r
  penguin_count <- reactive({
    penguin_data <-
    if (getOption("shiny.testmode", FALSE)) {
      test_database_request()
    } else {
      authenticated_database_request()
    }
    nrow(penguin_data)
  })  %>%
    bindEvent({input$greet})
  ```

  - These values can also be exported:

  ``` r
  shiny::exportTestValues(
      first_letter =
        first_letter(),
      penguin_count =
        penguin_count()
    )
  ```

### Test with `shiny.testmode`

After resetting the `AppDriver`, we can test for the
`test_database_request()` using the following in the console:

``` r
app <- AppDriver$new(name = "export values", height = 483, width = 862) 
app$set_inputs(name = "Barret")
app$click("greet")
app$get_value(export = "penguin_count")
#>> [1] 68
```

- And add the following to `test-shinytest2.R`:

  ``` r
    testthat::expect_equal(
      object = app$get_value(export = "penguin_count"),
      expected = 68
    )
  ```

# Final `test-shinytest2.R`

``` r
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
```

# Final `app.R`

``` r
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
```
