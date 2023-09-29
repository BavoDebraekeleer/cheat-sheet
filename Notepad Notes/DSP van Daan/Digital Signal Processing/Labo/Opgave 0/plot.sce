// Scilab for very beginners 
function y=g(x)
    y=sin(x/2)
endfunction
x=linspace(-2,5,50);
clf
plot(x,f,"r",x,g,"g")
