// Daan Dekoning - Feb 12, 2022
// Labo 1 oefening 1
// Sinc-functie

clf;
clear;

x = [-20:0.1:20];

function [y]=f(x)
    if x <> 0 then
        y=sin(x)/ x;
    else
        y = 1;
    end
endfunction

xtitle("Sinc-functie", "input", "uitkomst")
plot(x,f)
