// Verdelen van het graphic window in 6 gebieden
// 2 kolommen en 3 rijen per kolom
// Maken van grafiek x^2 in linkergebied
subplot(3, 2, 1)
plot(([1:1:100].*[1:1:100]))
// Maken van gragfiek afgeleide van x^2 in linker middengebied (D(x^2) = 2x)
subplot(3, 2, 3)
plot(diff(([1:1:100].*[1:1:100])))
// D(2x) = 2 in graifiek linksonder graphic window
subplot(3, 2, 5)
plot(diff(diff(([1:1:100].*[1:1:100]))))
// plot sindus rechterbovenhoek
subplot(3, 2, 2)
s = sin(2*%pi*10*[0:0.005:0.1])
plot(s)
// Afgeleide van de sinus (=cos) rechter middenvlak
subplot(3, 2, 4)
plot (diff(s))
// Afgeleide van cos => -sin (rechtsonder)
subplot(3, 2, 6)
plot(diff(diff(s)))
