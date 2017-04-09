set output "background-parabola.png"
load "settings.gp"

set xrange [-2:2]
f(x) = x**2
x1 = -1.75
x2 = 0
x3 = 1.75
plot f(x) axes x1y1 not with lines linestyle 102, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('P1')) \
    with labels offset char 0.6,0.6 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('P2')) \
    with labels offset char -1.0,1.0 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x3 : NaN):(f(x3)):(sprintf('P3')) \
    with labels offset char -2.8,0.6 left textcolor rgb 'blue' \
    point linestyle 1 notitle
