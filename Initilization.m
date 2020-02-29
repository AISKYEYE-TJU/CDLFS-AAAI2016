function [U,V,A] = Initilization( X, DictSize, tau )
% In this intilization function, we do the following things:
% 1. Random initialization of dictioanry pair D and P for each class
% 2. Precompute the class-specific inverse matrix used in Eq. (10)
% 3. Compute matrix class-specific code matrix A by Eq. (8) 
%    with the random initilized D and P
%
% The randn seeds are setted to make sure the results in our paper are
% reproduceable. The randn seed setting can be removed, our algorithm is 
% not sensitive to the initilization of D and P. In most cases, different 
% initilization will lead to the same recognition accuracy on a wide randge
% of testing databases.



Dim      = size(X,1);
randn('seed',1);                        
U    = normcol_equal(randn(Dim, DictSize));    %dictionary initialization
randn('seed',2);
V      = normcol_equal(randn(Dim, DictSize));   %Projection initialization
 
A = UpdateA(U, X, V,  tau, DictSize  );

