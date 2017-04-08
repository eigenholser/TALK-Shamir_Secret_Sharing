set output "cubic-1.png"
load "settings.gp"

set label 2 "Cubic polynomials passing through points (-6,-144), (1,59), and (4,206)" at screen 0.10,0.900 left font "lucon.ttf,30"
set xrange [-7:5]
f(x) = x**3 + 3*x**2 + 13.0*x + 42
x1 = -6
x2 = 1
x3 = 4
plot \
    (-34.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (-21.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (-39.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (-8.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (8.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (39.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (21.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    (34.0*(x**3 + x**2 - 26.0*x + 24) + 2.0*x**2 + 39.0*x + 18.0) axes x1y1 not with lines linestyle 102, \
    f(x) axes x1y1 not with lines linestyle 102, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('(%.1d,%.1d)', x1, f(x1))) \
    with labels offset char -2.6,3.5 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('(%.1d,%.1d)', x2, f(x2))) \
    with labels offset char -2.5,1.5 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x3 : NaN):(f(x3)):(sprintf('(%.1d,%.1d)', x3, f(x3))) \
    with labels offset char -3.0,2.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle
