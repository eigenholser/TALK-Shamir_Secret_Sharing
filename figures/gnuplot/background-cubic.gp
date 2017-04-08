set output "background-cubic.png"
load "settings.gp"

set xrange [-2:2]
f(x) = x**3
plot f(x) axes x1y1 not with lines linestyle 102
