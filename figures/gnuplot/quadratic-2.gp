set output "quadratic-2.png"
load "settings.gp"

set label 2 "Quadratic polynomials passing through points (2,76) and (5,232)" at screen 0.10,0.900 left font "lucon.ttf,30"
set xrange [1.5:5.5]
f(x) = 7.0*x**2 + 3.0*x + 42
x1 = 2
x2 = 5
x3 = 3.5
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
    with labels offset char -2,2.5 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('(%.1d,%.1d)', x2, f(x2))) \
    with labels offset char -4.0,3.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x3 : NaN):(f(x3)):(sprintf('(%.1d,%.1d)', x3, f(x3))) \
    with labels offset char -1.0,0.5 left textcolor rgb 'blue' \
    point linestyle 1 notitle
