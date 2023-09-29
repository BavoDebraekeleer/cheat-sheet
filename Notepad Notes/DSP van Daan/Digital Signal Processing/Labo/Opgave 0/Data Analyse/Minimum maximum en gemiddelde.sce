// Genereren van een random signaal met uniforme verdeling ipv 'normal'
// Normaal random opgewekt tussen 0 en 1 => -0.5 waardentussen 0.5 en -0.5
signal = rand(1, 100, 'uniform')-0.5;
plot(signal)
// Bepalen van maximum en en coordinaat weergeven in console
[y, x] = max(signal)
disp ('Coordinaat maximum waarde: ')
disp (x, 'x-as = ')
disp (y, 'y-as = ')
// Weergeven van maximum op grafiek met asterix in rood
plot(x, y, '*r')
// Bepalen van minimum en coordinaar weergeven in console
[b, a] = min(signal);
disp ('coordinaat minimum waarde: ')
disp (a, 'x-as = ')
disp (b, 'y-as = ')
// Weergeven van maximum op grafiek met asterix in rood
plot(a, b, '*r')
// Bepalen van gemiddelde waarde van signaal
gemid = mean(signal)
disp (gemid, "gemiddelde waarde = ")
// Maken van rijvector met 100x waarde van gemid
gemiddelde = gemid*(ones(100,1));
// Weergeven van gemiddelde waarde als een lijn op de grafiek in het groen
plot ([1:1:100], [gemiddelde], 'g.')


