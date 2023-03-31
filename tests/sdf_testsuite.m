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
S1 = Sdf(f2,'BdBox',B);

disp('Sdf: Test 3 - Sdf Union');
try
    S2 = S1 + S; pause(1/3)
    cla; S2.show();
catch e
    disp(e)
end

disp('Sdf: Test 3 - Sdf Difference');
try
    S2 = S1 - S; pause(1/3)
    cla; S2.show();
catch e
    disp(e)
end

disp('Sdf: Test 4 - Sdf Intersect');
try
    S2 = S1 / S; pause(1/3)
    cla; S2.show();
catch e
    disp(e)
end

%%
f = @(x) sqrt(x(:,1).^2 + x(:,2).^2 + x(:,3).^2) - 1.0;

disp('Sdf: 3D');
try
    S = Sdf(f,'BdBox',[-2,2,-2,2,-2,2]);
    clf; S.show();
catch e
    
end