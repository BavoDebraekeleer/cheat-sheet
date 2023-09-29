// Testsignaal van drie sinussen (1 Hz, 10 Hz, 30 Hz)

t = 0.0 : 0.01 : 5.0; // 5 seconden signaal

sin_1Hz = 3*sin(2*%pi*1*t);
sin_10Hz = 2*sin(2*%pi*10*t);
sin_30Hz = 2*sin(2*%pi*30*t);
// Het testsignaal bestaat uit de som van de 3 signalen
signal = sin_1Hz + sin_10Hz + sin_30Hz;
// Signaal weergeven
plot(t, signal);
