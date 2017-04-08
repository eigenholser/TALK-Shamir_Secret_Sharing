set output "line.png"
load "settings.gp"

f(x) = 4.0*x + 42
x1 = -17
x2 = -16
plot \
    f(x) axes x1y1 not with lines linestyle 102, \
    '+' using ($0 == 0 ? x1 : NaN):(f(x1)):(sprintf('P1')) \
    with labels offset char -1.5,1 left textcolor rgb 'blue' \
    point linestyle 1 notitle, \
    '+' using ($0 == 0 ? x2 : NaN):(f(x2)):(sprintf('P2')) \
    with labels offset char -1.5,1 left textcolor rgb 'blue' \
    point linestyle 1 notitle
