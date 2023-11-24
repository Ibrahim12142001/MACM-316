function [root, iterations, x_list] = newtonb(func, pfunc, xguess, tolerance)
% NEWTONB Modified version of Newton's method with initial bracket input.
%
%   Sample usage:
%     [root, iterations, x_list] = newtonb(func, pfunc, bracket, [tolerance])
%
%   Input:
%     func       - function to be solved
%     pfunc      - derivative of 'func'
%     bracket    - initial bracket interval [a, b]
%     tolerance  - convergence tolerance (OPTIONAL, defaults to 1e-6)
%
%   Output:
%     root       - final estimate of the root
%     iterations - number of iterations until converged
%     x_list     - list of iterates, an array of length 'iterations'

% First, do some error checking on parameters.
if nargin < 3
    fprintf(1, 'NEWTONB: must be called with at least three arguments' );
    error('Usage: [root, iterations, x_list] = newtonb(func, pfunc, bracket, [tolerance])');
end

if nargin < 4
    tolerance = 1e-6;
end

% Extract bracket values
a = xguess(1);
b = xguess(2);

x0 = (a + b) / 2;

% Initialize variables
x = x0;
fx = feval(func, x);
fpx = feval(pfunc, x);
[ok, x] = newtBrack(a, b, x0, fx, fpx);        
if ok == 0 
    warning('The x0 falls outside the bracket, Ok is false'); 
end
if abs(fx) < tolerance
    root = x;
    iterations = 0;
    x_list = [x];
    return;
end

x_list = [x];
done = false;
iterations = 0;

while ~done
    x0 = x;
    x = x0 - fx / fpx;
    fx = feval(func, x);
    fpx = feval(pfunc, x);
    if abs(x - x0) < tolerance
        done = true;
    else
        x_list = [x_list; x];
        iterations = iterations + 1;
    end
end

root = x;

%END newtonb.
