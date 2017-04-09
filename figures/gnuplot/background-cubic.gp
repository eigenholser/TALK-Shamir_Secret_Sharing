set output "background-cubic.png"
load "settings.gp"

set xrange [-2:2]
f(x) = x**3
x1 = -1.8
x2 = -1.4
x3 = 1.4
x4 = 1.8
plot f(x) axes x1y1 not with lines linestyle 102, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('P1')) \
    with labels offset char 0.8,-1.3 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('P2')) \
    with labels offset char 0.8,-1.3 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x3 : NaN):(f(x3)):(sprintf('P3')) \
    with labels offset char -2.5,0.75 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x4 : NaN):(f(x4)):(sprintf('P4')) \
    with labels offset char -2.5,0.75 left textcolor rgb 'blue' \
    point linestyle 1 notitle
