// Daan Dekoning - Feb 15, 2022
// Labo 2 Oefening 1
// Pulstrein

clf;
clear;


t = 0.0 : 0.000025 : 0.001*4;

f=1000
Umax=5
w=2*%pi*f*t

dc=0.25 //duty-cycle
harm=((sin(1*%pi*dc))/(1*%pi*dc))*cos(1*w)+..
    ((sin(2*%pi*dc))/(2*%pi*dc))*cos(2*w)+..
    ((sin(3*%pi*dc))/(3*%pi*dc))*cos(3*w)+..
    ((sin(4*%pi*dc))/(4*%pi*dc))*cos(4*w)+..
    ((sin(5*%pi*dc))/(5*%pi*dc))*cos(5*w)+..
    ((sin(6*%pi*dc))/(6*%pi*dc))*cos(6*w)+..
    ((sin(7*%pi*dc))/(7*%pi*dc))*cos(7*w)
    
y=(Umax*dc+2*Umax*dc*harm)

subplot(221)
plot(t,y)
