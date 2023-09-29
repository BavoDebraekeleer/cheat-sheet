// Quantistie sinus 10Vpp en 1kHz over 1 periode met fs=100 kHz
t = (0.0 : 0.00001 : 0.001);
quantisatie = 512 + 512 * sin(2*%pi*1000*t);
// graphic window onderverdeeld in twee gebieden
subplot(2, 1, 1)
// Labels voor de assen en titel
a = get("current_axes");
a.title
a.title.font_size = 4
type(a.title)
a.x_label
a.y_label
xtitle("Quantisatie", "periode", "quantisatie-waarde")
plot(t, quantisatie)
subplot(2, 1, 2)

// Labels voor de assen en titel
b = get("current_axes");
b.title
b.title.font_size = 4
type(b.title)
b.x_label
b.y_label
xtitle("Spanning", "periode", "Volt")
// Aanpassing quantisatie naar spanning (bereik 10V over quantisatiebereik 1024)
plot(t, quantisatie * 10/1024)
