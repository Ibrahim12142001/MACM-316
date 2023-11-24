function [x0, iter, xlist] = newtonb(func, pfunc, xguess, tol)
    if nargin < 3
        fprintf(1, 'NEWTON: must be called with at least three arguments' );
        error('Usage:  [x0, iter, xlist] = newton_modified(func, pfunc, xguess, [tol])');
    end
    if nargin < 4
        tol = 10^(-10);
    end    
    a = xguess(1);
    b = xguess(2);
    func = fcnchk(func);
    pfunc = fcnchk(pfunc);
    x0 = (a + b) / 2;
    x = x0;
    fx = feval(func, x);
    fpx = feval(pfunc, x);    
    if fx == 0 || fpx == 0
        error('NEWTON: both f and f'' must be non-zero at the initial guess');
    end    
    maxIter = 100; 
    xlist = zeros(maxIter, 1);
    xlist(1) = x;
    done = false;
    iter = 0;
    while ~done
        [ok, x] = newtBrack(a, b, x0, fx, fpx);        
        if ok == 0 
            warning('The x0 falls outside the bracket, Taking bisection step for new initial guess'); 
            fx0 = feval(func, x0);
            if fx0 * feval(func, a) < 0
                b = x0;
            else
                a = x0;
            end            
            iter = iter + 1;
            x0 = (b + a) / 2;
            fx = feval(func, x0);
            fpx = feval(pfunc, x0);
            
            if abs(fx0) < tol || abs(a - b) < tol || iter >= maxIter
                done = true;
            end
        else
            fx = feval(func, x);
            fpx = feval(pfunc, x);            
            if abs(x - x0) < tol
                done = true;
            else
                iter = iter + 1;
                xlist(iter) = x; 
            end   
            x0 = x;
            if iter >= maxIter
                done = true;
            end
        end
    end
    xlist = xlist(1:iter);
    fprintf('\n');
    fprintf('%f \n', xlist);
    fprintf('\n');
end