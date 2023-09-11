% 09-Apr-2023 16:11:10
% Auto-generated test script

% Initialize the test suite
% Add test cases here

clf; 
f = @(x) sqrt(x(:,1).^2 + x(:,2).^2 + x(:,3).^2) - 1.0;

disp('Sdf: 3D');
S = Sdf(f,'BdBox',[-2,2,-2,2,-2,2]);

R = S + S;

D = S - S;

L = S / S;