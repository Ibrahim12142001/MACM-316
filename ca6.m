function ca6()
% Part a
dataX = [0.0 1.0 2.0 2.0 3.0];
dataY = [0.0 3.0 3.0 4.0 5.0];
paramT = 0 : 1 : 4;
interpPoints = linspace(0, 4, 10000);
splineY = spline(paramT, dataX);
splineX = spline(paramT, dataY);
Interp_R = ppval(splineY, interpPoints);
Interp_S = ppval(splineX, interpPoints);
figure;
plot(dataX, dataY, 'bo', interpPoints, Interp_R, 'r', 'LineWidth', 1.5);
legend('Data', 'R(t)');title('x = R(t)');xlabel('t');ylabel('R(t)');grid on;
figure;
plot(dataX, dataY, 'bo', interpPoints, Interp_S, 'r', 'LineWidth', 1.5);
title('y = S(t)');xlabel('t');ylabel('y');legend('Data', 'S(t)');grid on;
figure;
plot(dataX, dataY, 'bo', Interp_R, Interp_S, 'r', 'LineWidth', 1.5);
legend('Data', 'S(t) vs R(t)');
title('S(t) vs R(t)');xlabel('R(t)');ylabel('S(t)');grid on;
% Part b
leafX = [2.75 1.3 -0.25 0.0 0.25 -1.3 -2.5 -1.3 0.25 0.0 -0.25 1.3 2.75];
leafY = [-1.0 -0.75 0.8 2.0 0.8 -0.25 0.0 0.25 -1.3 -2.5 -1.3 -0.25 -1.0];
paramT_b = -3 : 0.5 : 3;
interpPoints_b = linspace(-3, 3, 10000);
splineY_b = spline(paramT_b, leafX);
splineX_b = spline(paramT_b, leafY);
Interp_R_b = ppval(splineY_b, interpPoints_b);
Interp_S_b = ppval(splineX_b, interpPoints_b);
figure;
plot(leafX, leafY, 'bo', Interp_R_b, Interp_S_b, 'g', 'LineWidth', 1.5);
legend('Leaf Data', 'S(t) vs R(t)');
title('S(t) vs R(t)'); xlabel('R(t)'); ylabel('S(t)'); grid on;
% Part c
[list_A] = perspline(paramT_b, leafX);
[list_B] = perspline(paramT_b, leafY);
perspline(list_A, list_B);
% Part d
figure('position', get(0,'screensize')) % largest window possible
axes('position', [0 0 1 1])
axis square % make x,y-axes equal
%imshow('myimage.png') % display your drawing on-screen
[x,y] = ginput; % record mouse clicks until ’Enter’
close % get rid of huge window
save mydatafile.mat x y % save x,y data points to a file
t_param = linspace(0,1,length(x));
[list1] = perspline(t_param,x');
[list2] = perspline(t_param,y');
perspline(list1,list2);
hold on; plot(x,y,'sb','LineWidth',3); hold off;
end