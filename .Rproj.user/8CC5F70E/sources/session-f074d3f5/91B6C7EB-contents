# Chromium <> shinytest2 issue

[HackMD](https://hackmd.io/@mfrigaard/Syag4ij72)

1. I installed Chromium via [homebrew](https://formulae.brew.sh/cask/chromium) and dev version of `chromote`

``` r
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

2. Located Chromium 

``` r
chromote::find_chrome()
[1] "/Applications/Chromium.app/Contents/MacOS/Chromium"
```

3. Created new session 

``` r
b <- ChromoteSession$new()
b$view()
```

Then I see the following: 

![](https://hackmd.io/_uploads/HJcMEis73.png)

Also—the same issue arises in `shinytest2` when using app driver in console: 

1. With the following app folder (from [this example](https://www.youtube.com/watch?v=Gucwz865aqQ)):

```
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
```

2. And the contents of `test-shinytest2.R` containing:

``` r
library(shinytest2)

test_that("{shinytest2} recording: hello-barret", {
  app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
  app$set_inputs(name = "Barret")
  app$click("greet")
  app$expect_values()
})
```

3. When I attempt to run the following in the console, 

```r
app <- AppDriver$new(name = "hello-barret", height = 483, width = 862)
app$view()
```

![](https://hackmd.io/_uploads/ByOQEso7n.png)

``` r
sessioninfo::session_info()
─ Session info ───────────────────────────────────────────────────────────────
 setting  value
 version  R version 4.2.3 (2023-03-15)
 os       macOS Ventura 13.3.1
 system   x86_64, darwin17.0
 ui       RStudio
 language (EN)
 collate  en_US.UTF-8
 ctype    en_US.UTF-8
 tz       America/Los_Angeles
 date     2023-04-30
 rstudio  2023.03.0+386 Cherry Blossom (desktop)
 pandoc   NA

─ Packages ──────────────────────────────────────────────────────────────────
 ! package     * version date (UTC) lib source
   backports     1.4.1   2021-12-13 [1] CRAN (R 4.2.0)
   brio          1.1.3   2021-11-30 [1] CRAN (R 4.2.0)
   callr         3.7.3   2022-11-02 [1] CRAN (R 4.2.0)
   checkmate     2.2.0   2023-04-27 [1] CRAN (R 4.2.3)
 V chromote    * 0.1.1   2023-04-30 [1] Github (rstudio/chromote@c4cad74) (on disk 0.1.1.9001)
   cli           3.6.1   2023-03-23 [1] CRAN (R 4.2.2)
   crayon        1.5.2   2022-09-29 [1] CRAN (R 4.2.0)
   curl          5.0.0   2023-01-12 [1] CRAN (R 4.2.0)
   desc          1.4.2   2022-09-08 [1] CRAN (R 4.2.0)
   digest        0.6.31  2022-12-11 [1] CRAN (R 4.2.0)
   ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.2.0)
   fansi         1.0.4   2023-01-22 [1] CRAN (R 4.2.2)
   fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.2.0)
   fs            1.6.2   2023-04-25 [1] CRAN (R 4.2.3)
   glue          1.6.2   2022-02-24 [1] CRAN (R 4.2.0)
   htmltools     0.5.5   2023-03-23 [1] CRAN (R 4.2.2)
   httpuv        1.6.9   2023-02-14 [1] CRAN (R 4.2.2)
   httr          1.4.5   2023-02-24 [1] CRAN (R 4.2.0)
   jsonlite      1.8.4   2022-12-06 [1] CRAN (R 4.2.2)
   later         1.3.0   2021-08-18 [1] CRAN (R 4.2.0)
   lifecycle     1.0.3   2022-10-07 [1] CRAN (R 4.2.0)
   magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.2.0)
   mime          0.12    2021-09-28 [1] CRAN (R 4.2.0)
   pillar        1.9.0   2023-03-22 [1] CRAN (R 4.2.0)
   pkgbuild      1.4.0   2022-11-27 [1] CRAN (R 4.2.0)
   pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.2.0)
   prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.2.0)
   processx      3.8.1   2023-04-18 [1] CRAN (R 4.2.0)
   promises      1.2.0.1 2021-02-11 [1] CRAN (R 4.2.0)
   ps            1.7.5   2023-04-18 [1] CRAN (R 4.2.0)
   R6            2.5.1   2021-08-19 [1] CRAN (R 4.2.0)
   Rcpp          1.0.10  2023-01-22 [1] CRAN (R 4.2.0)
   remotes       2.4.2   2021-11-30 [1] CRAN (R 4.2.0)
   rlang         1.1.1   2023-04-28 [1] CRAN (R 4.2.0)
   rprojroot     2.0.3   2022-04-02 [1] CRAN (R 4.2.0)
   rstudioapi    0.14    2022-08-22 [1] CRAN (R 4.2.0)
   sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.2.0)
   shiny         1.7.4   2022-12-15 [1] CRAN (R 4.2.0)
   shinytest2  * 0.2.1   2023-02-21 [1] CRAN (R 4.2.0)
   testthat    * 3.1.7   2023-03-12 [1] CRAN (R 4.2.0)
   tibble        3.2.1   2023-03-20 [1] CRAN (R 4.2.0)
   utf8          1.2.3   2023-01-31 [1] CRAN (R 4.2.2)
   vctrs         0.6.2   2023-04-19 [1] CRAN (R 4.2.0)
   websocket     1.4.1   2021-08-18 [1] CRAN (R 4.2.0)
   withr         2.5.0   2022-03-03 [1] CRAN (R 4.2.0)
   xtable        1.8-4   2019-04-21 [1] CRAN (R 4.2.0)

 [1] /Library/Frameworks/R.framework/Versions/4.2/Resources/library

 V ── Loaded and on-disk version mismatch.

───────────────────────────────────────────────────────────────────────────
```