// Daan Dekoning - Feb 13, 2022
// Labo 1 Oefening 3
// Analoge spanning

clf;
clear;


t = 0.0 : 0.000125 : 0.01; // 0.01 seconden signaal, fs=8kHz

sin_1Hz = 2*sin(2*%pi*400*t); // 2V amplitude 400Hz signaal

// DC spanning 2.5V
DC = 2.5;

// Het testsignaal bestaat uit de som van de 3 signalen
signal = DC + sin_1Hz;

function gemiddelde(t, sig)
    // Bepalen van gemiddelde waarde van signaal
    gemid = mean(sig)
    disp (gemid, "gemiddelde waarde = ")
    // Maken van rijvector met waarde van gemid
    gemiddelde = gemid*(ones(t));
    // Weergeven van gemiddelde waarde als een lijn op de grafiek in het groen
    plot (t, [gemiddelde], 'g')
endfunction

subplot(2, 1, 1)
kwantis = (signal/max(signal))*255;
xtitle("Visualisatie Samples", "Samplevolgnummer", "Kwantisatiewaarde Sample")
xgrid(1)
plot(t,kwantis); // (signaal / 4.5)*255
gemiddelde(t, kwantis)

subplot(2, 1, 2)
xtitle("Visualisatie Gekwantificeert Ingangssignaal", "Samplevolgnummer", "Spanningswaarde")
xgrid(1)
plot(t,signal);
gemiddelde(t, signal)

disp("Amplitude variatie= ", stdev(signal))
