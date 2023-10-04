# Game of Goose

## Introduction

Creating a Game of Goose in .NET and Unity to practise the SOLID principles.

---

## Analysis

### Rules

[Game of the Goose Rules by Masters Traditional Games](https://www.mastersofgames.com/rules/goose-game-rules.htm)

#### Equipment

The game is played on a spiral shaped board consisting of 63 spaces. There are four differently coloured pieces – often in the shape of a goose – and two six-sided dice.  

#### Preparation and Objective

Pieces are placed on the starting space at the outside of the spiral.
Highest roll of the dice starts.  
The Game of Goose is a simple race game – first person to reach space 63 wins.  

#### Play

Players take turns to roll the dice and moved their piece forward by the sum of the two dice.  
- If your first throw is 6 and 3, move to space **26**.
- If your first throw is 5 and 4, move to space **53**.
- If a piece lands on an enemy piece, the enemy piece is returned to the space that the piece started from in that turn (i.e. the two pieces swap places).
- If a piece lands on a space with *a picture of a goose*, it moves forward by the same amount again. If this causes the piece to land on another goose, it moves forward again in the same way. These spaces are typically 5, 9, 14, 18, 23, 27, 32, 36, 41, 45, 50, 54, and 59.

The following spaces are called Hazard spaces and are usually illustrated to match their name. If a piece lands on the space indicated, that piece must follow the stated rule.  
  
- **6 – _The Bridge_** – Go to space 12.
- **19 – _The Hotel_** – Stay for (miss) one turn.
- **31 – _The Well_** – Wait until someone comes to pull you out – they then take your place.
- **42 – _The Maze_** – Go back to space 39 (or space 30 in most French games).
- **52 – _The Prison_** – Wait until someone comes to release you – they then take your place.
- **58 – _Death_** – Return your piece to the beginning – start the game again.
- (**61 – _Drink_ –** Many German boards feature an additional Hazard space on space 61. Typically illustrated with a glass of drink. If a piece lands on this space, the player has to finish his drink!)

![[Simple.png]]

#### Winning the Game

To win the game, a piece must land exactly on space 63.  
If a player throws too many, the piece counts the extra points backwards from the winning space. If you then land on a goose space, you must continue moving backwards by the amount of your throw until you land on a space with no goose space. If you land on the Death space, you must start again.  

#### Variation – Gambling / Grown-up Version

The game would more often have been a gambling game in centuries past. At the beginning, the stake would be decided, and each player would put one stake in the Pool. Then, each time one of the following events occur, the Pool increases:  
  
- When one piece lands on another, swapping places with it, both players pay a stake to the Pool
- When a piece lands on any Hazard space, the player pays a stake to the Pool
  
The winner takes the Pool at the end of the game. 

### Terminology

- ***Turn***: a turn is complete once a player has gone through all his phases or passed his turn to the next player.
- ***Round***: a round is complete once all players have had a turn. A round is divided into several phases. Each phase, all players get one turn to act.
- ***Space***: a is an area on the game board with a specific position.
- ***Position***: the position of a space indicates where it is on the game board. Consequently the position of the player/piece indicates on which space it is standing.

### Elements

- Game
	- Player (Piece, Goose)
	- Dice
	- Board (consisting of Spaces)

-  Space
	- Factory for Spaces

- Processor

- Frontend:
	- Logger to Console
	- Program (is Console App's front-end)


---

## Development

### .NET Library (Plugin)

An assignment for *dotNet academy* to practice the SOLID programming principles.
The assignment is to make a .NET Core application, but the same code can be used in a .NET Library which can be used as a plugin in Unity. This way it can be used as backend with a Unity 3D frontend.

### Unity

#### Dice Roll

A 3D dice roll using physics in Unity.

[How To Create a Dice Rolling Mechanic in Unity | Game Dev Tutorial by Dan Pos](https://www.youtube.com/watch?v=cd66wLNvVh8)
[Physics-Based Dice Rolling in Unity3D by Manie Makes Games](https://www.youtube.com/watch?v=0-v4CbuJ5jI)

#### Board



---

## Vragen

- In het voorbeeld zitten speciale spepregels zoals Eerste worp in `Processor` verspreid in twee methoden: `TurnLogic` en `HandleEdgeCasesOnFirstTurn` met hard-coded values.
  Een andere regel, de overshoot op het einde, zit dan weer in `Piece` in methode `CalculateDestination` die aangeroepen wordt door `MovePiece` die enkel `int diceroll` meekrijgen.
  Dit is toch niet echt Open/Closed?
  
- De `MovePiece`methode  van `Piece` beweegt de `Piece` mogelijks zelfs niet, dus dit hoort niet thuis in `Piece` lijkt mij?

- Waarom zou je een Singleton gebruiken tegenover gewoon meegeven waar nodig?
  Is een Singleton niet moeilijk om te testen?
  In the Piece class word op verschillende plaatsen `GameBoard.GetInstance()` gedaan, voor  `GameBoard.GetInstance().GetAmountOfSpaces()` en `GameBoard.GetInstance().GetSpace(spaceNumber);`. 
  Waarom niet meegeven met methode?
  Zou het gebruik van een Singleton voor een Logger niet logischer zijn?

- Processor:
	- Hoe beslis je wat je van object instanties mee geeft aan de Constructor van de Processor, en welke je erin aanmaakt.
	  In het voorbeeld wordt de Logger en GameBoard in Program aangemaakt en meegegeven aan de Processor. Maar de Dice en Piece instanties pas in methoden van de Processor.