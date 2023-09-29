// Daan Dekoning - Jun 1, 2022
// Labo x Oefening n
// Stel een 8ste orde butterworth digitale bandfilter met afsnijfrequenties
// 50 Hz en150Hz; de samplefrequentie =1 kHz

clf;
clear;

// 8ste orde butterworth banddoorlaat 50-150 Hz fs=1kHz
BD_IIR_FILTER = iir(8,'bp','butt',[0.05 0.15],[0 0])
// Frequentierepsonse bepalen
// Binnen het genormaliseerde frequentiebereik zijn er 256 frequentiewaarden waarvan de magnitude wordt bepaald
[hm, fr]=frmag(BD_IIR_FILTER,256);
// Visualiseer frequentierepsonse
plot(fr,hm)
