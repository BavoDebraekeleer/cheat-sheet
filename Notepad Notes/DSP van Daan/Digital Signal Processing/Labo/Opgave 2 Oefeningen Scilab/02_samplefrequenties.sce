// Daan Dekoning - Feb 15, 2022
// Labo 2 Oefening 2
// Samplefrequenties

clf;
clear;

function [x]=t_xHz(f)
    x= 0 : 1/f : 0.028; // xHz samplefrequentie
endfunction

function [y]=sin_300Hz(t)
    y=sin(2 * %pi * 300 * t) // 300Hz sinus, samplefrequentie afhankelijk van de t
endfunction

// f=300Hz, samp=3000Hz
subplot(4, 1, 1)
plot(t_xHz(3000), sin_300Hz)
plot(t_xHz(3000), sin_300Hz, '.b')
xtitle("f=300Hz, samp=3000Hz")
xgrid(1)

// f=300Hz, samp=1500Hz
subplot(4, 1, 2)
plot(t_xHz(1500), sin_300Hz)
plot(t_xHz(1500), sin_300Hz, '.b')
xtitle("f=300Hz, samp=1500Hz")
xgrid(1)

// f=300Hz, samp=750Hz
subplot(4, 1, 3)
plot(t_xHz(750), sin_300Hz)
plot(t_xHz(750), sin_300Hz, '.b')
xtitle("f=300Hz, samp=750Hz")
xgrid(1)

// f=300Hz, samp=325Hz
subplot(4, 1, 4)
plot(t_xHz(325), sin_300Hz)
plot(t_xHz(325), sin_300Hz, '.b')
xtitle("f=300Hz, samp=325Hz")
xgrid(1)
