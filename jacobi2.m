function [x, niter] = jacobi2( A, b, x0, tol, maxiter )
% JACOBI2: Jacobi's iterative method for solving a linear system.
%          This is a vectorized version of the algorithm that 
%          avoids for loops.
%
% Usage:
%    [x, niter] = jacobi2( A, b, [x0, tol, maxiter] )
%
% Inputs:
%    A   - square matrix of size n x n
%    b   - right hand side vector of length n
%    x0  - initial guess [OPTIONAL, default=zeros(n,1)]
%    tol - absolute error tolerance [OPTIONAL, default=1e-4]
%    maxiter - max number of iterations [OPTIONAL, default=1000]
%
% Outputs:
%    x     - approximate solution at the final iteration
%    niter - actual number of iterations completed

% Author: John Stockie, Math Department, SFU
%         jstockie@sfu.ca
% Date:   October 9, 2018
%
if nargin < 2, error( 'Insufficient arguments to jacobi2' ), end
n = length(b);
if nargin < 3, x0 = zeros(n,1); end
if nargin < 4, tol = 1e-4;      end
if nargin < 5, maxiter = 1000;  end

done  = 0;
niter = 0;
xold  = x0;
x     = x0;

dvec = diag(A);        % diagonal entries of A (vector)
% U = triu(A, 1);
% L = tril(A,-1);
Aoff = A - diag(dvec); % L+U, off-diagonal part of A

while ~done,
  x = (-Aoff * x + b) ./ dvec;
  xdiff = norm(x - xold, 1);
  niter = niter + 1;
  xold = x;
  if xdiff < tol | niter >= maxiter, done = 1; end
end
