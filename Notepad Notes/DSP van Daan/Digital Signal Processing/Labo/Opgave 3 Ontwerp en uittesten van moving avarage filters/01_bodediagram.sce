// Daan Dekoning - Mar 22, 2022
// Labo 3 Oefening 1
// 

clf;
clear;

// Bodediagram van moving average filter
// filter y=
// Opgave parameters van filter
parameter = [1/5 1/5 1/5 1/5 1/5]
// Bepalen van polynoom
transferp = poly(parameter, 'z', 'coeff')
// Omvormen transfer poly in z via horner() naar 1/z
transferh = horner(transferp, (1/%z))
transfersys1 = syslin('d', transferh)


// Bodediagram van moving average filter
// filter y=
// Opgave parameters van filter
parameter = [1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10]
// Bepalen van polynoom
transferp = poly(parameter, 'z', 'coeff')
// Omvormen transfer poly in z via horner() naar 1/z
transferh = horner(transferp, (1/%z))
transfersys2 = syslin('d', transferh)

bode([transfersys1; transfersys2],['Parameters 1/5  0.2 0.2 0.2 0.2 0.2'; 'Parameters 1/10  0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1'])
xtitle("Bodediagram")
