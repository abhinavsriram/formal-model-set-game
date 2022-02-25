#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"

sig State {
    board: func Int -> Int -> SetCard
}

pred wellFormedState {
    all s: State | {
        all row, col: Int | {
            // no more than 3 rows and 4 columns for 12 cards
            (row < 0 or row > 2 or col < 0 or col > 3) 
            implies no s.board[row][col]    
        }
    }
}

pred initState[s: State] {
    validDeck
    all row, col: Int | {
        // fill 3 rows and 4 columns with 12 cards
        some sc: SetCard | {
            s.board[row][col] = sc
        }    
    }
}

pred generateInitState {
    one s: State | {
        initState[s]
    }
}

// produces a valid game board
run {
    wellFormedState
    generateInitState
} for 6 SetSet, exactly 81 SetCard