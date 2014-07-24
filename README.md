# Google Charts bindings for Shiny

See [Google Charts](https://developers.google.com/chart/interactive/docs/gallery) and [Shiny](http://rstudio.com/shiny/).

Although Google Charts bindings for Shiny already exist in the [googleVis package](http://cran.r-project.org/web/packages/googleVis/index.html), these bindings are higher performance and more reliable for Shiny usage. However, unlike the googleVis package, this package cannot generate static HTML pages--it is only for use with live Shiny applications.

### Installation

Enter these commands into your R console or [RStudio](http://www.rstudio.com/) console:

```r
if (!require(devtools))
  install.packages("devtools")
devtools::install_github("jcheng5/googleCharts")
```

### Disclaimer

This code is brand new. The API may evolve, and even the package name may change. And docs are very sparse at the moment.

### License

[GNU General Public License, version 3](http://cran.r-project.org/web/licenses/GPL-3)

Copyright 2013 RStudio, Inc.
