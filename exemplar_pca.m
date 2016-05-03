rand("seed", 1);
A = rand(4, 4);
A = A - repmat(mean(A, 2), 1, 4);
S = A * A'
T = A' * S * A;
D = diag(T);
var_all = trace(T);

%A2 = [A(:, 1), A(:, 3), A(:, 4),A(:, 2)]
%S2 = A2 * A2'

A_epsilon = A(:, [1, 2]);
var12  = trace(A_epsilon'* S * A_epsilon)


%A_epsilon = A(:, [2, 1]);
%var1  = trace(A_epsilon'* S * A_epsilon)


A_epsilon = A(:, [1,3]);
var13  = trace(A_epsilon'* S * A_epsilon)


%A_epsilon = A(:, [3, 1]);
%var1  = trace(A_epsilon'* S * A_epsilon)


A_epsilon = A(:, [1,4]);
var14  = trace(A_epsilon'* S * A_epsilon)


%A_epsilon = A(:, [4, 1]);
%var1  = trace(A_epsilon'* S * A_epsilon)


A_epsilon = A(:, [2, 3]);
var23  = trace(A_epsilon'* S * A_epsilon)

%A_epsilon = A(:, [3, 2]);
%var1  = trace(A_epsilon'* S * A_epsilon)

A_epsilon = A(:, [2, 4]);
var24  = trace(A_epsilon'* S * A_epsilon)


%A_epsilon = A(:, [4, 2]);
%var1  = trace(A_epsilon'* S * A_epsilon)


A_epsilon = A(:, [3, 4]);
var34  = trace(A_epsilon'* S * A_epsilon)

%A_epsilon = A(:, [4, 3]);
%var1  = trace(A_epsilon'* S * A_epsilon)


[U, sigma, V] = svd(A);
P = U(:, [1,2]);
A_lower = P' * A;
var(A_lower');

svd_var = trace(A_lower * A_lower')
orig_var = trace(A * A')

