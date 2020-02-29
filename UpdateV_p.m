function V = UpdateV_p(A, X, tau,mu,p)

iternum=30;
[d,n]=size(X);
G=eye(d);
for i=1:iternum 
  if d<n
    V=(G*X*X'*2+mu\tau*eye(d))\(2*G*X*A');
    vc = (sum(V.*V,2)).^(1-p/2);
    Gv = (2/p)*vc;
    G = spdiags(Gv,0,d,d);
  else
    V=G*X*((X'*G*X*2+mu\tau*eye(n))\(2*A'));
    vc = (sum(V.*V,2)).^(1-p/2);
    Gv = (2/p)*vc;
    G = spdiags(Gv,0,d,d);
  end  
  E=A-V'*X;
  error(i)=sum(sum(E.*E))+mu\tau*sum(vc);
  
  if i>1 && (error(i-1)-error(i))/error(i-1)<1e-6
    break;
  end
end
    

