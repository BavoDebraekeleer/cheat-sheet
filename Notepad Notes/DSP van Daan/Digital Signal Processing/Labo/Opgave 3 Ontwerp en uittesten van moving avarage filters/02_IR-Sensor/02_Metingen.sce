// Daan Dekoning - Mar 24, 2022
// Labo 3 Oefening 2
// 

clf;
clear;




metingen = [5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,6 ,6 ,7 ,8 ,9 ,9 ,10 ,10 ,10 ,11 ,12 ,13 ,14 ,15 ,16 ,18 ,18 ,18 ,18 ,19 ,18 ,14 ,13 ,12 ,13 ,14 ,13 ,13 ,13 ,15 ,14 ,14 ,15 ,15 ,15 ,13 ,14 ,20 ,19 ,19 ,19 ,20 ,19 ,18 ,16 ,16 ,15 ,12 ,12 ,12 ,11 ,10 ,10 ,10 ,10 ,9 ,9 ,10 ,10 ,10 ,10 ,10 ,10 ,10 ,11 ,11 ,11 ,11 ,11 ,11 ,11 ,11 ,10 ,11 ,11 ,11 ,10 ,11 ,11 ,11 ,10 ,10 ,9 ,10 ,9 ,10 ,9 ,10 ,9 ,9 ,9 ,10 ,9 ,10 ,10 ,10 ,10 ,10 ,9 ,9 ,9 ,7 ,6 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,6 ,6 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,8 ,9 ,10 ,12 ,13 ,13 ,13 ,15 ,14 ,16 ,15 ,12 ,12 ,12 ,15 ,16 ,17 ,18 ,18 ,19 ,20 ,19 ,18 ,21 ,18 ,18 ,18 ,18 ,19 ,19 ,18 ,17 ,19 ,18 ,19 ,18 ,19 ,18 ,19 ,18 ,18 ,18 ,19 ,19 ,18 ,18 ,19 ,18 ,19 ,19 ,20 ,19 ,20 ,20 ,21 ,21 ,21 ,20 ,21 ,21 ,22 ,22 ,24 ,22 ,22 ,21 ,20 ,27 ,27 ,24 ,25 ,25 ,24 ,25 ,27 ,25 ,25 ,25 ,25 ,27 ,26 ,25 ,27 ,25 ,23 ,16 ,16 ,17 ,17 ,14 ,11 ,14 ,14 ,17 ,15 ,15 ,15 ,18 ,16 ,14 ,14 ,14 ,14 ,14 ,20 ,20 ,25 ,31 ,30 ,31 ,31 ,31 ,30 ,31 ,31 ,31 ,31 ,31 ,31 ,27 ,31 ,29 ,24 ,24 ,30 ,31 ,23 ,29 ,27 ,25 ,25 ,29 ,29 ,29 ,30 ,30 ,30 ,31 ,31 ,31 ,31 ,30 ,31 ,12 ,6 ,7 ,6 ,6 ,7 ,7 ,7 ,6 ,7 ,5 ,6 ,6 ,7 ,6 ,7 ,10 ,13 ,15 ,16 ,17 ,17 ,17 ,16 ,16 ,15 ,16 ,16 ,14 ,18 ,18 ,20 ,29 ,20 ,23 ,26 ,31 ,24 ,22 ,25 ,22 ,20 ,22 ,21 ,17 ,18 ,17 ,17 ,18 ,15 ,14 ,14 ,20 ,17 ,15 ,8 ,16 ,11 ,5 ,3 ,4 ,3 ,3 ,4 ,5 ,5 ,5 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,4 
]

plot(metingen)


gefilterd = metingen;
filter_5f_output = zeros(376,1);
FACTOREN = 5
for i=FACTOREN+1:376

        filter_5f_output(i)=(1/FACTOREN)*gefilterd(i-4)+(1/FACTOREN)*gefilterd(i-3)+(1/FACTOREN)*gefilterd(i-2)+(1/FACTOREN)*gefilterd(i-1)+(1/FACTOREN)*gefilterd(i-0);


end


plot(filter_5f_output, 'r');
//
