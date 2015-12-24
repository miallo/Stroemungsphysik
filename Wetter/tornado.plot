reset
set terminal epslatex color
set output 'tornado.tex'
set xlabel '$r$ [cm]'
set ylabel '$v$ [$\frac{\text{m}}{\text{s}}$]'

f1(x) = (x<R1) ? a1*x+c1 : (a1*R1**2+c1*R1)/x
f2(x) = (x<R2) ? a2*x+c2 : (a2*R2**2+c2*R2)/x
g1(x) = b1*(1-exp(-d1*(x+e1)**2))/(x+e1)
g2(x) = b2*(1-exp(-d2*(x+e2)**2))/(x+e2)
b2 = 79.8632
d2 = 0.0276828
e2 = 1.37071

b1 = 79.8632
d1 = 0.0276828
e1 = 1.37071

fit f1(x) 'tornado.dat' u 1:2 via a1,R1,c1
fit f2(x) 'tornado.dat' u 1:3 via a2,R2,c2
fit g1(x) 'tornado.dat' u 1:2 via b1,d1,e1
fit g2(x) 'tornado.dat' u 1:3 via b2,d2,e2

p 'tornado.dat' u 1:2:(0.05) w e t '$20,$cm hoch',\
  'tornado.dat' u 1:3:(0.05) w e t '$30,$cm hoch',\
  f1(x),f2(x),g1(x),g2(x)

set output
!epstopdf tornado.eps
!rm tornado.eps
