// 10Hz sinusoidaal signaal
t=0:0.001:1.0; // 1 seconde sample
sin_10Hz=2*sin(2*%pi*10*t); // 2 * pi * f * t

plot(t, sin_10Hz, 'r')

// Verticaal verplaatsen
plot(t, sin_10Hz + 2, 'Ok-.')

// Horizontaal verplaatsen
plot(t + 0.125, sin_10Hz, 'm')
