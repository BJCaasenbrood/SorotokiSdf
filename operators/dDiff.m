function d = dDiff(d1,d2) 
% DDIFF Calculates the difference between two matrices and appends the maximum value.
%
%   d = dDiff(d1, d2) calculates the difference between two matrices, d1 and d2, and appends the maximum value
%   of each row from d1 and the negation of the maximum value of each row from d2. The output d is a matrix where 
%   each row corresponds to a row in d1 and d2, and contains the differences and maximum values as follows:
%   [differences from d1, maximum value from d1 and negation of maximum value from d2].
%
% Input:
%   - d1: a matrix of size N-by-M representing N rows with M columns.
%   - d2: a matrix of size N-by-M representing N rows with M columns.
%
% Output:
%   - d: the differences between d1 and d2, along with the maximum value from d1 and negation of the maximum value from d2.

d=[d1(:,1:(end-1)),d2(:,1:(end-1))];
d=[d,max(d1(:,end),-d2(:,end))];
end
