// Testsignaal van drie sinussen (1 Hz, 10 Hz, 30 Hz)

t = 0.0 : 0.01 : 5.0; // 5 seconden signaal, fs=100Hz

sin_1Hz = 3*sin(2*%pi*1*t);
sin_10Hz = 2*sin(2*%pi*10*t);
sin_30Hz = 1*sin(2*%pi*30*t);

// DC spanning 5V
DC = 5;

// Het testsignaal bestaat uit de som van de 3 signalen
signal = DC + sin_1Hz + sin_10Hz + sin_30Hz;

// Storing toevoege op signaal bij tijd = 100 * 0.01s
// Amplitude is 10
signal(100)=10;

// Signaal weergeven
plot(t, signal);
