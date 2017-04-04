set terminal png transparent nointerlace \
    font "lucon.ttf,20" \
    size 1920,1080 nocrop \
    noenhanced \
    background '#FFFFFF'

set output "quadratic-3.png"
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
set xrange [-13:20]
set grid xtics
set mxtics
set xlabel "x" font "lucon.ttf,30"

set grid ytics
set mytics
set my2tics
set ylabel "f(x)" font "lucon.ttf,30"
#set ytics nomirror
#set y2tics nomirror
set label 1 "2005-2017 © eigenholser" \
    at screen 0.99,0.014 right font "times.ttf,12"
set label 2 "f(x) = 7x^2 + 3x + 42" at screen 0.33,0.745 left font "times.ttf,30"
set label 3 "f(x) = α(x^2 - 7x + 10) + 52x - 28" at screen 0.33,0.710 left font "times.ttf,30"
set title "Quadratic polynomials passing through points (2,76) and (5,232)" font "lucon.ttf,30"

# Greek α symbol is U03B1
f(x) = 7.0*x**2 + 3.0*x + 42
x1 = 2
x2 = 5
x3 = -1
x4 = -9
x5 = 11
x6 = 16
set style line 1 pointtype 7 linecolor rgb '#000000' pointsize 4
plot \
    (-89.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (-55.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (-34.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (-21.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (-8.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (13.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (21.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (34.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (55.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (89.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (120.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    (144.0*(x**2 - 7.0*x + 10.0) + 52.0*x - 28.0) axes x1y1 not with lines linestyle 102, \
    f(x) axes x1y1 not with lines linestyle 106, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('(%.1d,%.1d)', x1, f(x1))) \
    with labels offset char -2,0.8 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('(%.1d,%.1d)', x2, f(x2))) \
    with labels offset char -2,-1.4 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x3 : NaN):(f(x3)):(sprintf('(%.1d,%.1d)', x3, f(x3))) \
    with labels offset char 0.5,-1.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x4 : NaN):(f(x4)):(sprintf('(%.1d,%.1d)', x4, f(x4))) \
    with labels offset char 0.5,-1.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x5 : NaN):(f(x5)):(sprintf('(%.1d,%.1d)', x5, f(x5))) \
    with labels offset char 0.5,-1.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x6 : NaN):(f(x6)):(sprintf('(%.1d,%.1d)', x6, f(x6))) \
    with labels offset char 0.5,-1.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle
