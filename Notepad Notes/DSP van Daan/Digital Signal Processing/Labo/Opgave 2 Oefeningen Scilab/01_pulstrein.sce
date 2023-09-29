// Daan Dekoning - Feb 15, 2022
// Labo 2 Oefening 1
// Pulstrein

clf;
clear;
t = 0.0 : 0.00001 : 0.01;

function [u]=pulstrein(duty_c, t)
    Umax=12 // 12V Umax
    tao=duty_c // Tao is de duty-cycle (0.25 = 25%, ...)
    T=1 // 1 periode
    f=1000 // Frequentie 1 kHz
    
    tussenR = Umax * (tao/T) + 2 * Umax * (tao/T) // Tussenresultaat van begin van de vergelijking
    i=0; // Teller
    l=0; // Tweede tussenresultaat
    while i<7
        i=i+1; // Teller naar boven
        l=l+(sin(i * %pi * ((tao/T)))/(i * %pi * tao * T)) * cos(i * 2 * %pi * f * t) // Optellen bij tussenresultaat
    end
    u=tussenR * l; // Tussenresultaten vermenigvuldigen
endfunction


subplot(2, 1, 1)
plot(t, pulstrein(0.25))
xtitle("1kHz 25% duty-cycle")
xgrid(1)

subplot(2, 1, 2)
plot(t, pulstrein(0.75))
xtitle("1kHz 75% duty-cycle")
xgrid(1)
