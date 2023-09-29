// Scilab for very beginners 
// Calculation of 10 terms
u(1)=1
for n=1:10
    u(n+1)=2*u(n)-3
    disp([n,u(n)])
end
