% 09-Apr-2023 16:04:46
% Auto-generated test script

% Initialize the test suite
% Add test cases here

f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
B = [-2,2,-2,2];
S = Sdf(f,'BdBox',B);

