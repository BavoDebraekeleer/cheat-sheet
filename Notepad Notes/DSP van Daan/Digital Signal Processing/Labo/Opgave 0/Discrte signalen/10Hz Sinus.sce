// 10Hz sinusoidaal signaal
t=0:0.001:1.0; // 1 seconde sample
sin_10Hz=2*sin(2*%pi*10*t); // 2 * pi * f * t
plot(t, sin_10Hz)
