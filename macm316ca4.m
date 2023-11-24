clear all
format long

% Part (a): Set up Hilbert matrices and plot its norm and condition number.
nlist = 2:30; % matrix sizes
cond2H = []; % empty matrix
norm1 = [];
norm2 = [];
condH = [];
for n = nlist
  Hn = hilb(n);
  cond2H = [cond2H, cond(Hn, 2)];
  norm1 = [norm1, norm(Hn, 1)];
  norm2 = [norm2, norm(Hn, 2)];
  condH = [condH, cond(Hn, 1)];
end
semilogy(nlist, norm1, 'LineWidth', 2);
hold on;
semilogy(nlist, norm2,'LineWidth', 2);
semilogy(nlist, condH, 'LineWidth', 2);
semilogy(nlist, cond2H,'LineWidth', 2);
title('Part A and B');
xlabel('n');
ylabel('log(y)');
grid on;
legend('1-Norm', '2-Norm', '1-Norm Cond', '2-Norm Cond');


% Part b: Add the theoretically expected growth to the plot
func = (1 + sqrt(2)).^(4 * nlist) ./ sqrt(nlist);
semilogy(nlist, func, 'DisplayName', 'Theoretical cond', 'LineWidth', 2);
hold off;

% Part c: Compare performance for the ill-conditioned linear system
PLUerror = []; % list of 2-norm errors for PLU
klist = 2:30; % min/max matrix size
j_error = [];
slash_error = [];
PLUtime = [];
j_time = [];
slash_time = [];
for k = klist
  Hk = hilb(k); % generate Hilbert matrix
  x = ones(k, 1); % exact solution (all 1's)
  b = Hk * x; % compute RHS for this x
  tic
  [L, U, P] = lu(Hk);
  xPLU = U \ (L \ (P * b)); 
  PLUtime = [PLUtime, toc];
  PLUerror = [PLUerror, norm(xPLU - x, 2)];
  tic
  backslash = Hk\ b;
  slash_time = [slash_time, toc];
  slash_error = [slash_error, norm(backslash - x, 2)];
  tic
  [Jacobi_x, niter] = jacobi2(Hk, b, rand(k, 1), 1e-4, 100);
  j_time = [j_time, toc];
  j_error = [j_error, norm(Jacobi_x - x, 2)];
end
figure;
semilogy(klist, PLUerror, 'LineWidth', 2);hold on;
semilogy(klist, slash_error, 'LineWidth', 2);
semilogy(klist, j_error,'LineWidth', 2);
title('Part C - Errors versus the problem dimension, n = [2:30]');
xlabel('n'); ylabel('log(y)');grid on;
legend('PLU', 'Backslash', 'Jacobi');hold off;
figure;
semilogy(klist, PLUtime,'LineWidth', 2);hold on;
semilogy(klist, slash_time, 'LineWidth', 2);
semilogy(klist, j_time,'LineWidth', 2);
title('Part C - Cost of methods');
xlabel('n'); ylabel('log(y)');
grid on; legend('PLU ', 'Backslash', 'Jacobi');hold off;

% Part (d): Add curves for '\' and Jacobi to this plot
nlist = 2:30;
max_entry = [];
for n = nlist
  Hn = hilb(n); 
  invHn = inv(Hn);
  M = Hn * invHn; 
  max_entry = [max_entry, max(abs(M(:)))];
end
figure;
plot(nlist, max_entry, 'LineWidth', 2);
title('Part D - Maximum Entry of M versus Matrix Size n');
xlabel('Matrix Size n');
ylabel('Maximum Entry of M');
grid on;
