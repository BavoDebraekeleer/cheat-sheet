// Daan Dekoning - Feb 22, 2022
// Labo 3 Oefening 1
// Moving average filter om ruis weg te filteren

clf;
clear;

dc=0.50
t=0.0:(1/8000):(1/100)*3
f=100
Umax=5
w=2*%pi*f*t
harm = 0
for i=1:200
    harm=harm+((sin(i*%pi*dc))/(i*%pi*dc))*cos(i*w)
end
y=(Umax*dc+2*Umax*dc*harm)
subplot(211)
plot(t,y)

filter10=zeros(length(y),1)
for i=10:length(y) 
    filter10(i)= ... 
    0.1*y(i-9)+... 
    0.1*y(i-9)+... 
    0.1*y(i-7)+... 
    0.1*y(i-6)+... 
    0.1*y(i-5)+... 
    0.1*y(i-4)+... 
    0.1*y(i-3)+... 
    0.1*y(i-2)+... 
    0.1*y(i-1)+... 
    0.1*y(i)
end

filter5=zeros(length(y),1)
for i=5:length(y) 
    filter5(i)= ... 
    0.2*y(i-4)+... 
    0.2*y(i-3)+... 
    0.2*y(i-2)+... 
    0.2*y(i-1)+... 
    0.2*y(i)
end

subplot(212)
plot2d(t*10000,[filter10 filter5],[1,2],leg="factor10@factor5")

scf(2)

param=[1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10]
transp10=poly(param,'z','coeff')
transh10=horner(transp10,(1/%z))
transsys10=syslin('d',transh10)

param=[1/5,1/5,1/5,1/5,1/5]
transp5=poly(param,'z','coeff')
transh5=horner(transp5,(1/%z))
transsys5=syslin('d',transh5)

bode([transsys10;transsys5],["10";"5"])
