set terminal png transparent nointerlace \
    font "lucon.ttf,20" \
    size 1920,1080 nocrop \
    noenhanced \
    background '#FFFFFF'

set output "background-title.png"
set encoding utf8

set style line 101 linetype 1 linewidth 5 linecolor rgbcolor '#000000'
set style line 102 linetype 2 linewidth 4 linecolor rgbcolor '#999999'
set style line 103 linetype 3 linewidth 4 linecolor rgbcolor '#A00000'
set style line 104 linetype 4 linewidth 4 linecolor rgbcolor '#FF0000'
set style line 105 linetype 5 linewidth 4 linecolor rgbcolor '#007000'
set style line 106 linetype 6 linewidth 6 linecolor rgbcolor '#00FF00'
set style line 107 linetype 7 linewidth 4 linecolor rgbcolor '#0000A0'
set style line 108 linetype 8 linewidth 4 linecolor rgbcolor '#1E90FF'
set style line 109 linetype 9 linewidth 4 linecolor rgbcolor '#A020F0'

set key off

# TODO: set origin and size as options or calculate.
set origin 0.02,0
set size 0.98,1
set ytics
set xtics
set border
set colorbox
set xrange [-3:3]
set grid xtics
set mxtics
set xlabel "x" font "lucon.ttf,30"

set format y ""
set format x ""
set grid ytics
set mytics
set my2tics
set ylabel "f(x)" font "lucon.ttf,30"
set label 1 "eigenholser" at screen 1.0,0.014 right font "times.ttf,12"

set style line 1 pointtype 7 linecolor rgb '#000000' pointsize 4
plot \
    90*x**2 + 20*x + 90 axes x1y1 not with lines linestyle 102, \
    12*x**3 + 8*x**2 + 20*x + 10  axes x1y1 not with lines linestyle 102, \
    1*x**4 + 19*x**3 + 3*x**2 + x + 300 axes x1y1 not with lines linestyle 102, \
    270*x + 300 axes x1y1 not with lines linestyle 102
