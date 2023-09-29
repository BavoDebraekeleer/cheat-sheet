// Daan Dekoning - Feb 22, 2022
// Labo 3 Oefening 1
// Moving average filter om ruis weg te filteren

clf;
clear;


//a.	Je creëert in scilab een sinussignaal met amplitude 3V en frequentie 100 Hz Je sampeld deze sinus met een frequentie van 8 kHz en slaat 3 perioden in samples op in een vector.
samp_f=8000; // 8kHz sample frequentie
samp_l=0.03; // 3 periodes van de sinus lang
t8kHz= [0 : 1/samp_f : samp_l]; // 16kHz sample, 24ms
sin_ampl=3; // 3V amplitude
sin_f=100; // 100Hz frequentie
sig100Hz = sin_ampl*sin(2*%pi*sin_f*t8kHz);

subplot(4, 1, 1)
plot(t8kHz, sig100Hz);

//b.	Je creëert in scilab een ruissignaal met een amplitude rond de 100 mV (pieken kunnen hogere waarden bekomen)  
sigRan=grand(1,(((1/100)*8000)*3)+1,"uin",0,220)-110
sigRan=sigRan/1000
subplot(512)
plot(t8kHz*1000,sigRan)
title("ruis")
//c.	Je voegt beide signalen samen en gebruikt dit als ingangssignaal voor de filter

siging=sigRan+sig100Hz

//d.	Je ontwerpt een moving average filter met 10 factoren 

// == 100 punten nemen

filter10=zeros(length(siging),1)
subplot(513)
plot(t8kHz*10000,siging)
title("100Hz + ruis") 

for i=10:length(siging) 
    filter10(i)= ... 
    0.1*siging(i-9)+... 
    0.1*siging(i-9)+... 
    0.1*siging(i-7)+... 
    0.1*siging(i-6)+... 
    0.1*siging(i-5)+... 
    0.1*siging(i-4)+... 
    0.1*siging(i-3)+... 
    0.1*siging(i-2)+... 
    0.1*siging(i-1)+... 
    0.1*siging(i)
end

// en een moving averagefilter met 5 factoren
filter5=zeros(length(siging),1)
subplot(513)
plot(t8kHz*10000,siging)

for i=5:length(siging) 
    filter5(i)= ... 
    0.2*siging(i-4)+... 
    0.2*siging(i-3)+... 
    0.2*siging(i-2)+... 
    0.2*siging(i-1)+... 
    0.2*siging(i)
end


//e.	Je filtert het samengevoegde signaal (sinus 100 Hz en ruis) met beide filters en geef het resultaat weer in 1 grafiek.  Links de resultaten van de filter met 10 factoren, rechts de resultaten van de filter met 5 factoren.  In een voorstelling zoals hieronder is weergegeven voor één filter: (volgorde : sinus, ruis, samengesteld signaal , gefilterd signaal



subplot(527)
plot(t8kHz*10000,filter10,'r')
title("factor 10")

subplot(528)
plot(t8kHz*10000,filter5,'g')
title("factor 5")












