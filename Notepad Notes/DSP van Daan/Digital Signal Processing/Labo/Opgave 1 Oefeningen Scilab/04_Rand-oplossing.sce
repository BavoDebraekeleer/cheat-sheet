// Daan Dekoning - Feb 13, 2022
// Labo 1 Oefening 4
// Random Signaal

clf;
clear;

t = [0:199];

//r=(rand(1,200,'uniform')/1)*4 // Random tussen 0 en 2
r=grand(1,200,"unf",0,4)

plot(t, r,'g')
[y, x] = min(r)
plot(x, y, '*r')

[y, x] = max(r)
plot(x, y, '*r')

// Bepalen van gemiddelde waarde van signaal
gemid = mean(r)
//disp (gemid, "gemiddelde waarde = ")
// Maken van rijvector met waarde van gemid
gemiddelde = gemid*(ones(t));
// Weergeven van gemiddelde waarde als een lijn op de grafiek in het groen
plot (t, [gemiddelde], 'b')

st = stdev(r) // Standaard deviatie bepalen
st_line = st * (ones(t)) // Lijn maken om deze stdev weer te geven
plot(t, st_line, 'r') // Lijn plotten
disp("Standaard deviatie=", st)
