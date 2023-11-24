% PERSPLINE: Perform cubic spline interpolation on a given set
%            of data points, using periodic end-point conditions.

% NOTE: Must have y(1)=y(end)!!  So this is a modified version
% of the data used for the other spline examples.
function [list] = perspline(x,y)

x = x';
y = y';
n = length(x) - 1;
list = [];

% Set up the matrix
h = diff(x);
diag0 = [1; 2*(h(1:end-1)+h(2:end)); 2*h(end)];
A = spdiags([[h;0], diag0, [0;h]], [-1, 0, 1], n+1, n+1);
% Then do a little surgery on the first/last rows ...
A(1,2)   = 0;
A(1,end) = -1;
A(end,1) = 2*h(1);
A(end,2) = h(1);
dy = diff(y);
% ... and the RHS vector
rhs = 6*[0; diff(dy./h); dy(1)/h(1)-dy(end)/h(end)];
m = A \ rhs     % Solve for slopes, m_i=S''(x_i)

% Compute the cubic polynomial coefficients
a = y;
b = dy./h - h.*m(1:end-1)/2 - h.*diff(m)/6;
c = m(1:end-1)/2;
d = diff(m)./h/6;

% Plot each spline along with the data
for i = 1 : n,
  xx = linspace(x(i), x(i+1), 100);
  yy = a(i) + b(i)*(xx-x(i)) + c(i)*(xx-x(i)).^2 ...
       + d(i)*(xx-x(i)).^3;
  plot(xx, yy, 'r-')
  list = [list,yy]; 
  hold on
end
plot(x,y,'k.', 'MarkerSize', 1)
hold off
set(gca, 'XLim', [min(x)-0.1, max(x)+0.1])
xlabel('x'), ylabel('S(x)')
grid on, shg
print -djpeg 'perspline.jpg'
