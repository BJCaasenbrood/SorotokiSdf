% 09-Apr-2023 18:45:10
% Auto-generated test script

% Initialize the test suite
% Add test cases here

s = sCircle(1) - sCircle(1.25,[-1,-1]);
s.BdBox = [-2,2,-2,2];
s.options.Quality = 120;

th = random(-pi,pi,100).';
R  = 1.25*sqrt(2);
P  = R.*[cos(th),sin(th)];

s.show();
prj = s.surfaceproject(P);
fplot(P,'k.','MarkerSize',20);
fplot(prj,'w.','MarkerSize',20);