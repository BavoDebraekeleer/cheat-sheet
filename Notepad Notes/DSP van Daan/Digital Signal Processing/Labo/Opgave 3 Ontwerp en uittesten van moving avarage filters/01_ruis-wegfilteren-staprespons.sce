// Daan Dekoning - Feb 22, 2022
// Labo 3 Oefening 1
// Moving average filter om ruis weg te filteren

clf;
clear;

// f.	Van beide filters maak je de stapresponse zicht baar in 1 grafiek, tezamen met de stap.  Creeer een aantal stappen met een gemaakte blokstpanning van 100 Hz.  

// zeros() en ones() geburiken
Sample_f_Hz = 15
t = (0:1/Sample_f_Hz:2*%pi)';
squ_100Hz = 0.9*squarewave(t);
subplot(3, 1, 1);


//b.	Je creëert in scilab een ruissignaal met een amplitude rond de 100 mV (pieken kunnen hogere waarden bekomen)  
r=(rand(length(t),1,'normal'))*0.075 // Random rond 100mv

ruis_squ = squ_100Hz + r;
plot(t, ruis_squ);
xtitle("Signaal met ruis");

//      d.	Je ontwerpt een moving average filter met 10 factoren 
filter_10f_output = zeros(length(t),1);
FACTOREN = 10
for i=FACTOREN+1:length(t)
    j=0;
    while j<=FACTOREN
       // disp(i-j)
        filter_10f_output(i)=filter_10f_output(i) + (1/FACTOREN)*ruis_squ(i-j);
        j=j+1;
    end
end

subplot(3, 1, 2);
plot(t, filter_10f_output);
xtitle("10 factor filter");

//      en een moving averagefilter met 5 factoren
filter_5f_output = zeros(length(t),1);
FACTOREN = 5
for i=FACTOREN+1:length(t)
    j=0;
    while j<=FACTOREN
       // disp(i-j)
        filter_5f_output(i)=filter_5f_output(i) + (1/FACTOREN)*ruis_squ(i-j);
        j=j+1;
    end
end

subplot(3, 1, 3);
plot(t, filter_5f_output);
xtitle("5 factor filter");

// Vraag: welk van beide filters heeft de beste stapresponse en hoe zie je dat?


// g.	Geef van beide filters het bodedigram weer in één grafiek met legende.
// Vraag: welk van beide filters verdient jouw voorkeur en waarom?

