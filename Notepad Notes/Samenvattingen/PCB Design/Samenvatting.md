# Inleiding PCB Design

PCB design houd zich bezig met:
- Schema ontwikkelen
- PCB ontwerpen
- PCB bestukken
- Testen van de schakeling



## Overzicht componenten

Gebruikte componenten:
- Weerstanden
- Condensatoren
- Spoelen
- Diodes
- Transistoren
- Vermogencomponenten
- IC’s

### Through-hole komponenten .

- dit zijn de komponenten zoals we ze kennen vanuit de labo oefeningen
- De traditionele weerstanden en condensatoren en halfgeleiders die we in de top-layer plaatsen en in de bottom-layer solderen.

### De SMD komponenten.

- SMD: Surface Mount Device
- Deze komponenten zijn zeer klein in afmetingen
- kunnen aan beide kanten (top of bottom) worden geplaatst en gesoldeerde behuizingen

## Overzicht soldeertechnieken

Het verschil met lassen is dat solderen wordt uitgevoerd bij een relatief lage temperatuur, waarbij het materiaal van het werkstuk niet smelt. Hierdoor is het ook beter mogelijk metalen met een verschillende samenstelling met elkaar te verbinden. Bij lassen is de temperatuur zo hoog dat naast de lasdraad of laselektrode het metaal langs de lasnaad van het werkstuk zelf ook vloeibaar wordt.

- <u>Zachtsolderen</u>: op relatief lage temperatuur (< 450 °C), met als soldeermateriaal legeringen gebaseerd op tin, koper en zilver in wisselende samenstellingen.
- <u>Dompelsolderen</u>: het dompelen van de onderkant van een printplaat in een soldeerbad.
- <u>Golfsolderen</u>: als dompelsolderen, alleen wordt er een golfje soldeer met een pompje omhooggewerkt in het soldeerbad.
- <u>Hardsolderen</u>: (ofwel vlamsolderen): op hogere temperatuur (450 °C – 900 °C), met als soldeermateriaal legeringen gebaseerd op koper, zink en zilver.
- <u>Inductiesolderen</u>: de warmte wordt opgewekt in het voorwerp zelf door een spoel waarin een (hoogfrequent) ompolend magnetisch/elektrisch veld wordt opgewekt. Het te solderen object bevindt zich in de spoel.
- <u>Lasersolderen</u>: solderen met behulp van een laser bij relatief lage temperaturen (rond de 450 °C).

- <u>Ultrasoonsolderen</u>: het te solderen voorwerp wordt met ultrasoongolven verwarmd.
- <u>Oven- en hogetemperatuursolderen</u>: hard-, zacht- of hogetemperatuursolderen in een oven. Als dit onder vacuüm gebeurt heet dit vacuümsolderen.
- <u>Zoutbadsolderen</u>: solderen in een verhit zoutbad. Deze techniek wordt vooral toegepast bij aluminiumverbindingen maar kan ook bij messingsolderen van staal worden toegepast. Aluminium oxideert aan de lucht en kan daardoor alleen in vacuüm of in een vloeistof gesoldeerd worden.
- <u>Weerstandsolderen</u>: solderen met een koolstofstaaf, die op een stroomkring is aangesloten; de weerstand van de koolstofpunt zorgt voor de verwarming.
- <u>Plasma- of boogsoldeerlassen</u>: met een lasdraad lassen die een lager smeltpunt heeft dan de te solderen materialen; het te solderen/lassen materiaal smelt niet.
- <u>Glassolderen</u>: een techniek om porselein, glas of een keramisch materiaal aan elkaar te verbinden met behulp van glassoldeer.

De gebruikte soldeertechniek is afhankelijk van een aantal factoren:
- Productie:
	- Manueel (prototyping of herstel)
	- geautomatiseerd solderen (industriële productie)
- Soort componenten:
	- Through hole componenten
	- SMD componenten



## Vervaardigen PCB’s

Een Printed Circuit Board (PCB)
- Is een mechanische samenstelling bestaande uit verschillende lagen glasvezels met daarop geëtste of gefreesde koperbaan patronen
- Meest gebruikte materiaal noemt men FR4
- Glasvezel produkt ,meestal van groene kleur, niet of nauwelijks buigzaam, ook geschikt om zwaardere komponenten te dragen
- Wordt gebruikt om elektronische componenten erop te bevestigen via de soldeermethode
- Het eindproduct is een kant en klare elektronische schakeling .
- Wordt ook PWB ( Printed Wiring Board) of PBA (Printed Board Assembly) genoemd

### Methoden om printplaten te produceren

- Etsen
  - Op een basis PCB (glasvezelplaat bedekt met koper) wordt het overtollig koper weggeëtst.
- Frezen
  - Op een basis PCB (glasvezelplaat bedekt met koper) wordt het overtollig koper weggefreesd.

#### Stappen:

Etsen

1. Ontwerp schakeling
2. Belichten
3. Ontwikkelen

Frezen

1. Ontwerp schakeling
2. Omzetten van geberfiles in data voor frezen
3. Frezen met freesmachine

#### Ontwerp schakeling

- Zowel bij etstechniek als freestechniek
- Ontwerp een schema
- Teken dit in multisim
- Test de werking
- Voorzie elke component van een footprint
- Transfereer het schema naar ultiboard
- Plaats de componenten
- Route je print (via autorouting of manueel)
- Druk de layout af als masker bij het etsen of zet het om in gerber bestanden bij het frezen

#### Belichten

- Bij etstechniek
- Bevestig het masker op een basisplaat voorzien van fotolak
- De belichte fotolak verandert van structuur en kan verwijderd worden

#### Ontwikkelen

- Bij etstechniek
- Breng de belichte basisplaat gedurende een korte tijd in een ontwikkelbad
- De belichte fotolak wordt hierdoor verwijderd.
- Spoel de basisplaat af om restanten van de ontwikkelaar te verwijderen.

#### Etsen

- Breng de basisplaat in een etsbad
- Op de plaatsen waar het koper niet beschermd is door de fotolak, zal de etsvloeistof het koper verwijderen.
- Spoel de PCB grondig om restanten van de etsvloeistof te verwijderen.
- Verwijder de resterende fotolak
- Voorzien de PCB van een laklaag die de PCB beschermt tegen oxidatie.

#### Dataomzetting en frezen

- Bij freestechniek
- De data van de gerberfiles wordt door de software van de freesmachine omgezet in data voor het frezen.
- Aan de hand van de freesdata zal de software de freesamchine besturen en het overtollige koper verwijderen.



### Bestukken van PCB's

- PCB is klaar om de componenten te bevestigen
- Kan manueel of automatisch gebeuren.
- Manueel
	- Met soldeertin en soldeerbout
	- Met soldeerpasta en warme luchtstation
	- Met reflow-oven
- Automatisch
	- Met reflow-oven
	- Golfslag solderen
	- Dompelbad

#### Plaatsen van componenten

- Manueel: de componenten worden manueel op de PCB aangebracht.
- Automatisch: de componenten worden via een pick en placemachine op de PCB aangebracht.

#### Testen van de schakelingen

Via een aantal metingen worden de schakeling getest op de correcte werking.





# Ontwerpregels Hoogfrequent Hobby Elektronica

## PCB Specificatie

rekening houden met:

- Print maatvoering
- Positie van connectoren (buitenkant PCB)
- Signalering 
- Montagegaten (in de hoeken, massavlak)
- Grote componenten
- Koeling van vermogens transistoren, etc... (koelingpad / heatsink)
- Voeding/schakel spanningen/stromen
- Impedantie van HF-sporen
- etc...



# Richtlijnen ontwerp PCB's

Goedkope PCB's:

- Gebruik van multilayer wordt afgeraden
- Spoorbreedte ≥ 10 mil (0,254 mm)
- Clearance ≥ 8 mil (0,203 mm)
- Via ≥ 0,6 mm (23,6 mil)
- Annular ring ≥ 6 mil (0,152 mm)



# Fusion 360 Tutorial

## Routing tips

- Indien een baan van richting verandert, tracht dan de (binnen)hoek steeds groter dan 90° te houden. Gebruik liever twee opeenvolgende hoeken van 45° in plaats van één hoek van 90°. Gebruik liever aftakkingen in de vorm van een "T" in plaats van een "Y".
- Om de verbindingen te kunnen leggen, mag je uiteraard gebruik maken van de ruimte onder de componenten (IC's, weerstanden, ...). Dit is overduidelijk voor de soldeer-zijde, maar het kan ook aan de componentzijde gebeuren.

- Zorg dat je alle afmetingen van de behuizingen en de aansluitpennen kent (databoeken) of kan nameten (schuifmaat, ...).
- Indien er meerdere gelijkaardige gepolariseerde  componenten (elco's, diodes, maar ook IC's, ...) op het bord komen, zorg dan dat deze steeds in dezelfde richting geplaatst zijn.
- De boordiameter van een gat moet minstens 10 mil groter zijn dan de aansluitdraad van de component die erdoor moet.
- Het soldeereiland (pad) moet minstens 15 mil groter zijn dan het geboorde gat.
- Plaats naam en revisie-nummer van de PCB zowel op soldeer- als op componentzijde.
- Verbindingen moeten minstens 20 mil (0,5 mm) van de zijkant van de PCB verwijderd blijven.

## Bijzondere richtlijnen voor gefreesde printen

Indien uw print zal gemaakt worden met behulp van de LPKF PCB-freesmachine, houdt u zich best aan volgende bijkomende richtlijnen.
- De standaard-afstand tussen de printbanen is 100 mil (wat gelijk is aan de steek of afstand tussen twee pennetjes van een DIL-IC: 100 mil = 0,1" = 2,54 mm). Ga slechts in uitzonderlijke gevallen over naar een afstand van 50 mil; dit zal bv. nodig zijn om een baantje tussen twee pennetjes van een IC door te leggen.
- In de lengterichting van een IC (met 0,3" = 300 mil afstand tussen de twee rijen pennen) kunnen op die manier gemakkelijk twee banen lopen.
- Houd een minimale baanbreedte van 20 mil aan. Slechts in uitzonderlijke gevallen is 10 mil mogelijk
- De minimale clearance of afstand naar een andere baan of pad is 13 mil. Deze clearance kan echter leiden tot soldeerproblemen. De clearance die we verder in deze tekst gebruiken, zal resulteren in een gemakkelijker te solderen print.
- De minimum doormeter van de soldeereilandjes (pads) voor jumpers, vias (doorverbindingen van soldeer- naar componentzijde) en componenten is 80 mil.
- Gebruik indien mogelijk een powerplane