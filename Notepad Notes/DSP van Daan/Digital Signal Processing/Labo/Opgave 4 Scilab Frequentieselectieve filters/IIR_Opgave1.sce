// Daan Dekoning - Jun 1, 2022
// Labo 5 Oefening 1
// 

clf;
clear;
//sinus 4V amplitude
//frequentie 100Hz
//samplefreqientre 2kHz

t=0:1/2000:(1/100)*16

sin_100Hz=4*(sin(2*%pi*100*t))

blok_100Hz=4*squarewave(0.5*sin_100Hz)
subplot(211)
plot2d(t,sin_100Hz)
plot2d(t,blok_100Hz)

// IIR ontwerp: 5e orde, banddoorlaat, butterworth
// 0.245 = ( 1 / (frequentie * harmonische) ) - 0.05
// 0.255 = ( 1 / (frequentie * harmonische) ) + 0.05
BP_IIR=iir(5, 'bp', 'butt', [0.245 0.255], [0 0])
// Zichtbaar maken van tijdsdomeinresponse op, de LD-filter op het testsignaal

BP_resp = flts(blok_100Hz, BP_IIR)
subplot(212)
plot2d(t,BP_resp)
plot2d(t,blok_100Hz)
