function [xfinal, niter, xlist] = fixedpt( gfunc, xguess, tol )
% FIXEDPT: Fixed point iteration for x=gfunc(x).
%
%  Sample usage:
%     [xfinal, niter, xlist] = fixedpt( gfunc, xguess, tol )
%
%  Input:
%     gfunc   - fixed point function 
%     xguess  - initial guess at the fixed point
%     tol     - convergence tolerance (OPTIONAL, defaults to 1e-6)
%
%  Output:
%     xfinal  - final estimate of the fixed point
%     niter   - number of iterations to convergence
%     xlist   - list of interates, an array of length 'niter'

% First, do some error checking on parameters.
if nargin < 2
  fprintf( 1, 'FIXEDPT: must be called with at least two arguments' );
  error( 'Usage:  [xfinal, niter, xlist] = fixedpt( gfunc, xguess, [tol] )' );
end
if nargin < 3, tol = 1e-6; end

% fcnchk(...) allows a string function to be sent as a parameter, and
% coverts it to the correct type to allow evaluation by feval().
gfunc = fcnchk(gfunc);
x = xguess;
xlist = [ x ];

niter = 0;
done  = 0;
while ~done,
  xnew  = feval(gfunc,  x);
  xlist = [ xlist; xnew ];  % create a list of x-values 
  niter = niter + 1;
  if abs(x-xnew) < tol,     % stopping tolerance for x only
    done = 1;
  end
  x = xnew;
end
xfinal = xnew;
