function A = UpdateA(U, X, V, mu, DictSize )
% Update A 

I    = eye(DictSize,DictSize);
A    = (U'*U+mu*I)\(U'*X+mu*V'*X);  




