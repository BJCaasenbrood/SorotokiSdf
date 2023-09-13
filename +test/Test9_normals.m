% 09-Apr-2023 18:45:10
% Auto-generated test script

% Initialize the test suite
% Add test cases here

s = sCircle(1) - sCircle(1.25,[-1,-1]);
s.BdBox = [-2,2,-2,2];

th = linspace(-pi,pi,10).';
R  = 0.95*sqrt(2);
P  = R.*[cos(th), sin(th)];

s.show();
[T,N,B] = s.normal(P);

fplot(P,'k.','MarkerSize',20);
fquiver(P,T,0.3,'color',col(1),'LineW',1.5); 
fquiver(P,N,0.3,'color',col(2),'LineW',1.5); 
