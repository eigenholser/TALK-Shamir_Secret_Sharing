# Theory and Application of Shamir Secret Sharing

Openwest 2017 talk on Shamir Secret Sharing. This repository contains:

* Slides in `reveal.js`
* Demo API in `sss-api`
* Figures for the slides and supporting materials in `figures`
* Original paper `How to Share a Secret` by Adi Shamir in `docs`.

# Run the Demo

You can easily run the demo API if you have Scala and SBT installed. The
instructions are in the [README](sss-api).


# Build the Figures

The graphs are generated with [Gnuplot](http://gnuplot.info). There is a
makefile that will build all of the Gnuplot scripts into PNG images. Just
type `make`.

There is some supporting detail on the mathematics in the `tex` directory.
Build that into a PDF document by using the same incantation: `make`.
