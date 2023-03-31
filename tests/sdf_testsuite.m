clr;

f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
B = [-2,2,-2,2];

%% TEST
disp('Sdf: Test 1');
try
    S = Sdf(f,'BdBox',B);
catch e
    
end

%% TEST
disp('Sdf: Test 1');
try
    S.show;
catch e
    disp(e)
end

%% TEST
f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
S1 = Sdf(f,'BdBox',B);

disp('Sdf: Test 3 - Sdf Union');
try
    S2 = S1 + S;
    S2.show();
catch e
    disp(e)
end