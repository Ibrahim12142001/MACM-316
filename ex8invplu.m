% EXAMPLE 8: From section 3b of the lecture notes.
% Compute the inverse of a matrix A (originally from Exampl 5)
% using the PLU decomposition.
%
% Note: These are not the PLU factors using partial pivoting, since 
% this was based on an earlier example where we swapped rows only
% for *zero* pivot.  

format short
A = [2 4 -2 -2; 1 2 4 -3; -3 -3 8 -2; -1 1 6 -3];
P = [1 0 0 0; 0 0 0 1; 0 1 0 0; 0 0 1 0];
L = [1 0 0 0; -1/2 1 0 0; 1/2 0 1 0; -3/2 1 0 1];
U = [2 4 -2 -2; 0 3 5 -4; 0 0 5 -2; 0 0 0 -1];

% First, check that PA = LU:
P*A - L*U  % should be zero

% Determine the columns of the inverse matrix, one at a time, 
% using the PLU decomposition:
ei = [1; 0; 0; 0]; z = L \ (P*ei); x1 = U \ z;
ei = [0; 1; 0; 0]; z = L \ (P*ei); x2 = U \ z;
ei = [0; 0; 1; 0]; z = L \ (P*ei); x3 = U \ z;
ei = [0; 0; 0; 1]; z = L \ (P*ei); x4 = U \ z;
% Each could be done using the single command: x1 = U \ (L\(P*ei));

% Assemble the columns and check that it's the same as inv(A):
Ainv = [x1, x2, x3, x4]

myId = A * Ainv % should be the 4x4 identity matrix

% NOTE: There are some round-off errors!
myId(1,2)  % it's not zero, but close to machine epsilon

% Finally, check that the PLU factors from partial pivoting 
% are different:
[L, U, P] = lu(A)