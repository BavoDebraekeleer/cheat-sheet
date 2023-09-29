// Daan Dekoning - Jun 7, 2022
// Examen Oefening 2
// 

clf;
clear;

sample_f = 8000;
t = [0 : 1/sample_f : 0.05]; 
// Genormaliseerde afsnij frequentie 1500Hz / 8kHz = 0.1875
FC=0.1875
M=108

// Laagdoorlaatfilter opstellen
HD=zeros(2:M+1)
for i = 1:M
    HD(i)=HD(i)+1*(0.54-0.46*cos(2*%pi*i/M));
    disp(HD(i)+1*(0.54-0.46*cos(2*%pi*i/M)));
end
disp(HD)
// Inverteren naar een Hoogdoorlaatfilter
for i=1:M
    HD(i)=HD(i)-1
    HD(i)=-HD(i)
end

// Middelste put +1
HD(M/2+1)=HD(M/2+1)+1

disp(HD)


function [y]=sin_xHz(f, U, t)
    y = U * sin(2 * %pi * f * t) // xHz sinus, samplefrequentie afhankelijk van t en Umax afhankelijk van U
endfunction

f2kHz=sin_xHz(2000, 2, t)
f800Hz=sin_xHz(800, 4, t)
testsignaal=f2kHz+f800Hz

output=zeros(1:length(t))
for i=M+2:length(t)
    for j=1:M
        output(i)=output(i)+testsignaal(i-j)*HD(j)
    end
end


subplot(211)
title("Testsignaal")
xlabel("Sample")
ylabel("Amplitude")
plot(t,testsignaal, 'k')


subplot(212)
title("filteroutput")
xlabel("Sample")
ylabel("Amplitude")
plot(t,output, 'r')
