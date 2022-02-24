#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"

pred generateValidOnlineGame {
    validDeck
    generateValidSet
}

// write something in the visualizer that shows what the 6 sets are
// write 2 states where first state is the 12 cards and second state is the 6 sets

// by convention, the online game of set has excatly 12 cards with 6 sets amongst the cards
// the same card may be present in multiple sets
run {
    generateValidOnlineGame
} for exactly 6 Set, exactly 12 SetCard
