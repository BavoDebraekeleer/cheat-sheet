// Daan Dekoning - Feb 15, 2022
// Labo 2 Oefening 3
// Testsignaal met storingen

clf;
clear;

samp_f=16000;
samp_l=0.024;
t= 0 : 1/samp_f : samp_l; // 16kHz sample, 24ms

function [y]=sin_xHz(f, U, t)
    y = U * sin(2 * %pi * f * t) // xHz sinus, samplefrequentie afhankelijk van t en Umax afhankelijk van U
endfunction

sin_250Hz = sin_xHz(250, 2, t); // f=250Hz, Umax=2V
i=0; // Teller
// Iedere 6ms een storing toevoegen
while i<samp_l
    i=i+0.006; // Teller naar boven met 6ms
    sin_250Hz(samp_f * i)= -3; // Storing toevoegen
    sin_250Hz((samp_f * i)+1)= -3; // Storing2 toevoegen
end

subplot(3, 1, 1)
plot(t, sin_250Hz)
xtitle("f=250Hz, 2V")
xgrid(1)

sin_2500Hz = sin_xHz(2500, 0.5, t); // f=2500Hz, Umax=0.5V
i=0; // Teller
// Iedere 6ms een storing toevoegen
while i<samp_l
    i=i+0.006; // Teller naar boven met 6ms
    sin_2500Hz(samp_f * i)= -3; // Storing toevoegen
    sin_2500Hz((samp_f * i)+1)= -3; // Storing2 toevoegen
end

subplot(3, 1, 2)
plot(t, sin_2500Hz)
xtitle("f=2500Hz, 0.5V")
xgrid(1)

sin_7000Hz = sin_xHz(7000, 0.8, t); // f=7000Hz, Umax=0.8V
i=0; // Teller
// Iedere 6ms een storing toevoegen
while i<samp_l
    i=i+0.006; // Teller naar boven met 6ms
    sin_7000Hz(samp_f * i)= -3; // Storing toevoegen
    sin_7000Hz((samp_f * i)+1)= -3; // Storing2 toevoegen
end

subplot(3, 1, 3)
plot(t, sin_7000Hz)
xtitle("f=7000Hz, 0.8V")
xgrid(1)
