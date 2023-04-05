clr;

f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
B = [-2,2,-2,2];

%% TEST
disp('Sdf: Test 1');
S = Sdf(f,'BdBox',B);

%% TEST
disp('Sdf: Test 1');
S.show;

%% TEST
f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
S1 = Sdf(f2,'BdBox',B);

disp('Sdf: Test 3 - Sdf Union');
S2 = S1 + S; pause(1/3)
cla; S2.show();

disp('Sdf: Test 3 - Sdf Difference');
S2 = S1 - S; pause(1/3)
cla; S2.show();

disp('Sdf: Test 4 - Sdf Intersect');
S2 = S1 / S; pause(1/3)
cla; S2.show();

%%
f = @(x) sqrt(x(:,1).^2 + x(:,2).^2 + x(:,3).^2) - 1.0;

disp('Sdf: 3D');
S = Sdf(f,'BdBox',[-2,2,-2,2,-2,2]);
clf; S.show();
    