set output "background-line.png"
load "settings.gp"

set xrange [-2:2]
f(x) = 2*x
plot f(x) axes x1y1 not with lines linestyle 102
