# Theory and Application of Shamir Secret Sharing

Talk on Shamir Secret Sharing. This repository contains:

* Slides in `reveal.js`
* Demo API in `sss-api` written in Scala.
* Figures for the slides and supporting materials in `figures`
* Original paper `How to Share a Secret` by Adi Shamir in `docs`.


# Slides

Open `reveal.js/index.html` in your browser. MathJax is now included in the
repository because of the CDN transition. This makes the clone somewhat large.


# Demo

`sss-api` is a demo API implemented in Scala. You can easily run the demo API
if you have Scala and SBT installed. The instructions are in the
[README](sss-api).


# Figures

The graphs are generated with [Gnuplot](http://gnuplot.info). There is a
makefile that will build all of the Gnuplot scripts into PNG images. Just
type `make`.

There are [additional details on the mathematics](docs/notes.pdf) in the
`tex` directory.  Build that into a PDF document by using the same
incantation: `make`. You will, of course, need to have the dependent LaTeX
tools installed. The PDF is in the `docs` directory.

# Documents

See the `docs` directory for Adi Shamir's original November 1979 paper
*How to Share a Secret* and some additional notes on the mathematics.
