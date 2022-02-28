# README

We are trying to model the game Set. This is quite ironic given we did it in Froglet, our lives would have likely been infinitely easier had we used full Forge but we decided to stick to Froglet to give ourselves a challenge.

The objective of the game is to identify a SET of 3 cards from 12 cards placed face up on the table. A SET consists of 3 cards in which each of the cards’ features, looked at one‐by‐one, are the same on each card, or, are different on each card. All of the features must separately satisfy this rule. set_common.frg models this requirement and documents with in-line comments, in detail, exactly how we went about this as well as why each of our sigs exist. We have tried to make all our code as readable as possible so simply reading through the file and the comments should make all our modeling choices self-explanatory. There are 3 tests at the bottom of the file that verify certain mathematical properties of the game but these are too large for Forge to run.

There are 2 variants of the game we separately modeled. The online variant of the game was modeled in set_online_game.frg and has a visualizer set_online_game_vis.js. https://www.setgame.com/set/puzzle is where the original online puzzle lives. A new puzzle releases every 24 hours. This variant of the game is pretty simple. 12 random cards (from the deck of 81 cards since there are 4 attributes with 3 values each we get 3^4 cards) are placed face up on the table and those 12 cards have 6 sets amongst them. In this variant of the game sets can share a card i.e., a single card can be part of multiple sets which is why the setsShareNoCard pred in set_common.frg is not used in the generateValidSet pred that is used in set_online_game.frg. Our visualizer shows you the 12 random cards as well as the 6 sets within them. We also wrote out an example in set_examples.frg that verifies the solution to a past online game from https://www.setgame.com/set/puzzle. Simply running the provided run statement in set_online_game.frg should run the game. Feel free to play around with the numbers should you want to experiment with reasonably larger games.

The real life sequential variant of the game was the one that was much harder to model. We modeled this (in set_sequential_game.frg with a separate visualizer in set_sequential_game_vis.js) nearly identically to the real life game. The following is a description of the real life game. The dealer shuffles the cards and lays 12 face up on the table (in a rectangle) so that they can be seen by all. Players remove SETs of 3 cards from anywhere on the table. Each SET is checked by the other players. If correct, the SET is kept by the player for one point and the dealer replaces the 3 cards with 3 from the deck. A player must call SET before picking up the cards. There are no turns, the first player to call SET gets control of the board. After he/she has called SET, no other player can pick up cards until that player has finished. The SET must be picked up within a few seconds after calling it. If a player calls SET and does not have one, or if the SET is incorrect, he/she loses one point, and the 3 cards are returned to the table. If all players agree that there is not a SET in the 12 cards, 3 more cards are laid face up on the table. The 3 cards are not replaced when the next SET is found, reducing the number back to 12. Note: There are approx. 33:1 odds that a SET is present in 12 cards and approx. 2500:1 odds when 15 cards are on the table. The play continues until the deck is depleted. At the end of the game there may be cards remaining that do not form a SET. The number of SETs held by each player is then counted. One point is given for each SET. High score wins. 

Some of the abstraction choices we made and/or were made for us based on the way we designed the game thus far were:
1. There is no notion of players or points, for obvious reasons.
2. The deck is always a multiple of 3 so all cards from the deck are exhausted (i.e., they are on the table/board).
3. We define the number of sets that exist in the game so the game ends when all sets have been found.

The initial state involves 12 random cards (from the deck of 81 cards) being placed face up on the table. The transitions are modeled as follows. If there is no set amongst the 12 then 3 cards are added from the deck, this process continues until at least 1 set exists. If a set exists, the transition involves the identification of a set and it being marked Solved (this causes the set to show up under the "Solved Sets" box in the visualizer). If there are less than 12 cards then 3 are added to the table/board. The "Universal Sets" box in the visualizer shows all possible sets that exist in the current deck of cards and the "Unsolved Sets" box in the visualizer shows all possible sets currently on the board.

The transitions were modeled following a framework very similar to the one presented in the Forge 2 assignment. Once again, we have tried to make all our code as readable as possible so simply reading through the file and the very detailed in-line comments should make all our modeling choices self-explanatory. Simply running the provided run statement in set_sequential_game.frg should run the game. As mentioned, this seems to run reasonably fast upto the following configuration: 8 State, exactly 4 SetSet, exactly 21 SetCard, anything beyond this takes way too long so it was hard to verify if properties held as expected, but a simulation of the real life sequential game would be with 81 SetCards. If this is also too slow then moving to 6 State, exactly 2 SetSet, exactly 15 SetCard should most certainly work.