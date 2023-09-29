// Daan Dekoning - Feb 12, 2022
// Labo 1 Oefening 2
// Tweedegraadsvergelijking oplossen

// y=ax^2+bx+c

clf;
clear;


function vergelijking(a,b,c);
    x=-50:50
    
    if x == 0 then
        y=1
    else
        y=a*(x^2)+b*x+c
    end
    
    D=(b^2)-4.*a.*c;
    
    disp("D= " + string(D))
    if a == 0 then
        disp("Delen door 0 gaat niet. Eerste graad getekend")
    else
        if D > 0 then
            punt1=(-b-sqrt(D))./(2*a)
            punt2=(-b+sqrt(D))./(2*a)
            disp("punt1= " + string(punt1))
            disp("punt2= " + string(punt2))
        elseif D == 0 then
            punt=(b^2)./(2.*a)
            disp("punt= " + string(punt))
        else
            diep("geen snijpunten")
        end
    end
    
    plot(x,y,"c")
endfunction

vergelijking(-8,80,80)
