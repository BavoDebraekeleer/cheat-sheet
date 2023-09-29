// Daan Dekoning - Feb 17, 2022
// Labo 2 Oefening 4
// WAV audio-file weergeven

clf;
clear;

[y, f, bit]=wavread('C:\Users\Daan Dekoning\Documents\Vakken\Digital Signal Processing\Labo\Opgave 2 Oefeningen Scilab\buy_two.wav');

t = [1:1:length(y)]*(1/f);

plot(t,y)
sound(y, f/2, bit)
