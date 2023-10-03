classdef SdfTest < matlab.unittest.TestCase

    methods (Test)

        function testAddition(testCase)
            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
            B = [-2,2,-2,2];
            S = Sdf(f,'BdBox',B);
        
            f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
            S1 = Sdf(f2,'BdBox',B);
        
            S2 = S1 + S; 
            testCase.verifyClass(S2,'Sdf');
            testCase.verifyEqual(numel(S2.BdBox),4);
        end

        function testConstructor(testCase)
            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
            B = [-2,2,-2,2];
            S = Sdf(f,'BdBox',B);
            testCase.verifyClass(S,'Sdf');
            testCase.verifyEqual(numel(S.BdBox),4);
        end

        function testSubstract(testCase)
            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
            B = [-2,2,-2,2];
            S = Sdf(f,'BdBox',B);

            f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
            S1 = Sdf(f2,'BdBox',B);

            S2 = S1 - S; 
            testCase.verifyClass(S2,'Sdf');
        end

        function testIntersect(testCase)
            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2) - 1.0;
            B = [-2,2,-2,2];
            S = Sdf(f,'BdBox',B);

            f2 = @(x) sqrt((x(:,1)-0.5).^2 + x(:,2).^2) - 1.0;
            S1 = Sdf(f2,'BdBox',B);

            S2 = S1 / S; 
            testCase.verifyClass(S2,'Sdf');
        end

        function test3D(testCase)
            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2 + x(:,3).^2) - 1.0;
            S = Sdf(f,'BdBox',[-2,2,-2,2,-2,2]);
            testCase.verifyClass(S,'Sdf');
            testCase.verifyEqual(numel(S.BdBox),6);
        end

        function test3DOperators(testCase)

            f = @(x) sqrt(x(:,1).^2 + x(:,2).^2 + x(:,3).^2) - 1.0;
            S = Sdf(f,'BdBox',[-2,2,-2,2,-2,2]);
            R = S + S;
            testCase.verifyClass(R,'Sdf');
            testCase.verifyEqual(numel(S.BdBox),6);
            D = S - S;
            testCase.verifyClass(D,'Sdf');
            testCase.verifyEqual(numel(D.BdBox),6);
            L = S / S;
            testCase.verifyClass(L,'Sdf');
            testCase.verifyEqual(numel(L.BdBox),6);
        end

        function testsCircle(testCase)
            S = sCircle();
            testCase.verifyClass(S,'Sdf');
            S = sCircle(1);
            testCase.verifyClass(S,'Sdf');
            S = sCircle(1,[1,2]);
            testCase.verifyClass(S,'Sdf');
        end
    end
    
end