#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"

pred generateValidOnlineGame {
    generateValidDeck
    generateValidSet
}

// by convention, the online game of set has excatly 12 cards with 6 sets amongst the cards
// the same card may be present in multiple sets
run {
    generateValidOnlineGame
} for exactly 6 SetSet, exactly 12 SetCard
// use set_online_game_vis.js!

// you can have a maximum of 12 sets with 12 cards
test expect {
    validOnlineGame: {
        generateValidOnlineGame
    } for exactly 13 SetSet, exactly 12 SetCard is unsat
}