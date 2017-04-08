set output "background-title.png"
load "settings.gp"

set xrange [-3:3]
plot \
    90*x**2 + 20*x + 90 axes x1y1 not with lines linestyle 102, \
    12*x**3 + 8*x**2 + 20*x + 10  axes x1y1 not with lines linestyle 102, \
    1*x**4 + 19*x**3 + 3*x**2 + x + 300 axes x1y1 not with lines linestyle 102, \
    270*x + 300 axes x1y1 not with lines linestyle 102
