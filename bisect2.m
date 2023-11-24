function [root, niter, rlist] = bisect2( func, xint, tol )
% BISECT2: Bisection algorithm for solving a nonlinear equation
%          (non-recursive).
%
% Sample usage:
%   [root, niter, rlist] = bisect2( func, xint, tol )
% 
%  Input:
%     func    - function to be solved
%     xint    - interval [xleft,xright] bracketing the root
%     tol     - convergence tolerance (OPTIONAL, defaults to 1e-6)
%
%  Output:
%     root    - final estimate of the root
%     niter   - number of iterations needed  
%     rlist   - list of midpoint values obtained in each iteration.

maxiter = 1000;  % don't iterate forever

% First, do some error checking on parameters.
if nargin < 2
  fprintf( 1, 'BISECT2: must be called with at least two arguments' );
  error( 'Usage:  [root, niter, rlist] = bisect2( func, xint, [tol])' );
end
if length(xint) ~= 2, error( 'Parameter ''xint'' must be a vector of length 2.' ), end  
if nargin < 3, tol = 1e-6; end

% fcnchk(...) allows a string function to be sent as a parameter, and
% coverts it to the correct type to allow evaluation by feval().
func = fcnchk( func );

done  = 0;
rlist = [xint(1); xint(2)];
niter = 0;

while ~done,
  xmid = 0.5 * (xint(1) + xint(2));
  fmid = feval(func, xmid);
  if fmid * feval(func, xint(1)) < 0,
    xint(2) = xmid;
  else
    xint(1) = xmid;
  end
  
  rlist = [rlist; xmid];
  niter = niter + 1;

  if abs(xint(2)-xint(1)) < 2*tol | abs(fmid) < tol ...
        | niter > maxiter,
    done = 1;
  end
end

root = xmid;
%END bisect2.
