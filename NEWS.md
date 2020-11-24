# googleCharts 0.1.1

* `googleChartsInit()` was failing, due to the `intensitymap` chart mode apparently being removed from Google Charts. Removing `intensitymap` from our list of libraries solved the problem.

* Fix error when `googleChartsInit()` is passed explicit chart types.

* Added a `NEWS.md` file to track changes to the package.
