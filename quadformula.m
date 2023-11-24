function roots = quadformula(a, b, c)
   roots = []; % Initialize roots variable
   x = linspace(-5, 5); % Define x variable
   if a == 0
       if b == 0
           fprintf('There are no roots as a = 0 and b = 0\n');
           y = c * ones(size(x));
           plot(x, y, 'LineWidth', 2, 'DisplayName', 'Line');
           title("Line: (" + c + ") = y");
           xlabel("x axis");
           ylabel("y axis");
       else
           roots = -c/b;
           fprintf('There is 1 real root: ');
           z = length(roots);
           if z == 1
               if (roots(1) == -inf) || (roots(1) == inf)
                   x = linspace(-5, 5);
               else
                   x = linspace(roots(1) - 5, roots(1) + 5);
               end
           end
           plot(roots, zeros(size(roots)), 'bX', 'MarkerSize', 30);
           legend('Roots');
           hold on;
           if b ~= 0
               plot(x, b*x + c, 'LineWidth', 2, 'DisplayName', 'Linear Equation');
           end
           title("Root of the linear Equation: (" + b + ")x + (" + c + ") = 0");
           xlabel("x axis");
           ylabel("y axis");
           hold off;
       end
   else
       D = b^2 - 4*a*c;
       if D > 0
           if b >= 0
               root1 = (-2*c) / (b + sqrt(D));
               root2 = (-b - sqrt(D)) / (2*a);
           else
               root1 = (-b + sqrt(D)) / (2*a);
               root2 = (-2*c) / (b - sqrt(D));
           end
           roots = [root1, root2]; 
           
           fprintf('There are 2 real roots: ');
           
               

       elseif D == 0
           root1 = (-b) / (2*a);
           roots = root1; 
           fprintf('There is 1 real root: ');
       else
           fprintf('There are no real roots, only complex roots\n');
       end
       z = length(roots);
       if z == 2
           if ~isinf(roots(1)) && ~isinf(roots(2))
               x = linspace(min(roots) - abs(roots(1) - roots(2)), max(roots) + abs(roots(1) - roots(2)));
           elseif isinf(roots(1)) && ~isinf(roots(2))
               x = linspace(roots(2) - 5, roots(2) + 5);
           elseif ~isinf(roots(1)) && isinf(roots(2))
               x = linspace(roots(1) - 5, roots(1) + 5);
           end
       elseif z == 1
           if isinf(roots(1))
               x = linspace(-5, 5);
           else
               x = linspace(roots(1) - 5, roots(1) + 5);
           end
       end
       if D >= 0
           plot(roots, zeros(size(roots)), 'bX', 'MarkerSize', 30);
           legend('Roots');
       end
       hold on;
       plot(x, a*(x.^2) + b*x + c, 'LineWidth', 2, 'DisplayName', 'Quadratic Function');
       title("Roots for the quadratic equation (" + a + ")x^2 + (" + b + ")x +(" + c +") = 0");
       xlabel("x axis");
       ylabel("y axis");
       hold off;
   end
end

