rand("seed", 3);
A = rand(4, 7);
n = size(A, 2);
d = size(A, 1);

for i = 1: n 
	A(:, i)  = (A(:, i)/ norm(A(:,i)));
end

M = mean(A, 2);

%Normalizing A



A_center = A - repmat(M, 1, n);
[U, sigma, V] = svd(A_center);


%display('Checking the relation between variance and trace');
var((U'* A)');
var(U(:, 1)'* A);

S = A_center * A_center';
trace(U(:,1)' * S * U(:, 1)) / (n-1);

%display('Test using arbitrary weights');
W = [0.2, 0.3, 0.1, 0.4]';
%variance using projection
u = U * W;
v1 = var(u' * A);

%variance using weighted sum
v2 = 0;
for i = 1:d
	v2 = v2 + W(i).^2 * var(U(:, i)'* A);
end
v2;


display('Test using one column at a time...')
A_lower = U' * A; %U * A_lower = A
for i = 1: size(A_lower, 2)
	norm(A_lower(:, i));
end

for j = 1 : n
	W = A_lower(:, j);
	norm(W);	%Norm is 1
	u = U * W;	%u = A(:, j);
	v1 = var(u' * A)

	%variance using weighted sum
	v2 = 0;
	for i = 1:d	
		v2 = v2 + W(i).^2 * var(U(:, i)'* A);
	end
	v2
	display('------')
end
%{
display('Testing using one normalized column at a time ...')
for j = 1 : n
	A_lower = U' * A;
	W = A_lower(:, j);

	u = U * W;	%u = A(:, j);
	u = u / norm(u);
	v1 = var(u' * A)

	%variance using weighted sum
	v2 = 0;
	for i = 1:d	
		v2 = v2 + W(i).^2 * var(U(:, i)'* A);
	end
	v2
	display('------')
end
%}
display('Test using two columns ...')
list = [1,7; 1, 4; 2, 3];
A_lower
for j = 1 : size(list, 1)
	indexes = list(j, :);
	A_lower = U' * A;
	A_epsilon = A(:, indexes);
	var((A_epsilon'*A)');
	sum(var((A_epsilon'*A)'));

	display('Testing QR factorization')
	[Q, R] = qr(A_epsilon, '0');
	Q;
	var((Q'*A)');
	sum(var((Q'*A)'))

	%P = [0 1; 1 0];
	%[Q, R] = qr(A_epsilon * P, '0');
	%var((Q'*A)');
	%sum(var((Q'*A)'))
	
	%display('Testing two columns')
	v_star = 0;
	for i = 1:d
			W = A_lower(i, indexes(1));
			v_star = v_star + W.^2 * var(U(:, i)'* A);
	end

	for k = 2 : size(indexes, 2)	%for each one of the other samples
		norm_term = 0;
		temp = 0;
		for i = 1:d
			for l = 1 : k-1	%for all other samples preceeding sample indexes(k)
					g = A(:, indexes(k))' * A(:, indexes(l));
					W = A_lower(i, indexes(k)) - g * A_lower(i, indexes(l));
					norm_term = norm_term + W .^2;
					temp = temp + W.^2 * var(U(:, i)'* A);
			end
		end	
		temp = temp / norm_term;
		v_star = v_star + temp;
	end	
	v_star
	display('===========')
end
