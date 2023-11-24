function roots = quadformula(a, b, c)
% Check if a is zero
if a == 0
% Check if b is zero
if b == 0
roots = [];
fprintf('There are no roots as a = 0 and b = 0');
else
roots = (-c/b);
fprintf('Roots are: '); disp(roots);
end
else
% Calculate the discriminant
D = b^2 - 4*a*c;

    % Check if D is greater than zero
    if D > 0
        % Check the value of b
        if b < 0
            root1 = (-2*c) / (b - sqrt(D));
            root2 = (-b + sqrt(D)) / (2*a);
        else
            root1 = (-b - sqrt(D)) / (2*a);
            root2 = (-2*c) / (b + sqrt(D));
        end
        roots = [root1, root2]; % 2 real roots, smallest first
        fprintf('There are 2 roots: '); disp(roots);
    elseif D == 0
        root1 = (-b) / (2*a);
        roots = root1; % 2 same roots
        fprintf('There are 2 same roots: '); disp(roots);
    else
        roots = []; % empty array
        fprintf('There are no real roots\n');
    end
end

l = length(roots);

if l == 2
    if (roots(1) ~= -inf) && (roots(2) ~= inf)
        x = linspace(min(roots) - 10, max(roots) + 10);
    elseif (roots(1) == -inf) && (roots(2) ~= inf)
        x = linspace(roots(2) - 10, roots(2) + 10);
    elseif (roots(1) ~= -inf) && (roots(2) == inf)
        x = linspace(roots(1) - 10, roots(1) + 10);
    else
        x = linspace(-10, 10);
    end
elseif l == 1
    if (roots(1) == -inf) || (roots(1) == inf)
        x = linspace(-10, 10);
    else
        x = linspace(roots(1) - 10, roots(1) + 10);
    end
else
    x = linspace(-10, 10);
end

if D ~= 0
    plot(roots, 0, 'dk');
    legend('Roots');
end

hold on;
plot(x, a*(x.^2) + b*x + c, 'LineWidth', 3, 'DisplayName', 'Function');
title("Roots for a = " + a + ", b = " + b + ", c = " + c);
xlabel("x axis");
ylabel("y axis");
hold off;
end