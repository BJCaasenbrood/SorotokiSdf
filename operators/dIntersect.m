function d = dIntersect(d1,d2) 
% DINTERSECT Calculates the intersection of two matrices and appends the maximum value
%
%   d = dIntersect(d1, d2) calculates the intersection of two matrices, d1 and d2, and appends the maximum value
%   of each row from d1 and d2. The output d is a matrix where each row corresponds to a row in d1 and d2, and 
%   contains the intersected values from d1 and d2, along with the maximum value from both matrices.
%
% Input:
%   - d1: a matrix of size N-by-M representing N rows with M columns.
%   - d2: a matrix of size N-by-M representing N rows with M columns.
%
% Output:
%   - d: the intersection of d1 and d2, along with the maximum value from both matrices.

    
d=[d1(:,1:(end-1)),d2(:,1:(end-1))];
d=[d,max(d1(:,end),d2(:,end))];
end
