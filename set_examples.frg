#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

open "set_common.frg"
open "set_online_game.frg"

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
    `CARD3 -> `GREEN +
    `CARD4 -> `RED +
    `CARD5 -> `RED +
    `CARD6 -> `PURPLE +
    `CARD7 -> `GREEN +
    `CARD8 -> `PURPLE +
    `CARD9 -> `RED +
    `CARD10 -> `PURPLE +
    `CARD11 -> `PURPLE + 
    `CARD12 -> `RED
    num =
    `CARD1 -> `ONE +
    `CARD2 -> `THREE +
    `CARD3 -> `TWO +
    `CARD4 -> `TWO +
    `CARD5 -> `THREE +
    `CARD6 -> `THREE +
    `CARD7 -> `TWO +
    `CARD8 -> `TWO +
    `CARD9 -> `TWO +
    `CARD10 -> `THREE +
    `CARD11 -> `ONE + 
    `CARD12 -> `ONE
    shading =
    `CARD1 -> `STRIPED +
    `CARD2 -> `OUTLINE +
    `CARD3 -> `STRIPED +
    `CARD4 -> `OUTLINE +
    `CARD5 -> `SOLID +
    `CARD6 -> `SOLID +
    `CARD7 -> `OUTLINE +
    `CARD8 -> `OUTLINE +
    `CARD9 -> `OUTLINE +
    `CARD10 -> `STRIPED +
    `CARD11 -> `SOLID + 
    `CARD12 -> `OUTLINE
    SetSet = `SET1 + `SET2 + `SET3 + `SET4 + `SET5 + `SET6 
    card1 =
    `SET1 -> `CARD1 +
    `SET2 -> `CARD1 +
    `SET3 -> `CARD1 +
    `SET4 -> `CARD2 +
    `SET5 -> `CARD2 +
    `SET6 -> `CARD4
    card2 =
    `SET1 -> `CARD3 +
    `SET2 -> `CARD5 +
    `SET3 -> `CARD6 +
    `SET4 -> `CARD3 +
    `SET5 -> `CARD4 +
    `SET6 -> `CARD7
    card3 =
    `SET1 -> `CARD10 +
    `SET2 -> `CARD9 +
    `SET3 -> `CARD7 +
    `SET4 -> `CARD11 +
    `SET5 -> `CARD12 +
    `SET6 -> `CARD8
}