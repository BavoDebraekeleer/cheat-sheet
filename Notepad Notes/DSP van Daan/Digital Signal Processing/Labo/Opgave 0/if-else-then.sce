// Scilab for very beginners 
D=grand(1,3,"uin",1,6);
if D==[6,6,6] then
    W=20;
elseif length(unique(D))==1 then
    W=10;
elseif length (unique(D))==2 then
    W=5;
else
    W=0;
end
disp("Alice wins "+..
string(W)+ " dollars")
