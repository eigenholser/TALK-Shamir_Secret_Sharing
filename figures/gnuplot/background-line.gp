set output "background-line.png"
load "settings.gp"

set xrange [-2:2]
f(x) = 2*x
x1 = -1.5
x2 = 1.5
plot f(x) axes x1y1 not with lines linestyle 102, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('P1')) \
    with labels offset char -3,0.8 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('P2')) \
    with labels offset char 1,-1.2 left textcolor rgb 'blue' \
    point linestyle 1 notitle
