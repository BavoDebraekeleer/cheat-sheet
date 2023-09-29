// Daan Dekoning - May 10, 2022
// Labo 8 Oefening 1
// Decoderen via matrices

clf;
clear;

// Versleutelde waardes
waarde1 = [[17; 24], [16; 22], [38; 36], [29; 28]]; 
waarde2 = [[54; 23], [90; 29], [44; 21], [90; 27], [150; 51]];

// Bijhorende sleutels VOOR invertie
sleutel1 = [1, 0;
           1, 2];
           
sleutel2 = [4, 1;
           2, 1];


function [zin]=decodeer(sleutel, cryp)
    // Deze functie inverteert de sleutel en decodeert de geencrypteerde waarde
    dict = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '=']; // Alle karakters te vinden via hun index
    
    antw = cryp; // Antwooord wordt in loop overschreven
    for i=1:length(cryp(1,:))
        x = [cryp(1,i), cryp(2,i)] * inv(sleutel); // Eerste twee waardes van matrix vermenigvuldigen met geinverteerde sleutel
        antw(1,i) = x(1); // Waardes in antwoord-variabele overschrijven
        antw(2,i) = x(2);
    end

    disp("Ontcijfering:", antw); // Ontcijferde integers tonen
    
    chars = string(antw); // chars wordt in loop overschreven, antw wordt gecast naar strings voor het juiste datatype
    for i=1:length(cryp(1,:))
        chars(1,i) = dict(antw(1,i)); // Vindt het juiste karakter bij het gedecodeerde cijfer
        chars(2,i) = dict(antw(2,i));
    end

    disp("Vertaling:", chars); // Print de karakters in hun matrix
    disp("Verborgen woord:", strcat(chars)) // Print de karakters in één string

    zin= strcat(chars) // Retrourneer de string
endfunction

decodeer(sleutel1, waarde1);

decodeer(sleutel2, waarde2);


