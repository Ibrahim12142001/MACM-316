function ca3()
    equation = @(x) ((1-x) * (3+x)^(1/3)) / (x * (4-x)^(1/2)) - 3.06;
    [bisect_root, bisect_iter] = bisect2(equation, [0.1, 1.0]);
    fprintf('Bisection Approximation: %f\nNumber of Iterations: %d\n\n', bisect_root, bisect_iter);
    newton_derivative = @(x) ((-x^3 - 10*x^2 + 11*x - 72) / (6*x^2 * (x + 3)^(2/3) * (-x + 4)^(3/2)));
    [newton_root, newton_iter] = newtonb(equation, newton_derivative, [0.1,1.0]);
    fprintf('Newton Approximation: %f\nNumber of Iterations: %d\n\n', newton_root, newton_iter)
    x_vals = -2:0.02:3;
    func = @(x) (((1-x).*((3+x).^(1/3)))./(x.*((4-x).^(1/2))))-3.06;
    plot(x_vals, func(x_vals), "LineWidth", 2);
    xlabel("X-Axis");
    ylabel("Y-Axis");
    grid on;
    title("Part A");
    hold on;
    plot(newton_root, zeros(size(newton_root)), 'rX', 'MarkerSize', 30);
    legend('Roots');
    hold off;
end

