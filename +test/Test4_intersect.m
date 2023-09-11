% 09-Apr-2023 16:08:41
% Auto-generated test script

% Initialize the test suite
% Add test cases here

clf;
f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
B = [-2,2,-2,2];
S = Sdf(f,'BdBox',B);

f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
S1 = Sdf(f2,'BdBox',B);

S2 = S1 / S; 
S2.show();