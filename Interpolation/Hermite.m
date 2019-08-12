function  result=Hermite(x,y,m) 
syms K;
f1=y(1)/(x(1)-x(2))+y(2)/(x(2)-x(1));
f2=y(1)/((x(2)-x(1))*(x(3)-x(1)))+y(2)/((x(1)-x(2))*(x(3)-x(2)))+y(3)/...
    ((x(1)-x(3))*(x(2)-x(3)));
f3=m-f1-f2*(x(2)-x(1));
P=y(1)+f1*(K-x(1))+f2*(K-x(1))*(K-x(2))+f3/((x(2)-x(1))*(x(2)-x(3)))*(K-x(1))*...
    (K-x(2))*(K-x(3));
P1=diff(P);
P2=diff(P1);
P3=diff(P2);
if P3 == 0
     result=0;
else
        result1=solve(P2==0,K);
        result=result1;
end



