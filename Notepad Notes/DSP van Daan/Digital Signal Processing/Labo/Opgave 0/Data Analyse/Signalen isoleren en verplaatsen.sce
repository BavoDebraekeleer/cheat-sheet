// 3 kHz signaal met fs = 10 kHz over 2 perioden
t = 0:0.00001:0.000668; // 1 seconde sample
signal_3kHz = 2 * sin(2*%pi*3000*t); // 2 * pi * f * t

plot(t, signal_3kHz);

// Kopieren van negatief halve periode
neg_period = signal_3kHz(19:1:34);
// Achteraan bijvoegen neg_period
signal = [signal_3kHz neg_period];
// Bepalen van de langte van vector signaal om tijd te bepalen
lengte = size(signal, "*");
// lengte-1 want tijd start op 0.0
// lengte-2 x 0.00001 voor juiste tijdseenheid
tijd = (0.0 : 0.00001 : (lengte-1)*0.00001);
plot(tijd, signal)

signal_cut = signal_3kHz(1:1:33); // Eerste 33 samples afnemen
t2 = (0.0 : 0.00001 : 0.00032);
plot(t2, signal_cut, 'r');
