function table = ca2()
    width = 28;
    height = 25;
    base = 3.5;
    
    theta = linspace(rad2deg(-pi), rad2deg(pi));
    f = @(theta) height * cosd(theta) + base - width * sind(theta);
    plot(theta, f(theta), "LineWidth", 3);
    xlabel("X-Axis");
    ylabel("Y-Axis");
    grid on;
    title("Part A");
    
    equation = '25 * cos(theta) + 3.5 - 28 * sin(theta)';
    [bisectionRoot, bisectionIterations] = bisect2(equation, [0, pi/2], deg2rad(1));
    bisectionRoot = rad2deg(bisectionRoot);
    fprintf('The root obtained by Bisection method: %f\nIt took %d iterations \n\n', bisectionRoot, bisectionIterations);
    
    fixedPointFunc = @(theta) atan((height + base * sec(theta)) / width);
    [fixedPointRoot, fixedPointIterations] = fixedpt(fixedPointFunc, 0, deg2rad(1));
    fixedPointRoot = rad2deg(fixedPointRoot);
    fprintf('The root obtained by Fixed Point method: %f\nIt took %d iterations \n\n', fixedPointRoot, fixedPointIterations);
    
    newtonDerivative = '-25 * sin(theta) - 28 * cos(theta)';
    [newtonRoot, newtonIterations] = newton(equation, newtonDerivative, 0, deg2rad(1));
    newtonRoot = rad2deg(newtonRoot);
    fprintf('The root obtained by Newton method: %f\nIt took %d iterations \n\n', newtonRoot, newtonIterations);
    
    theta1 = acos((-base * height + sqrt((base^2 * height^2) + (height^2 + width^2) * (width^2 - base^2))) / (height^2 + width^2));
    theta1 = rad2deg(theta1);
    fprintf('Exact Root: %f\n\n', theta1);
    errorb = abs(theta1 - bisectionRoot);
    errorf = abs(theta1 - fixedPointRoot);
    errorn = abs(theta1 - newtonRoot);
    errorb1 = abs(bisectionRoot - theta1)/theta1 ;
    errorf1 = abs(fixedPointRoot - theta1)/theta1 ;
    errorn1 = abs(theta1 - newtonRoot)/theta1;
    fprintf('Absolute error for bisection: %f\n', errorb);
    fprintf('Relative error for bisection: %f\n\n', errorb1);
    fprintf('Absolute error for Fixed Point: %f\n', errorf);
    fprintf('Relative error for Fixed Point: %f\n\n', errorf1);
    fprintf('Absolute error for Newton: %f\n', errorn);
    fprintf('Relative error for Newton: %f\n\n', errorn1);
    d2Approx = height / (2 * sind(newtonRoot));
    c = base / tand(newtonRoot);
    a = base / tand(rad2deg(pi/2) - newtonRoot);
    d1Approx = d2Approx - a - c;
    fprintf('d1: %f\nd2: %f\n\n', d1Approx, d2Approx);
    d2Exact = height / (2 * sind(theta1));
    c = base / tand(theta1);
    a = base / tand(rad2deg(pi/2) - theta1);
    d1Exact = d2Exact - a - c;
    fprintf('d1exact: %f\nd2exact: %f\n\n', d1Exact, d2Exact);
    tol = abs(d1Exact - d1Approx);
    tol2 = abs(d2Exact - d2Approx);
    fprintf('Absolute error for d1: %f\nAbsolute error for d2: %f\n', tol, tol2);
end
