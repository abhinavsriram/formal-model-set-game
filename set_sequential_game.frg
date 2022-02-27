#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"

sig State {
    gameCards: pfunc SetCard -> Position,
    gameSets: pfunc SetSet -> Position,
    next: lone State
}

pred wellFormedState {
    all s: State | {
        //# of cards in each position is a multiple of 3 (probably not necessary)
        // divide[#{c: SetCard| c.position = InDeck}, 3] = 0
        // divide[#{c: SetCard| c.position = OnBoard}, 3] = 0
        // divide[#{c: SetCard| c.position = Solved}, 3] = 0
        // all solvedSet: SetSet| some i: Int| s.solvedSets[i] = solvedSet implies {

        // all ss: SetSet| s.gameSets[ss] = OnBoard or s.gameSets[ss] = Solved

        
        all solvedSet: SetSet| s.gameSets[solvedSet] = Solved implies {
            all unsolvedSet: SetSet| s.gameSets[unsolvedSet] = OnBoard implies {
                not
                    (
                        (solvedSet.card1 = unsolvedSet.card1 or solvedSet.card1 = unsolvedSet.card2 or solvedSet.card1 = unsolvedSet.card3) and
                        (solvedSet.card2 = unsolvedSet.card1 or solvedSet.card2 = unsolvedSet.card2 or solvedSet.card2 = unsolvedSet.card3) and
                        (solvedSet.card3 = unsolvedSet.card1 or solvedSet.card3 = unsolvedSet.card2 or solvedSet.card3 = unsolvedSet.card3)
                    )
            }
        }
        //cards in a set follow set's position
        // all sets: SetSet| s.gameSets[sets] = OnBoard or s.gameSets[sets] = Solved implies {
        //     s.gameCards[sets.card1] = s.gameSets[sets]
        //     s.gameCards[sets.card2] = s.gameSets[sets]
        //     s.gameCards[sets.card3] = s.gameSets[sets]
        // }
    }
}

pred initState[s: State] {
    //exactly 12 cards on the game board
    #{c: SetCard| s.gameCards[c] = OnBoard} = 12
    all c: SetCard | not s.gameCards[c] = OnBoard implies {
        s.gameCards[c] = InDeck
    }
    //no cards have been solved
    #{c: SetCard| s.gameCards[c] = Solved} = 0
    //no sets have been solved
    #{ss: SetSet| s.gameSets[ss] = Solved} = 0
    //add all solvable sets from the board to gameSets
    all sets: SetSet| s.gameCards[sets.card1] = OnBoard and s.gameCards[sets.card2] = OnBoard and s.gameCards[sets.card3] = OnBoard implies {
        s.gameSets[sets] = OnBoard
    }
}

pred finalState[s: State] {
    //no possible sets on the board
    #{ss: SetSet| s.gameSets[ss] = OnBoard} = 0
    //no cards left in the deck
    #{c: SetCard| s.gameCards[c] = InDeck} = 0
}

// adds 3 cards to the Board
pred addThreeCardsToBoard[pre: State, post: State] {
    some disj c1, c2, c3: SetCard | {
        //move 3 cards from InDeck to OnBoard
        pre.gameCards[c1] = InDeck and post.gameCards[c1] = OnBoard
        pre.gameCards[c2] = InDeck and post.gameCards[c2] = OnBoard
        pre.gameCards[c3] = InDeck and post.gameCards[c3] = OnBoard
        //preserve set position
        all s: SetSet| {
            pre.gameSets[s] = post.gameSets[s]
        }
        //preserve all other card position
        all c: SetCard| c != c1 and c != c2 and c != c3 implies {
            pre.gameCards[c] = post.gameCards[c]
        }
    }
}

pred canTransition[pre: State, post: State] {
    #{c: SetCard| pre.gameCards[c] = OnBoard} < 12 and #{c: SetCard| pre.gameCards[c] = InDeck} > 0 implies {
        //add 3 cards from the deck if there are less than 12 cards on the board
        addThreeCardsToBoard[pre, post]
        //update unsolvedSets
        all sets: SetSet| post.gameCards[sets.card1] = OnBoard and post.gameCards[sets.card2] = OnBoard and post.gameCards[sets.card3] = OnBoard implies {
            post.gameSets[sets] = OnBoard
        }
    } else {
        #{unsolvedSet: SetSet| pre.gameSets[unsolvedSet] = OnBoard} = 0 implies {
            //add 3 cards from the deck if there are no possible sets on the board
            addThreeCardsToBoard[pre, post]
            //update unsolvedSets
            all sets: SetSet| post.gameCards[sets.card1] = OnBoard and post.gameCards[sets.card2] = OnBoard and post.gameCards[sets.card3] = OnBoard implies {
                post.gameSets[sets] = OnBoard
            }
        } else {
            //move a set (3 cards) from OnBoard to Solved
            some solvedSet: SetSet | {
                //moved solvedSet from OnBoard to Solved
                pre.gameSets[solvedSet] = OnBoard
                post.gameSets[solvedSet] = Solved

                //move cards in the solvedSet from OnBoard to Solved
                pre.gameCards[solvedSet.card1] = OnBoard
                pre.gameCards[solvedSet.card2] = OnBoard
                pre.gameCards[solvedSet.card3] = OnBoard
                post.gameCards[solvedSet.card1] = Solved
                post.gameCards[solvedSet.card2] = Solved
                post.gameCards[solvedSet.card3] = Solved

                //TODO: remove all other sets on the board that contains cards of solvedSet
                //for all sets that are not the solved set ->
                    // if set contains same cards as the solved set -> remove from gameSets
                    // else pre=post position
                all s: SetSet| s != solvedSet implies {
                    not (s.card1 = solvedSet.card1 or s.card1 = solvedSet.card2 or s.card1 = solvedSet.card3 or
                    s.card2 = solvedSet.card1 or s.card1 = solvedSet.card2 or s.card2 = solvedSet.card3 or
                    s.card3 = solvedSet.card1 or s.card3 = solvedSet.card2 or s.card3 = solvedSet.card3) implies {
                        pre.gameSets[s] = post.gameSets[s]
                        //sets that share common cards with solvedSet will not be added to post state's gameSets
                    }
                }
                //preserve all other in-game sets positions 
                // all s: SetSet| s != solvedSet and ()) implies {
                //     pre.gameSets[s] = post.gameSets[s]
                // }
                //////////////////

                //cards stay in place if they are not part of the moving/solved set
                all c: SetCard| c != solvedSet.card1 and c != solvedSet.card2 and c != solvedSet.card3 implies {
                    pre.gameCards[c] = post.gameCards[c]
                }
                //update unsolvedSets
                all sets: SetSet| post.gameCards[sets.card1] = OnBoard and post.gameCards[sets.card2] = OnBoard and post.gameCards[sets.card3] = OnBoard implies {
                    post.gameSets[sets] = OnBoard
                }
            }
        }
    }
    
    // if there are less than 12 cards on the board 
    // then add 3 more
    //else 
        //if there is no unsolved set, then add 3 more else
            //one solved set is moved to Solved position
            //cards in the same set are moved to Solved

}

pred transitionStates {
    some init, final: State {
        initState[init]
        finalState[final]
        reachable[final, init, next]
        no final.next
        no s: State| s.next = init
        all s: State| s.next != s
        all s: State| (s != final) implies (some s.next) and canTransition[s, s.next]
    }
}

pred generateInitState {
    one s: State | {
        initState[s]
    }
}

// produces a valid game board
run {
    validDeck
    generateValidSet
    ensureUniqueSets
    eliminateDuplicateSets
    wellFormedState
    transitionStates
} for 6 State, exactly 4 SetSet, exactly 21 SetCard
  for {next is linear}