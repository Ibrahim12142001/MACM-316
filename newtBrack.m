function [ok, xnewt] = newtBrack(a, b, x, fx, fpx)
    xnext = x - (fx/fpx);
    if (xnext <= b && xnext >= a)
        ok = 1;
        xnewt = xnext;
    else 
        xnewt = xnext;
        ok = 0;
    end
end