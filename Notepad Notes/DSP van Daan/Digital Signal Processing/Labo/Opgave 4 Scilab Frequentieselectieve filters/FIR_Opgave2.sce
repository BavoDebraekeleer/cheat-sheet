// Daan Dekoning - Jun 4, 2022
// Labo 4 Oefening 2
// wfir

clf;
clear;

t=0:1/1000:0.5

// signalen 25Hz (2V), 42Hz (4V)
testsig1=(2*sin(2*%pi*25*t))+(4*sin(2*%pi*42*t))

// signalen 42Hz (2V), 130Hz (4V)
testsig2=(4*sin(2*%pi*42*t))+(1*sin(2*%pi*130*t))

// signalen 25Hz (2V), 42Hz (4V), 65Hz (4V), 125Hz (2V)
testsig3=(2*sin(2*%pi*25*t))+(4*sin(2*%pi*42*t))+(4*sin(2*%pi*65*t))+(2*sin(2*%pi*125*t))

[coeffi, amp, frequ]=wfir('sb', 141, [0.035 0.075], 're', [0 0])
SB_poly = poly(coeffi, 'z', 'coeff');
SB_functie=horner(SB_poly, 1/%z);
SB_sys=syslin('d',SB_functie);
SB_out1 = flts(testsig1, SB_sys)
SB_out2 = flts(testsig2, SB_sys)
SB_out3 = flts(testsig3, SB_sys)

// zwart  -> testsignaal
// rood   -> filter signaal
// groen  -> berekend signaal

subplot(311)
title("testsignaal1 (25Hz, 42Hz)")
ylabel("spanning (V)")
xlabel("tijd (ms)")
plot2d(t*1000,testsig1)
plot2d(t*1000,SB_out1,style=[color("red")])
plot2d(t*1000,2*sin(2*%pi*25*t),style=[color("green")])
legend(["testsignaal 1","filter signaal","berekend signaal"])
subplot(312)
title("testsignaal 2 (42Hz, 120Hz)")
ylabel("spanning (V)")
xlabel("tijd (ms)")

plot2d(t*1000, testsig2)
plot2d(t*1000, SB_out2,style=[color("red")])
plot2d(t*1000, 1*sin(2*%pi*130*t),style=[color("green")])
legend(["testsignaal 1","filter signaal", "berekend signaal"])
subplot(313)
title("testsignaal 3 (25Hz, 42Hz, 65Hz, 125Hz)")
ylabel("spanning (V)")
xlabel("tijd (ms )")
plot2d(t*1000, testsig3)
plot2d(t*1000, SB_out3,style=[color("red")])
plot2d(t*1000, (2*sin(2*%pi*25*t))+(2*sin(2*%pi*125*t)),style=[color("green")])
legend(["testsignaal 1","filter signaal", "berekend signaal"])


//c)
scf(1)
clf

N=size(t,"*")
freq_FFT=abs(fft(testsig3))
f=1000*(0:(N/2))/N
n=size(f,"*")
title("frequentie response+ filer response")
xlabel("frequentie (Hz)")
ylabel("vermogen mV")
plot(f,freq_FFT(1:n))
plot(frequ*1000,amp*N,'r')
legend(["testsignaal 3 frequentie response" ,"filter response"])
