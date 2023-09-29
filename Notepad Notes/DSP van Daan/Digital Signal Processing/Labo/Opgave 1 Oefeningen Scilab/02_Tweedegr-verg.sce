// Daan Dekoning - Feb 12, 2022
// Labo 1 Oefening 2
// Tweedegraadsvergelijking oplossen

// y=ax^2+bx+c

clf;
clear;

x = [-8:0.1:5];

function [y]=f(x)
    a=1;
    b=3;
    c=-2;
    if a == 0 & b == 0 & c == 0 & x == 0 then
        disp("Opgelet, deling door 0")
        y=0;
    else
        y= (a * x)^2 + (b * x) + c;
    end
    D = b^2 - 4 * a * c;
    if D > 0 then
        n1 = (-b-sqrt(D))/2;
        n2 = (-b+sqrt(D))/2;
        plot(n1, 0, '.r');
        plot(n2, 0, '.r')
    end
    
endfunction

//disp(f(1,3,7,5))
xtitle("Tweedegraads-functie", "x-as", "y-as")
plot(x,f)
xgrid(2)
