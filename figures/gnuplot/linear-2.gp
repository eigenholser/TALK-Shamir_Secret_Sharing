set output "linear-2.png"
load "settings.gp"

set label 2 "Linear polynomials passing through point (-17,-26)" at screen 0.10,0.900 left font "lucon.ttf,30"
set xrange [-20:-14]
f(x) = 4.0*x + 42
x1 = -17
x2 = -15
plot \
    (-89.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (-55.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (-34.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (-21.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (-13.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (13.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (21.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (34.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (55.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    (89.0*(x + 17) - 26) axes x1y1 not with lines linestyle 102, \
    f(x) axes x1y1 not with lines linestyle 106, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('(%.1d,%.1d)', x1, f(x1))) \
    with labels offset char -3,2 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('(%.1d,%.1d)', x2, f(x2))) \
    with labels offset char 1,-1.2 left textcolor rgb 'blue' \
    point linestyle 1 notitle

