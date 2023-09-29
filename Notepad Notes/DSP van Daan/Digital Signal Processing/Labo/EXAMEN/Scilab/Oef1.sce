// Daan Dekoning - Jun 7, 2022
// Examen Oefening 1
// 

clf;
clear;


sample_f = 8000;
t = [0 : 1/sample_f : 0.05]; 

function [y]=sin_xHz(f, U, t)
    y = U * sin(2 * %pi * f * t) // xHz sinus, samplefrequentie afhankelijk van t en Umax afhankelijk van U
endfunction


f200Hz=sin_xHz(200, 1, t)
f700Hz=sin_xHz(700, 1, t)
f900Hz=sin_xHz(900, 1, t)
f2000Hz=sin_xHz(2000, 1, t)
testsignaal = f200Hz+f700Hz+f900Hz+f2000Hz; 

// fcl = 500Hz / 8000 = 0.0625
// fch = 800Hz / 8000 = 0.1
// 500-400 = 100Hz
// M=(4/(100/8000)) + 1 = 321
[coeffi, amp, frequ] = wfir('bp', 321, [0.0625 0.1], 'kr', [0 0]);
BD_poly = poly(coeffi, 'z', 'coeff');
BD_functie=horner(BD_poly, 1/%z);
BD_sys=syslin('d',BD_functie);
BD_out = flts(testsignaal, BD_sys)


scf(0)
clf

subplot(411)

title("Testsignaal")
xlabel("Sample")
ylabel("Amplitude")
plot2d(t, testsignaal, style= [color("red")])


subplot(412)

title("Te recupereren signaal")
xlabel("Sample")
ylabel("Amplitude")
plot2d(t, f700Hz, style= [color("black")])


subplot(413)

title("filteroutput")
xlabel("Sample")
ylabel("Amplitude")
plot2d(t, BD_out, style=[color("blue")])

subplot(414)

title("Allen tesamen")
xlabel("Sample")
ylabel("Amplitude")
plot2d(t, testsignaal, style= [color("red")])
plot2d(t, f700Hz, style= [color("black")])
plot2d(t, BD_out, style=[color("blue")])
legend(["Testsignaal" ,"Te filteren signaal", "Filteroutput"])


scf(1)
clf


N=size(t,"*")
freq_FFT=abs(fft(testsignaal))
f=8000*(0:(N/2))/N
n=size(f,"*")
title("Frequentie response + filer response")
xlabel("Frequentie (Hz)")
ylabel("Vermogen mV")
plot(f,freq_FFT(1:n))
plot(frequ*8000,amp*N,'r')
legend(["Testsignaal frequentie response" ,"Filter response"])



