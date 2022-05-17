# README

### What are we modeling?
We are trying to model the game SET. This is quite ironic given that we are using Froglet. Our lives would have likely been infinitely easier had we used full Forge but we decided to stick to Froglet to give ourselves a challenge.

### High level objective of the game we are modeling
The objective of the game is to identify a set of 3 cards from 12 cards placed face up on the table. A set consists of 3 cards in which each of the cards’ features, looked at one‐by‐one, are the same on each card, or are different on each card. All of the features must separately satisfy this rule. 

### set_common.frg
set_common.frg models the aforementioned feature of the game and documents exactly how we went about this as well as why each of our sigs exist with in-line comments. We have tried to make all our code as readable as possible so simply reading through the code and the corresponding comments should make all our modeling choices self-explanatory. There are 2 tests at the bottom of set_common.frg that verify certain mathematical properties of the game but these are too large for Forge to run.

### Summary of sig choices
To summarize our sig choices, we decided to model the cards themselves, which requires a sig (SetCard) as well as its physical characteristics, each of which is an abstract sig with 3 concrete implementations. We needed a way to identify a set, which is why we made a sig (SetSet) for that as well. For one of two game variants (which will be described in more detail below), we created a sig (State) that represents sets being solved and cards being moved to allow us to generate traces simulating game play.

### Online variant of the game and set_online_game.frg
The online variant of the game was modeled in set_online_game.frg and has a visualizer in set_online_game_vis.js. https://www.setgame.com/set/puzzle is where the original online puzzle lives. A new puzzle releases every 24 hours. This variant of the game is pretty simple. 12 random cards (from the deck of 81 cards since there are 4 attributes with 3 values each) are placed face up on the table and those 12 cards have 6 sets amongst them. In this variant of the game, sets can share a card i.e., a single card can be part of multiple sets which is why the setsShareNoCard pred in set_common.frg is not used in the generateValidSet pred. Our visualizer shows you the 12 random cards as well as the 6 sets amongst them. We also wrote out an example in set_examples.frg that verifies the solution to a past online game from https://www.setgame.com/set/puzzle. Simply running the provided run statement in set_online_game.frg should run the game.

### Real life variant of the game
The real life sequential variant of the game was the one that was much harder to model. We modeled this in set_sequential_game.frg with a separate visualizer in set_sequential_game_vis.js. The following is a description of the real life game. The dealer shuffles the cards and lays 12 face up on the table so that they can be seen by all. Players remove sets of 3 cards from anywhere on the table. Each set is checked by the other players. If correct, the set is kept by the player for one point and the dealer replaces the 3 cards with 3 from the deck. A player must call set before picking up the cards. There are no turns, the first player to call set gets control of the board. After they have called set, no other player can pick up cards until that player has finished. The set must be picked up within a few seconds after calling it. If a player calls set and does not have one, or if the set is incorrect, they lose one point, and the 3 cards are returned to the table. If all players agree that there is not a set in the 12 cards, 3 more cards are laid face up on the table. The 3 cards are not replaced when the next set is found, reducing the number back to 12. Note: There are approx. 33:1 odds that a set is present in 12 cards and approx. 2500:1 odds in 15 cards. The play continues until the deck is depleted. At the end of the game there may be cards remaining that do not form a set. The number of sets held by each player is then counted. One point is given for each set. Highest score wins. 

### Abstraction choices
Some of the abstraction choices we made and/or were made for us based on the way we designed the game thus far were:
1. There is no notion of players or points, for obvious reasons (Forge is always correct).
2. The deck is always a multiple of 3 so all cards from the deck are exhausted by the final state (i.e., they are on the table/board).
3. We define the number of sets that exist in the game so the game ends when all the defined sets have been found.

### set_sequential_game.frg
The initial state involves 12 random cards (from the deck of 81 cards) being placed face up on the table. The transitions are modeled as follows. If there is no set amongst the initial 12 cards then 3 cards are added from the deck, this process continues until at least 1 set exists. If a set exists, the transition involves the identification of a set and it being marked Solved which causes the set to show up under the "Solved Sets" box in the visualizer. If there are less than 12 cards then 3 are added to the table/board. The "The n total sets to solve" box in the visualizer shows all possible sets that exist in the current deck of cards and the "Sets to solve on the board" box in the visualizer shows all possible sets currently on the board.

note: The visualizer has many elements and so will be hard to see unless you zoom out to 30% (or less) on most screens. After zooming out (using CTRL/CMD -) you can pinch to zoom on your trackpad to get a better look. Once each state in the trace looks like the example below, you have zoomed out sufficiently.

![alt text](https://raw.githubusercontent.com/abhinavsriram/formal-model-set-game/master/set_sequential_game_vis_image.png)

The transitions were modeled following a framework very similar to the one presented in the Forge 2 assignment. Once again, we have tried to make all our code as readable as possible so simply reading through the file and the very detailed in-line comments should make all our modeling choices self-explanatory. Simply running the provided run statement in set_sequential_game.frg should run the game. As mentioned, this seems to run reasonably fast up to the following configuration: 8 State, exactly 4 SetSet, exactly 21 SetCard, anything beyond this takes way too long so it was hard to verify if properties held as expected, but a simulation of the real life sequential game would be with 81 SetCards. If you would like to run other configurations, ensure that the #State = (1 + #SetSet + (#SetCard - 12)/3)
