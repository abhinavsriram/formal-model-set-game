#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"

// cards (and therefore sets) are either on the board, in the deck
// or have been solved and are hence off the board
abstract sig Position {}
one sig OnBoard extends Position {}
one sig InDeck extends Position {}
one sig Solved extends Position {}

// the gameCards pfunc maps cards to positions
// the gameSets pfunc maps sets to positions
// the next field points to the next State
sig State {
    gameCards: pfunc SetCard -> Position,
    gameSets: pfunc SetSet -> Position,
    next: lone State
}

// predicate to define a well formed state
pred wellFormedState {
    all s: State | {
        // no card from a solved set is used in an unsolved set (i.e., a set that is on the board)
        all solvedSet: SetSet | s.gameSets[solvedSet] = Solved implies {
            all unsolvedSet: SetSet | s.gameSets[unsolvedSet] = OnBoard implies {
                not
                    (
                        (solvedSet.card1 = unsolvedSet.card1 or solvedSet.card1 = unsolvedSet.card2 or solvedSet.card1 = unsolvedSet.card3) and
                        (solvedSet.card2 = unsolvedSet.card1 or solvedSet.card2 = unsolvedSet.card2 or solvedSet.card2 = unsolvedSet.card3) and
                        (solvedSet.card3 = unsolvedSet.card1 or solvedSet.card3 = unsolvedSet.card2 or solvedSet.card3 = unsolvedSet.card3)
                    )
            }
        }
        // if a set's cards are on the board then the set is on the board
        all sets: SetSet | s.gameCards[sets.card1] = OnBoard and s.gameCards[sets.card2] = OnBoard and s.gameCards[sets.card3] = OnBoard implies {
            s.gameSets[sets] = OnBoard
        }
        // all sets must be on the board or solved if in gameSets because 
        // sets that are in the deck are never added to gameSets
        all sets: SetSet | some s.gameSets[sets] implies {
            s.gameSets[sets] = OnBoard or s.gameSets[sets] = Solved
        }
    }
}

pred initState[s: State] {
    // exactly 12 cards on the game board
    #{c: SetCard | s.gameCards[c] = OnBoard} = 12
    // if cards are not on the board they must be in the deck at the init state
    all c: SetCard | not s.gameCards[c] = OnBoard implies {
        s.gameCards[c] = InDeck
    }
    // no cards have been solved
    #{c: SetCard | s.gameCards[c] = Solved} = 0
    // no sets have been solved
    #{ss: SetSet | s.gameSets[ss] = Solved} = 0
    // add all solvable sets from the board to gameSets
    all sets: SetSet | s.gameCards[sets.card1] = OnBoard and s.gameCards[sets.card2] = OnBoard and s.gameCards[sets.card3] = OnBoard implies {
        s.gameSets[sets] = OnBoard
    }
}

pred finalState[s: State] {
    // no possible sets on the board
    #{ss: SetSet | s.gameSets[ss] = OnBoard} = 0
    // no cards left in the deck
    #{c: SetCard | s.gameCards[c] = InDeck} = 0
}

// adds 3 cards to the Board
pred addThreeCardsToBoard[pre: State, post: State] {
    some disj c1, c2, c3: SetCard | {
        // move 3 cards from InDeck to OnBoard
        pre.gameCards[c1] = InDeck and post.gameCards[c1] = OnBoard
        pre.gameCards[c2] = InDeck and post.gameCards[c2] = OnBoard
        pre.gameCards[c3] = InDeck and post.gameCards[c3] = OnBoard
        // if a set's cards are on the board then the set is on the board
        all sets: SetSet | post.gameCards[sets.card1] = OnBoard and post.gameCards[sets.card2] = OnBoard and post.gameCards[sets.card3] = OnBoard implies {
            post.gameSets[sets] = OnBoard
        } else {
            // all remaining sets stay in the same position
            pre.gameSets[sets] = post.gameSets[sets]
        }
        // preserve all other card position
        all c: SetCard | c != c1 and c != c2 and c != c3 implies {
            pre.gameCards[c] = post.gameCards[c]
        }
    }
}

pred canTransition[pre: State, post: State] {
    #{c: SetCard | pre.gameCards[c] = OnBoard} < 12 and #{c: SetCard | pre.gameCards[c] = InDeck} > 2 implies {
        // add 3 cards from the deck if there are less than 12 cards on the board and at least 3 cards in the deck
        addThreeCardsToBoard[pre, post]
    } else {
        #{unsolvedSet: SetSet | pre.gameSets[unsolvedSet] = OnBoard} = 0 implies {
            // add 3 cards from the deck if there are no possible sets on the board
            addThreeCardsToBoard[pre, post]
        } else {
            some solvedSet: SetSet | {
                // move solvedSet from OnBoard to Solved
                pre.gameSets[solvedSet] = OnBoard
                post.gameSets[solvedSet] = Solved
                // move cards in the solvedSet from OnBoard to Solved
                pre.gameCards[solvedSet.card1] = OnBoard
                pre.gameCards[solvedSet.card2] = OnBoard
                pre.gameCards[solvedSet.card3] = OnBoard
                post.gameCards[solvedSet.card1] = Solved
                post.gameCards[solvedSet.card2] = Solved
                post.gameCards[solvedSet.card3] = Solved
                // remove all other sets on the board that contains cards of solvedSet
                // if a set contains same cards as the solved set -> remove from gameSets
                all s: SetSet | s != solvedSet implies {
                    not 
                    (
                        s.card1 = solvedSet.card1 or s.card1 = solvedSet.card2 or s.card1 = solvedSet.card3 or
                        s.card2 = solvedSet.card1 or s.card1 = solvedSet.card2 or s.card2 = solvedSet.card3 or
                        s.card3 = solvedSet.card1 or s.card3 = solvedSet.card2 or s.card3 = solvedSet.card3
                    ) 
                    implies {
                        // sets that share common cards with solvedSet will not be added to the post state's gameSets
                        pre.gameSets[s] = post.gameSets[s]
                    }
                }
                // cards stay in place if they are not part of the moving/solved set
                all c: SetCard | c != solvedSet.card1 and c != solvedSet.card2 and c != solvedSet.card3 implies {
                    pre.gameCards[c] = post.gameCards[c]
                }
            }
        }
    }
}

pred transitionStates {
    some init, final: State {
        // no 2 succcessive states are identical
        all s: State | {
            s.next != s
        }
        // constrains on init state
        no s: State | {
            s.next = init
        }
        initState[init]
        // constraints on final state
        no final.next
        finalState[final]
        // link init to final state via gwnext
        reachable[final, init, next]
        // valid transitions
        all s: State | some s.next implies {
            canTransition[s, s.next]
        }
    }
}

// note: this seems to run reasonably fast upto the following configuration:
// 8 State, exactly 4 SetSet, exactly 21 SetCard
// anything beyond this takes way too long so it was hard to verify if properties held as expected
// but a simulation of the real life sequential game would be with 81 SetCards

// produces a valid sequential game board
run {
    generateValidDeck
    generateValidSet
    setsShareNoCard
    wellFormedState
    transitionStates
} for 8 State, exactly 4 SetSet, exactly 21 SetCard
  for {next is linear}
  // use set_sequential_game_vis.js!
  // NOTE: for better viewing, zoom out (CTRL/CMD -) until each state takes up a single row!

test expect {
    validSequence: {
        generateValidDeck
        generateValidSet
        setsShareNoCard
        wellFormedState
        transitionStates
        ensureUniqueSets
    } for 8 State, exactly 4 SetSet, exactly 21 SetCard for {next is linear} is sat

    // the game requires to solve all sets and get rid of all cards in the deck
    // Thus, number of states should at least be (1 + #SetSet + (#SetCard - 12)/3)
    tooLittleStates: {
        generateValidDeck
        generateValidSet
        setsShareNoCard
        wellFormedState
        transitionStates
        ensureUniqueSets
    } for 2 State, exactly 2 SetSet, exactly 15 SetCard for {next is linear} is unsat

    // The game requires there to be at least 12 SetCards. 
    // If so, the number of cards should at least be #SetSet*3
    tooLittleCards: {
        generateValidDeck
        generateValidSet
        setsShareNoCard
        wellFormedState
        transitionStates
        ensureUniqueSets
    } for 4 State, exactly 5 SetSet, exactly 12 SetCard for {next is linear} is unsat
}
