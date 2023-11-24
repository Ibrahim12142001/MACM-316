function [root, iter, xlist] = newton( func, pfunc, xguess, tol )
%NEWTON     Newton's method for solving a nonlinear equation.
%
%   Sample usage:
%     [root, niter, xlist] = newton( func, pfunc, xguess, [tol] )
%
%   Input:
%     func   - function to be solved
%     pfunc  - derivative of 'func'
%     xguess - initial guess at root
%     tol    - convergence tolerance (OPTIONAL, defaults to 1e-6)
%
%   Output:
%     root   - final estimate of the root 
%     niter  - number of iterations until converged
%     xlist  - list of iterates, an array of length 'niter'

% First, do some error checking on parameters.
if nargin < 3
  fprintf(1, 'NEWTON: must be called with at least three arguments' );
  error( 'Usage:  [root, niter, xlist] = newton( func, pfunc, xguess, [tol] )' );
end

if nargin < 4, tol  = 1e-6; end
% fcnchk(...) converts function parameters to the correct type 
% to allow evaluation by feval().
func = fcnchk( func );
pfunc= fcnchk( pfunc );

x    = xguess;
fx   = feval( func,  x );
fpx  = feval( pfunc, x );
if( fx == 0 | fpx == 0 ) 
  error( 'NEWTON: both f and f'' must be non-zero at the initial guess' );
end

xlist= [ x ];
done = 0;
iter = 0;
while( ~done )
  x0  = x;
  x   = x0 - fx / fpx;
  fx  = feval( func,  x );
  fpx = feval( pfunc, x );
  if( abs(x-x0) < tol )     % absolute tolerance on x
    done = 1;
  else
    xlist = [ xlist; x ];   % add to the list of x-values 
    iter  = iter + 1;
  end
end

root = x;
%END newton.
