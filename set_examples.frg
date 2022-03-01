#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"
open "set_online_game.frg"
open "set_sequential_game.frg"

example validOnlineGame is generateValidOnlineGame for {
    SetCard = `CARD1 + `CARD2 + `CARD3 + `CARD4 + `CARD5 + `CARD6 + `CARD7 + `CARD8 + `CARD9 + `CARD10 + `CARD11 + `CARD12
    Diamond = `DIAMOND
    Squiggle = `SQUIGGLE
    Oval = `OVAL
    Shape = Diamond + Squiggle + Oval
    Red = `RED
    Purple = `PURPLE
    Green = `GREEN
    Color = Red + Purple + Green
    One = `ONE
    Two = `TWO
    Three = `THREE
    Num = One + Two + Three
    Solid = `SOLID
    Striped = `STRIPED
    Outline = `OUTLINE
    Shading = Solid + Striped + Outline
    shape = 
    `CARD1 -> `SQUIGGLE +
    `CARD2 -> `OVAL +
    `CARD3 -> `SQUIGGLE +
    `CARD4 -> `OVAL +
    `CARD5 -> `OVAL +
    `CARD6 -> `DIAMOND +
    `CARD7 -> `OVAL +
    `CARD8 -> `OVAL +
    `CARD9 -> `SQUIGGLE +
    `CARD10 -> `SQUIGGLE +
    `CARD11 -> `OVAL + 
    `CARD12 -> `SQUIGGLE
    color =
    `CARD1 -> `GREEN +
    `CARD2 -> `GREEN +
    `CARD3 -> `PURPLE +
    `CARD4 -> `GREEN +
    `CARD5 -> `RED +
    `CARD6 -> `RED +
    `CARD7 -> `RED +
    `CARD8 -> `PURPLE +
    `CARD9 -> `GREEN +
    `CARD10 -> `RED +
    `CARD11 -> `RED + 
    `CARD12 -> `GREEN
    num =
    `CARD1 -> `THREE +
    `CARD2 -> `THREE +
    `CARD3 -> `TWO +
    `CARD4 -> `TWO +
    `CARD5 -> `ONE +
    `CARD6 -> `ONE +
    `CARD7 -> `TWO +
    `CARD8 -> `THREE +
    `CARD9 -> `THREE +
    `CARD10 -> `ONE +
    `CARD11 -> `THREE + 
    `CARD12 -> `TWO
    shading =
    `CARD1 -> `SOLID +
    `CARD2 -> `STRIPED +
    `CARD3 -> `SOLID +
    `CARD4 -> `STRIPED +
    `CARD5 -> `STRIPED +
    `CARD6 -> `OUTLINE +
    `CARD7 -> `STRIPED +
    `CARD8 -> `STRIPED +
    `CARD9 -> `STRIPED +
    `CARD10 -> `SOLID +
    `CARD11 -> `STRIPED + 
    `CARD12 -> `STRIPED
    SetSet = `SET1 + `SET2 + `SET3 + `SET4 + `SET5 + `SET6 
    card1 =
    `SET1 -> `CARD1 +
    `SET2 -> `CARD2 +
    `SET3 -> `CARD2 +
    `SET4 -> `CARD4 +
    `SET5 -> `CARD5 +
    `SET6 -> `CARD5
    card2 =
    `SET1 -> `CARD3 +
    `SET2 -> `CARD3 +
    `SET3 -> `CARD8 +
    `SET4 -> `CARD5 +
    `SET5 -> `CARD6 +
    `SET6 -> `CARD7
    card3 =
    `SET1 -> `CARD10 +
    `SET2 -> `CARD6 +
    `SET3 -> `CARD11 +
    `SET4 -> `CARD8 +
    `SET5 -> `CARD10 +
    `SET6 -> `CARD11
}

//12 SetCard, 3 SetSet
// 2 sets are unsolved, 1 set is solved
example validState is wellFormedState for {
    SetCard = `CARD1 + `CARD2 + `CARD3 + `CARD4 + `CARD5 + `CARD6 + `CARD7 + `CARD8 + `CARD9 + `CARD10 + `CARD11 + `CARD12
    Diamond = `DIAMOND
    Squiggle = `SQUIGGLE
    Oval = `OVAL
    Shape = Diamond + Squiggle + Oval
    Red = `RED
    Purple = `PURPLE
    Green = `GREEN
    Color = Red + Purple + Green
    One = `ONE
    Two = `TWO
    Three = `THREE
    Num = One + Two + Three
    Solid = `SOLID
    Striped = `STRIPED
    Outline = `OUTLINE
    Shading = Solid + Striped + Outline
    shape = 
    `CARD1 -> `DIAMOND +
    `CARD2 -> `SQUIGGLE +
    `CARD3 -> `SQUIGGLE +
    `CARD4 -> `OVAL +
    `CARD5 -> `DIAMOND +
    `CARD6 -> `DIAMOND +
    `CARD7 -> `DIAMOND +
    `CARD8 -> `SQUIGGLE +
    `CARD9 -> `DIAMOND +
    `CARD10 -> `OVAL +
    `CARD11 -> `SQUIGGLE + 
    `CARD12 -> `DIAMOND
    color =
    `CARD1 -> `RED +
    `CARD2 -> `RED +
    `CARD3 -> `RED +
    `CARD4 -> `GREEN +
    `CARD5 -> `RED +
    `CARD6 -> `PURPLE +
    `CARD7 -> `GREEN +
    `CARD8 -> `PURPLE +
    `CARD9 -> `RED +
    `CARD10 -> `PURPLE +
    `CARD11 -> `PURPLE + 
    `CARD12 -> `GREEN
    num =
    `CARD1 -> `ONE +
    `CARD2 -> `TWO +
    `CARD3 -> `THREE +
    `CARD4 -> `ONE +
    `CARD5 -> `ONE +
    `CARD6 -> `ONE +
    `CARD7 -> `TWO +
    `CARD8 -> `TWO +
    `CARD9 -> `TWO +
    `CARD10 -> `THREE +
    `CARD11 -> `ONE + 
    `CARD12 -> `THREE
    shading =
    `CARD1 -> `STRIPED +
    `CARD2 -> `STRIPED +
    `CARD3 -> `STRIPED +
    `CARD4 -> `SOLID +
    `CARD5 -> `SOLID +
    `CARD6 -> `SOLID +
    `CARD7 -> `STRIPED +
    `CARD8 -> `SOLID +
    `CARD9 -> `OUTLINE +
    `CARD10 -> `STRIPED +
    `CARD11 -> `SOLID + 
    `CARD12 -> `OUTLINE
    SetSet = `SET1 + `SET2 + `SET3
    card1 =
    `SET1 -> `CARD1 +
    `SET2 -> `CARD4 +
    `SET3 -> `CARD7
    card2 =
    `SET1 -> `CARD2 +
    `SET2 -> `CARD5 +
    `SET3 -> `CARD8
    card3 =
    `SET1 -> `CARD3 +
    `SET2 -> `CARD6 +
    `SET3 -> `CARD9

    State = `STATE
    OnBoard = `ONBOARD
    InDeck = `INDECK
    Solved = `SOLVED
    Position = OnBoard + InDeck + Solved

    gameCards = `STATE -> `CARD1 -> `ONBOARD +
                `STATE -> `CARD2 -> `ONBOARD +
                `STATE -> `CARD3 -> `ONBOARD +
                `STATE -> `CARD4 -> `ONBOARD +
                `STATE -> `CARD5 -> `ONBOARD +
                `STATE -> `CARD6 -> `ONBOARD +
                `STATE -> `CARD7 -> `SOLVED +
                `STATE -> `CARD8 -> `SOLVED +
                `STATE -> `CARD9 -> `SOLVED +
                `STATE -> `CARD10 -> `ONBOARD +
                `STATE -> `CARD11 -> `ONBOARD +
                `STATE -> `CARD12 -> `ONBOARD
    gameSets = `STATE -> `SET1 -> `ONBOARD +
                `STATE -> `SET2 -> `ONBOARD +
                `STATE -> `SET3 -> `SOLVED 
}

//12 SetCard, 3 SetSet
// 2 sets are unsolved, 1 set is solved
// card positions do no follow set positions
example invalidState is not wellFormedState for {
    SetCard = `CARD1 + `CARD2 + `CARD3 + `CARD4 + `CARD5 + `CARD6 + `CARD7 + `CARD8 + `CARD9 + `CARD10 + `CARD11 + `CARD12
    Diamond = `DIAMOND
    Squiggle = `SQUIGGLE
    Oval = `OVAL
    Shape = Diamond + Squiggle + Oval
    Red = `RED
    Purple = `PURPLE
    Green = `GREEN
    Color = Red + Purple + Green
    One = `ONE
    Two = `TWO
    Three = `THREE
    Num = One + Two + Three
    Solid = `SOLID
    Striped = `STRIPED
    Outline = `OUTLINE
    Shading = Solid + Striped + Outline
    shape = 
    `CARD1 -> `DIAMOND +
    `CARD2 -> `SQUIGGLE +
    `CARD3 -> `SQUIGGLE +
    `CARD4 -> `OVAL +
    `CARD5 -> `DIAMOND +
    `CARD6 -> `DIAMOND +
    `CARD7 -> `DIAMOND +
    `CARD8 -> `SQUIGGLE +
    `CARD9 -> `DIAMOND +
    `CARD10 -> `OVAL +
    `CARD11 -> `SQUIGGLE + 
    `CARD12 -> `DIAMOND
    color =
    `CARD1 -> `RED +
    `CARD2 -> `RED +
    `CARD3 -> `RED +
    `CARD4 -> `GREEN +
    `CARD5 -> `RED +
    `CARD6 -> `PURPLE +
    `CARD7 -> `GREEN +
    `CARD8 -> `PURPLE +
    `CARD9 -> `RED +
    `CARD10 -> `PURPLE +
    `CARD11 -> `PURPLE + 
    `CARD12 -> `GREEN
    num =
    `CARD1 -> `ONE +
    `CARD2 -> `TWO +
    `CARD3 -> `THREE +
    `CARD4 -> `ONE +
    `CARD5 -> `ONE +
    `CARD6 -> `ONE +
    `CARD7 -> `TWO +
    `CARD8 -> `TWO +
    `CARD9 -> `TWO +
    `CARD10 -> `THREE +
    `CARD11 -> `ONE + 
    `CARD12 -> `THREE
    shading =
    `CARD1 -> `STRIPED +
    `CARD2 -> `STRIPED +
    `CARD3 -> `STRIPED +
    `CARD4 -> `SOLID +
    `CARD5 -> `SOLID +
    `CARD6 -> `SOLID +
    `CARD7 -> `STRIPED +
    `CARD8 -> `SOLID +
    `CARD9 -> `OUTLINE +
    `CARD10 -> `STRIPED +
    `CARD11 -> `SOLID + 
    `CARD12 -> `OUTLINE
    SetSet = `SET1 + `SET2 + `SET3
    card1 =
    `SET1 -> `CARD1 +
    `SET2 -> `CARD4 +
    `SET3 -> `CARD7
    card2 =
    `SET1 -> `CARD2 +
    `SET2 -> `CARD5 +
    `SET3 -> `CARD8
    card3 =
    `SET1 -> `CARD3 +
    `SET2 -> `CARD6 +
    `SET3 -> `CARD9

    State = `STATE
    OnBoard = `ONBOARD
    InDeck = `INDECK
    Solved = `SOLVED
    Position = OnBoard + InDeck + Solved

    gameCards = `STATE -> `CARD1 -> `ONBOARD +
                `STATE -> `CARD2 -> `ONBOARD +
                `STATE -> `CARD3 -> `ONBOARD +
                `STATE -> `CARD4 -> `ONBOARD +
                `STATE -> `CARD5 -> `ONBOARD +
                `STATE -> `CARD6 -> `ONBOARD +
                `STATE -> `CARD7 -> `SOLVED +
                `STATE -> `CARD8 -> `SOLVED +
                `STATE -> `CARD9 -> `SOLVED +
                `STATE -> `CARD10 -> `ONBOARD +
                `STATE -> `CARD11 -> `ONBOARD +
                `STATE -> `CARD12 -> `ONBOARD
    gameSets = `STATE -> `SET1 -> `SOLVED +
                `STATE -> `SET2 -> `SOLVED +
                `STATE -> `SET3 -> `SOLVED 
}