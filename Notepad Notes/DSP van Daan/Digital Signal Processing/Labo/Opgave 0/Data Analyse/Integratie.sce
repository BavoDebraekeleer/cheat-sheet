// Creeren van sinus en weergeven in graphic window
t = 0.0:0.005:0.1
si = sin(2*%pi*10*t)
subplot(1, 2, 1)
plot(t, si)
// Bepalen van integraal van de sinus
integraal = sum(si)
disp('Integraal van sindus is gelijk aan', integraal, 'Wat zo goed als nu is')
// Bepalen absolute oppervlakte sinus
subplot(1, 2, 2)
plot(t, abs(si))
absintegraal = sum(abs(si))
disp('de absolute integraal van de sundus is gelijk aan', absintegraal)


