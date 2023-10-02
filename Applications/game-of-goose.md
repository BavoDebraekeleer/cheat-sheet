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


### Components

- Goose:
	- Space position 0 to 63.
	- isSkip flag for if player needs to skip a turn.
	- Take x amount off steps.

- Dice:
	- Roll 2x 6-sided dice.
	- Returns both numbers to be able to perform rule checks on both (2x int).

- Rule:
	- Dice Rule:
		- Position is 0
		- Logic
	- Space Rule:
		- Position
		- Logic

- Rule check 1: first dice roll:
	- If your first throw is 6 and 3, move to space **26**.
	- If your first throw is 5 and 4, move to space **53**.
	- Takes throw (2x int), returns space (int).

- Rule check 2: space occupied:
	- If a piece lands on an enemy piece, the enemy piece is returned to the space that the piece started from in that turn (i.e. the two pieces swap places).

- Rule check 3: space type:
	- If a piece lands on a space with *a picture of a goose*, it moves forward by the same amount again. If this causes the piece to land on another goose, it moves forward again in the same way. These spaces are typically 5, 9, 14, 18, 23, 27, 32, 36, 41, 45, 50, 54, and 59.
	- Hazard spaces (see [[game-of-goose#Rules#Play]])


### Flow

1. Select current turn Goose
2. Dice roll
3. Rule check 1 – Dice: 
	1. If first dice roll / position is 0, check both numbers.
4. Get all Goose's positions.
5. Calculate current turn Goose's new position.
6. Rule check 2 & 3 – Space: 
	1. Check new position against all Goose's positions.
	2. If space occupied, check if space is 31 or 52.
	3. If not, swap both Goose's positions.


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



