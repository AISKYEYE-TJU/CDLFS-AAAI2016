function  [V,U]=CDLFS(X,mu,tau,DictSize,p)

%% 
% The function is to sove the following optimization problem 
% min_{U,V} ||X-UV'X||_F^2+tau*||V||_{2,p}
% Input:
%X  feature matrix  d*n  d is feature dimension  n is sample number 
%mu parameter  default value 1 
%tau parameter 
%DictSize  dictionary size default value 10
%p   L2p-norm regularization  default value {0.4,0.6,0.8,1.0}

% Output:
%V analysis dictionary    d*k
%U synthetic dictionary   d*k


% reference: 
% [1]Zhu P, Hu Q, Zhang C, et al. Coupled Dictionary Learning for Unsupervised Feature Selection[C]//Thirtieth AAAI Conference on Artificial Intelligence. 2016.

%%
% Initilize U , V and A
iternum=50;
mu = 1;  % we set mu =1 ,in our experiment.

[U,V,A] = Initilization( X, DictSize, tau );

for i=1:iternum
%  Alternatively update V, U and A
   V = UpdateV_p(A, X, tau, mu,p);       %update V
   U = UpdateD(A, X, U);                 %update U
   A = UpdateA(U, X, V, mu, DictSize );  %update A
   E1=X-U*A;
   E2=A-V'*X;
   vc = (sum(V.*V,2)).^(1-p/2);
   error(i)=sum(sum(E1.*E1))+mu*sum(sum(E2.*E2))+tau*sum(vc.^(p/(2-p)));
   
   if i>1 && (error(i-1)-error(i))/error(i-1)<1e-6
    break;
   end
end

