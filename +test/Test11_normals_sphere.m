s = sSphere(1) - sSphere(1.25,[-1,-1,-1]);
s.BdBox = [-2,2,-2,2,-2,2];

th = random(-pi,pi,100).';
ph = random(-pi,pi,100).';
R  = 0.85*sqrt(2);
P  = R.*[sin(ph) .* cos(th),  sin(ph) .* sin(th), cos(ph)];

s.render(); hold on;
[T,N,B] = s.normal(P);

fplot(P,'k.','MarkerSize',20);
fquiver(P,T,0.3,'color',col(1),'LineW',1.5); 
fquiver(P,N,0.3,'color',col(2),'LineW',1.5); 
fquiver(P,B,0.3,'color',col(3),'LineW',1.5); 