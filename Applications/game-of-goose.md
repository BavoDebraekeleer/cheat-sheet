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
- If your first throw is 9, by either rolling:
	- 6 and 3, move to space **26**.
	- 5 and 4, move to space **53**.
- If a piece lands on an enemy piece, the enemy piece is returned to the space that the piece started from in that turn (i.e. the two pieces swap places).
- If a piece lands on a space with *a picture of a goose*, it moves forward by the same amount again. If this causes the piece to land on another goose, it moves forward again in the same way. These spaces are typically 5, 9, 14, 18, 23, 27, 32, 36, 41, 45, 50, 54, and 59.

The following spaces are called Hazard spaces and are usually illustrated to match their name. If a piece lands on the space indicated, that piece must follow the stated rule.  
  
- **6 – _The Bridge_** – Go to space 12.
- **19 – _The Hotel/Inn_** – Stay for (miss) one turn.
- **31 – _The Well_** – Wait until someone comes to pull you out – they then take your place.
- **42 – _The Maze_** – Go back to space 39 (or space 30 in most French games).
- **52 – _The Prison_** – Wait until someone comes to release you – they then take your place, or wait for 3 turns.
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


---

### Alternative Rules

#### Betting

***Betting***: Each game has a minimum bet of 6.000 coins, so to play any game you will need to bet 6.000 or more of your coins depending on the game. The winner of the match will win coins off other users and points according to the amount of coins won. Remember that if you leave a started game you forfeit your coins for that game. 

***Objective***: Walk through the whole board the faster you can, getting into the space: number 63, “The garden of the geese”. How to play The game of the Goose is a board game for 2 to 4 players each with a colored piece. The spiral shaped board has 63 spaces numbered from 1 to 63 with different drawings. Depending on the space you enter, you piece will advance, move back or suffer a penalty. 

In a turn a player rolls a dice wich indicates the number of spaces to advance. The space 63 can only be entered with an exact roll. If a player rolls and gets a higher number than the number of remaining spaces to the goal, the player will advance to the space 63 and then go back until completing the number rolled. 

Special spaces Goose [1,5, 9,14, 18, 23, 27, 32, 36, 41, 45, 50, 54, 59, 63] “From goose to goose, faster than a moose”. Advance to the next goose and reroll. 

Bridge [6,12] “From bridge to bridge, I roll as I reach”. Advance or go back to the other bridge and reroll. 

Dices [26,53] “From dice to dice, I roll to win the prize”. Advance or go back to the other dices and reroll. 

Inn [19] You stay in the Inn and loose 2 turns. 

Jail [56] You’re staying in the Jail for 3 turns. 

Well [31] You stay in the well until another player passes over it, or for 4 turns. 

Mace [42] “Lost in the Mace”. Go back to the space 30. 

Death [58] You start from the beginning. 

#### Greek Historic Version

History tells a Greek legend that during the siege of Troy, the green warriors were so bored that they invented different games to entertain themselves. One of these games the “the Game of the Goose” and it is said to be invented by Palamedes, son of Euboea’s King and Poseidon’s niece. In 1908 an archaeological artefact dated from the 2000 BC was discovered in Crete and called “the Phaistos Disc”. Historians say it is an ancient Goose game board. Another legend attributes the invention of the game to the Order of the Holy Templars, created in 1118 by the European crusaders. 
It is thought that the 63 spaces of the board correspond to the 63 segments in the nautilus shells, and originally they were used as boards. It is also said that the Goose, Inn, Well, Jail and the rest of the symbols in the game represent some of the keys of the philosophy. There are also other theories that relates the game with the Spanish “Camino de Santiago”. Others have a theory that says it is a German game from the XI century, but this has very little proofs. And one of the most reliable versions says that the game was invented in Florence, in the court of the Medici, whose members used to give it as a present. Although the game’s origin is not clear, it is played worldwide nowadays.

#### La Oca

La Oca is a spectacular game that brings many people together to have fun. If you are one of the people who enjoys board games, you will like to learn how to play goose, Although it seems complicated, we can assure you that it is quite easy to play it if you know what it is about. In this article we are going to teach you what are the instructions that you must follow to play the goose, as well as the strategies to implement for you to win and thus become an expert in this wonderful game. 

What is the game of the Goose? To learn how to play goose you must mainly learn what it consists of. The game of the goose is a board game which can be played between two or more players, Each player has to advance the piece they have chosen through a board that has a spiral shape, it has 63 squares. Each of these boxes has a number, it goes from number 1 to number 63 and you can see that in each of these boxes there is a drawing. Everything will depend on the square in which you are going to fall to be able to advance or otherwise go back, in each of these a number is indicated. penance to be fulfilled by each participant. On each player's turn, he has to roll two dice and they will indicate the number of squares to be advanced. As you can see, the game itself doesn't sound complicated at all, if you're interested now that you know it's the same, it's time to learn its rules. How to play goose? General rules for this game If you want to know what the general rules for this game are, they are the following: It is necessary a minimum number of players and this is from Both of you in order to start the game. The ages that are generally used to play goose are since 8 years up to a maximum age of 99, as you can see is a very wide age range for the game. Each of the players will have a token that identifies them. All the chips have different colors to distinguish each one of them. This game aims get to the center of the board first, with the intention of reaching the great Goose. Turns must be respected for the throwing of the dice, only the game is the one who decides when it is time to break this rule. The rules do it very often so that everyone is prepared. As for the dice, can be played with one or two. The squares on the board are all numbered, many of which have special meanings. In general, these are the same, although there are currently some Oca games that circulate with various novelties. 

##### Single Die Rules

Rules for playing Oca with a single dice As mentioned above, this game can be played with a single die, although we must warn you that So it's a little slower To learn how to play Oca in this way, the rules are as follows: 

You must throw the dice and advance according to the number that this dice says. 

If as a player you land on any of these boxes (5, 9, 14, 18, 23, 27, 32, 36, 41) you will be earning the right to advance to the next space Oca, you can also repeat this shot, this is something not bad. 

If you manage to land on a square that is a bridge (6 and 12) you will have to advance to a square known as POSADA, which would be 19, here you will lose your turn since the inn is for sleeping. 

The moment a player lands directly on this square (Inn, 19) by throwing the die, he has to spend a turn without playing because he is "sleeping". 

If when playing you land on the WELL box (it is 31) you will have problems. You can't roll the dice again until another player passes by, you depend on another for your rescue. 

If you are unlucky enough to land on box 42 (Labyrinth) you will have to go straight back to box 30. 

If you happen to fall into the box JAIL (box 56) you will think it is serious, but you will only spend two turns without playing. 

There are two boxes called DADOS (box 26 and 53) here you must add the number of the box plus the number that the dice says when throwing it. If it is square 26 and you roll a 6 you must advance 32 steps. 

There is a square from hell called CALAVETA (square 58), this makes you return to square 1 of the game. 

The entrance to the Garden of the Goose: When you get here you should expect the die to give you the exact number of steps to enter. If the dice does not help you, you will have moments of anxiety because when the dice says more than what you lack, you will have to retract the remainder. 

##### Two Dice Rules

Rules to play the Oca with 2 dice If you opt for the faster option which is to play with 2 dice, there are few differences and the rules are as follows: 

When the game starts, there is a rule that is special for all cases where the sum is 9, this happens in two ways: 5 and 4 (You can advance directly to square 53) if the sum gives 3 and 6 you must advance to box 26 and the same thing happens that we explained to you before. 

***The dice boxes that are 26 and 53, have the rule that when adding you have to include the roll of the dice.*** 

***From square 60 onwards, you have to stop using a die and only play with one until the end.*** 

#### Different Goose Space Rule

The Goose Game, also known as the Game of the Goose, is a classic board game that originated in the 16th century. The game involves racing geese around a track and has simple objectives. Here's how to play and the main objectives of the Goose Game:Setup: The Goose Game is played on a game board consisting of a spiral track with spaces numbered consecutively. Each player chooses a token or marker to represent their goose on the board.

Objective: The main objective of the Goose Game is to be the first player to reach the final space on the board, typically labeled with "Finish" or the highest number. The game is a race to the end, and the player who reaches the finish space first is the winner.Turns and 

Movement: Players take turns in clockwise order. On your turn, roll a die or use a spinner to determine the number of spaces to move your goose forward. Move your goose along the track according to the number rolled.

Special Spaces: The track consists of regular spaces and special spaces that have specific effects when landed on. For example:

***Goose Spaces: If you land on a space marked with a goose, move your goose ahead to the next space with a goose and take another turn.***

Bridge Spaces: If you land on a space with a bridge, move your goose to the corresponding space on the opposite side of the bridge, effectively "jumping" over some spaces.

Well Spaces: If you land on a well space, skip the next turn as a penalty.

Maze Spaces: If you land on a maze space, follow the instructions to move forward or backwards, as indicated by arrows.

Inn Spaces: If you land on an Inn space, rest for a turn and skip the next player's turn.

Etiquette and Rules: The Goose Game may have additional rules or variations depending on the version being played. It's important to follow the rules agreed upon before the game starts, such as the number of spaces to move, how to handle special spaces, and any specific rules for winning.

Enjoyment and Social Interaction: The Goose Game is known for its simplicity and enjoyable gameplay, making it suitable for players of all ages. It provides opportunities for social interaction and friendly competition as players race to reach the finish space first.

Remember, the specific rules and variations of the GooseGame can differ depending on cultural adaptations or specific editions. Always refer to the rules provided with the game set you're playing or agree upon rules before starting the game.Have fun playing the Goose Game and may your goose race swiftly to the finish! Instructionsusing mouse Discuss GooseGame