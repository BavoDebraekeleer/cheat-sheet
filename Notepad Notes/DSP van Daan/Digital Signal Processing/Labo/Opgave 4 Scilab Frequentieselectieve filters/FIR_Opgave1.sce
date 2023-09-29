// Daan Dekoning - Jun 4, 2022
// Labo x Oefening n
// 

clf;
clear;

subplot(211)

// 16 kHz Samplefrequentie:
t = [0 : 6.25D-5 : 5D-3];
sin1kHz = 4 * sin(2 * %pi * 1000 * t)
stap = 4 * squarewave(0.5 * sin1kHz)
plot2d(t, sin1kHz)
plot2d(t, stap, style= [color("red")])
// 6.SkH7. / 16 kH7. = 0.40625
// 7kHz / 16 kHz= 0.4375
// 7.5kHz / 16 kHz= 0.46875
BD = wfir('bp', 50, [0.41 0.47], 'hm', [0 0]);

BD = poly(BD, 'z', 'coeff');
BD = horner(BD, (1/ %z));
BD = syslin('d',BD);

BD = 4 * flts(stap, BD)
plot2d(t, BD, style=[color("blue")])

subplot(212)

// 32 kHz Samplefrequentie:
t = [0 : 3.125D-5 : 5D-3];
sin1kHz = 4 * sin(2 * %pi * 1000 * t)
stap = 4 * squarewave(0.5 * sin1kHz)
plot2d(t, sin1kHz)
plot2d(t, stap, style=[ color("red")])

// 6.5kHZ / 32kHz = 0.2031215
// 7kHz / 32 kHz= 0.21875
// 7.5kHz / 32 kHz= 0.234375
BD = wfir('bp', 50, [0.200 0.235], 'hm', [0 0]);

BD = poly(BD, 'z', 'coeff');
BD = horner(BD, (1 / %z));
BD = syslin('d', BD);

BD = 4 * flts(stap, BD)
plot2d (t, BD, style= [ color("blue")])
