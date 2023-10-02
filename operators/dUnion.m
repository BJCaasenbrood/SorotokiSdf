function d = dUnion(d1,d2) 
% DUNION Calculates the union of two matrices and appends the minimum value.
%
%   d = dUnion(d1, d2) calculates the union of two matrices, d1 and d2, and appends the minimum value
%   of each row from d1 and d2. The output d is a matrix where each row corresponds to a row in d1 and d2, and 
%   contains the unioned values from d1 and d2, along with the minimum value from both matrices.
%
% Input:
%   - d1: a matrix of size N-by-M representing N rows with M columns.
%   - d2: a matrix of size N-by-M representing N rows with M columns.
%
% Output:
%   - d: the union of d1 and d2, along with the minimum value from both matrices.

d=[d1(:,1:(end-1)),d2(:,1:(end-1))];
d=[d,min(d1(:,end),d2(:,end))];
end
