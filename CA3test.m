function ca3()
x = -2:0.01:3;
func = @(x) (((1-x).*((3+x).^(1/3)))./(x.*((4-x).^(1/2))))-3.06;

plot(x, func(x));
xlabel('x axis')
ylabel('y axis')