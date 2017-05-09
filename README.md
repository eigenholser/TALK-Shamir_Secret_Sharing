# Theory and Application of Shamir Secret Sharing

Talk on Shamir Secret Sharing. This repository contains:

* Slides in `reveal.js`
* Demo API in `sss-api` written in Scala.
* Figures for the slides and supporting materials in `figures`
* Original paper `How to Share a Secret` by Adi Shamir in `docs`.


# Slides

MathJax is required to view the mathematics in the slides. MathJax is in
transition at the time of this writing with it being removed from the CDN.
The `reveal.js` slides here use a local installation of MathJax. MathJax
is large-ish and not included in this repository. To view the slides, download
and extract MathJax into the `reveal.js/MathJax` directory.


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
tools installed. The PDF is in the ``docs`` directory.

